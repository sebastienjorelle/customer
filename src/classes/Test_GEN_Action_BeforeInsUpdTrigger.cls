/* ----------------------------------------------------------------------------------------------------------------------------------------------------------

   Name:          GEN_Action_InsertUpdate_ActivityTrigger.Trigger

   Description:  Test class for GEN_Action_InsertUpdate_ActivityTrigger

                                                                       

   Date             Version             Author                                Summary of Changes

   -----------      ----------      -----------------                 ---------------------------------------------------------------------------------------------------

   Dec 2014            1.0             Masthan Vali Patnam                    Initial Release

------------------------------------------------------------------------------------------------------------------------------------------------------------ */

@isTest

Public class Test_GEN_Action_BeforeInsUpdTrigger{

  Static testmethod void TestInsetUpdateTrg(){
  
        Schema.DescribeSObjectResult cfrSchema = Schema.SObjectType.Case; 
        map<String,Schema.RecordTypeInfo> AccountRecordTypeInfo = cfrSchema.getRecordTypeInfosByName();
        List<Account> accLst=new List<Account>();

        Account acc=new Account();
        acc.BBC_ID__c = 'BBC0003';
        acc.PersonEmail = 'test@gmail.com';
        acc.LastName = 'testlastname';
        accLst.add(acc);
        insert accLst;

        List<Contact> conLst=new List<Contact>();
        contact con = new contact();
        con.lastname = 'lastname';
        con.AssistantName = acc.Id;
          
        conLst.add(con);
        insert conLst;

        List<Case> casLst = new List<Case>();

        case cas= new case();

        cas.RecordTypeId = AccountRecordTypeInfo.get('Community Case').getRecordTypeId();
        cas.Status = 'New';
        cas.contactId= con.id;
        cas.Category__c = 'Getting started';

        casLst.add(cas);
        insert casLst; 

        List<Action__C> actnLst=new List<Action__C>();
        Date dt=Date.today();
        Action__C actn=new Action__C();
        actn.Action_Name__c = 'Change email-address';
        actn.Status__c = 'Pending';
        actn.Case__c = cas.Id;
        actn.Action_Date__c = dt.addDays(-2);   
        actn.Description__c = 'Description';
        actn.Reason__c = 'Bought product elsewhere';
        actnLst.add(actn);

        insert actnLst;
    
  }

}