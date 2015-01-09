<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Case_Closed_Notification</fullName>
        <description>Case Closed Notification</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BBCW_Emails/SUPPORT_Case_Closed</template>
    </alerts>
    <alerts>
        <fullName>Case_Created_Notification</fullName>
        <description>Case Created Notification</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BBCW_Emails/SUPPORT_Case_Created</template>
    </alerts>
    <alerts>
        <fullName>Open_new_case_notification</fullName>
        <description>Open new case notification</description>
        <protected>false</protected>
        <recipients>
            <field>ContactEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BBCW_Emails/SUPPORT_create_new_case</template>
    </alerts>
    <alerts>
        <fullName>RM_Test</fullName>
        <description>RM Test</description>
        <protected>false</protected>
        <recipients>
            <recipient>rhodri.mortimer@bbc.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BBCW_Emails/rm_test</template>
    </alerts>
    <alerts>
        <fullName>Reopened_case_notification</fullName>
        <description>Reopened case notification</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>BBCW_Emails/SUPPORT_Case_reopened</template>
    </alerts>
    <fieldUpdates>
        <fullName>Category_invalid_case</fullName>
        <field>Category__c</field>
        <literalValue>Invalid Case</literalValue>
        <name>Category - invalid case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Reason_Incorrectly_raised</fullName>
        <field>Case_Close_Reason__c</field>
        <literalValue>Incorrectly raised</literalValue>
        <name>Close Reason - Incorrectly raised</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Reason_No_customer_response</fullName>
        <field>Case_Close_Reason__c</field>
        <literalValue>No customer response</literalValue>
        <name>Close Reason - No customer response</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_case</fullName>
        <field>Status</field>
        <literalValue>Closed</literalValue>
        <name>Close case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Case_Community_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Community_Case</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Closed Case Community Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Case_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Closed_Case</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Closed Case Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Case_Social_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Social_Case</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Closed Case Social Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Closed_Case_Standard_Record_Type</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Standard_Case</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Closed Case Standard Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_in_progress</fullName>
        <field>Status</field>
        <literalValue>In Progress</literalValue>
        <name>Status - in progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sub_category_Customer</fullName>
        <field>Sub_Category__c</field>
        <literalValue>Customer</literalValue>
        <name>Sub-category - Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Uncheck_create_new_case_email</fullName>
        <field>Create_new_case_email__c</field>
        <literalValue>0</literalValue>
        <name>Uncheck create new case email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_First_Response_SLA</fullName>
        <description>Updates First Response SLA field on Case with current value from Case Limits Custom Setting</description>
        <field>First_Response_SLA_Hours__c</field>
        <formula>$Setup.Caselimit__c.First_Response_SLA_Hours__c</formula>
        <name>Update First Response SLA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>WF_Awaiting customer info</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Pending - awaiting customer info</value>
        </criteriaItems>
        <description>triggers when the case status is changed to pending - awaiting customer
this wf is used to close the case after 7 days if no status update</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Close_Reason_No_customer_response</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Close_case</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>WF_CSR accepts ownership</fullName>
        <actions>
            <name>Status_in_progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>trigger if the case ownership is changed from a queue to a CSR
updates the case status to In Progress</description>
        <formula>OR (PRIORVALUE(  OwnerId  ) = &quot;00Gg0000000hub6&quot;,
    PRIORVALUE(  OwnerId  ) = &quot;00Gg0000000hubG&quot;,
    PRIORVALUE(  OwnerId  ) = &quot;00Gg0000000hubB&quot;
    )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Case Closed</fullName>
        <actions>
            <name>Closed_Case_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>triggers when a case is closed
used to change the record type and page layout to read only</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Case Closed Notification</fullName>
        <actions>
            <name>Case_Closed_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>notEqual</operation>
            <value>Email</value>
        </criteriaItems>
        <description>triggers when a case is status is closed and the case origin is not Email
sends a notification of the case closure to the customer</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Case Created Notification</fullName>
        <actions>
            <name>Case_Created_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>notEqual</operation>
            <value>Email</value>
        </criteriaItems>
        <description>triggers when a case is created and its origin is not email</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Case Origin%3A Email</fullName>
        <actions>
            <name>Open_new_case_notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Category_invalid_case</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Close_Reason_Incorrectly_raised</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Close_case</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Sub_category_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Email</value>
        </criteriaItems>
        <description>triggers if a case is created from an email, email the customer with link to web form</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_No reopen email</fullName>
        <actions>
            <name>Open_new_case_notification</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Uncheck_create_new_case_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Create_new_case_email__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>send an email to the customer if he sends an email outside the case reopening period</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Reopen Case Community</fullName>
        <actions>
            <name>Closed_Case_Community_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Reopened</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Community</value>
        </criteriaItems>
        <description>triggers when a community case is reopened
send an email to the customer to advise that the case was reopened
change the record type to Community Case</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Reopen Case Social</fullName>
        <actions>
            <name>Closed_Case_Social_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Reopened</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>equals</operation>
            <value>Social</value>
        </criteriaItems>
        <description>triggers when a social case is reopened
send an email to the customer to advise that the case was reopened
change the record type to Social Case</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Reopen Case Standard</fullName>
        <actions>
            <name>Closed_Case_Standard_Record_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Reopened</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Origin</field>
            <operation>notEqual</operation>
            <value>Community,Social</value>
        </criteriaItems>
        <description>triggers when a standard case is reopened
send an email to the customer to advise that the case was reopened
change the record type to Standard Case</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Solution sent</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Pending - solution sent</value>
        </criteriaItems>
        <description>triggers when the case status is changed to pending - solution sent
this wf is used to close the case after 3 days if no status update</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Close_Reason_No_customer_response</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Close_case</name>
                <type>FieldUpdate</type>
            </actions>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>WF_Update SLAs</fullName>
        <actions>
            <name>Update_First_Response_SLA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>triggers when case is created
used to set SLA values</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
</Workflow>
