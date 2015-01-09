<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Case_Status_reopened</fullName>
        <field>Status</field>
        <literalValue>Reopened</literalValue>
        <name>Case Status - reopened</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Create_new_case_email_check</fullName>
        <field>Create_new_case_email__c</field>
        <literalValue>1</literalValue>
        <name>Create new case email check</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Updated_by_cust</fullName>
        <field>Status</field>
        <literalValue>Updated by customer</literalValue>
        <name>Status-Updated by cust</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_pending_solution_sent</fullName>
        <field>Status</field>
        <literalValue>Pending - solution sent</literalValue>
        <name>Status-pending solution sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Sent</fullName>
        <description>Updates field to show agent has sent an email</description>
        <field>First_Response_Sent__c</field>
        <literalValue>1</literalValue>
        <name>Update Email Sent</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Email_Sent_Time</fullName>
        <field>First_Response_Sent_DateTime__c</field>
        <formula>NOW()</formula>
        <name>Update Email Sent Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>ParentId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>WF_Case updated by customer</fullName>
        <actions>
            <name>Status_Updated_by_cust</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed,Reopened</value>
        </criteriaItems>
        <description>triggers when an inbound email is received
this wf updates the case status to Updated by Customer when an email is received</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_No reopen closed case</fullName>
        <actions>
            <name>Create_new_case_email_check</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>triggers if an email is received to a closed case outside of the reopening period</description>
        <formula>AND (
     Parent.Re_open_limit__c &lt; NOW(),
     Parent.IsClosed = TRUE,
      Incoming = TRUE
     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Outbound email with attachment</fullName>
        <actions>
            <name>Status_pending_solution_sent</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>EmailMessage.HasAttachment</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>EmailMessage.Incoming</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>triggers when an email is sent with an attachment
used to trigger the change of the case status to Pending - Solution sent</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Reopen closed case</fullName>
        <actions>
            <name>Case_Status_reopened</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>triggers if an email is received to a closed case within the reopening period</description>
        <formula>AND (
     Parent.Re_open_limit__c &gt; NOW(),
     Parent.IsClosed = TRUE,
     Incoming = TRUE,
     NOT ( ISPICKVAL( Parent.Origin , &quot;Email&quot;)) 
     )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Update Email Sent</fullName>
        <actions>
            <name>Update_Email_Sent</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Email_Sent_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>triggers on agent sending an email
updates First Response Sent field on case (for SLAs)</description>
        <formula>AND(
    AND(Parent.First_Response_Sent__c = FALSE, 
        OR(CreatedBy.Profile.Name &lt;&gt; &quot;BBC System Admin&quot;, CreatedBy.Profile.Name &lt;&gt;&quot;System Administrator&quot;)),

        Incoming =FALSE)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
