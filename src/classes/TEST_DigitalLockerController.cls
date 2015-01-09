/* ----------------------------------------------------------------------------------------------------------------------------------------------------------

   Name:          TEST_DigitalLockerController.cls

   Description:  Test class for GEN_DigitalLockerController

                                                                       

   Date             Version        Author                                Summary of Changes

   -----------      ----------      -----------------                 ---------------------------------------------------------------------------------------------------

   Dec 2014     1.0        Shalabh Sharma                               Initial Release

------------------------------------------------------------------------------------------------------------------------------------------------------------ */

@isTest(seeAllData=true)

private class TEST_DigitalLockerController
{
    static Account accountRecord = new Account();
    static Contact contactRecord = new Contact();
    static Case caseRecord = new Case();
    static Action__c actionRecord = new Action__c();

    static void createTestData(){

        RecordType rtAcc = [Select Id from RecordType where Name='Account'];
        
        accountRecord.BBC_ID__c = '12345';
        accountRecord.Name = 'TESTACCOUNT';
        //accountRecord.PersonEmail = 'test@test.com';
        accountRecord.RecordTypeId = rtAcc.Id;

        insert accountRecord;
    
        contactRecord.LastName = 'TESTCONTACT';
        contactRecord.AccountId = accountRecord.Id;
        insert contactRecord;

        RecordType rtCs = [Select Id from RecordType where Name='Community Case'];
        caseRecord.ContactId = contactRecord.Id;
        caseRecord.Status = 'In Progress';
        caseRecord.Category__c = 'Getting started';
        caseRecord.Origin = 'Community';
        caseRecord.RecordTypeId = rtCs.Id;
        insert caseRecord;

        RecordType rtAct = [Select Id from RecordType where Name='Action Record Type'];
        actionRecord.Action_Name__c = 'Cancel pre-order';
        actionRecord.Action_Date__c = System.Today();
        actionRecord.Status__c = 'Pending';
        actionRecord.Case__c = caseRecord.Id;
        actionRecord.RecordTypeId = rtAct.Id;
        actionRecord.Description__c  = 'TESTACTION';
        actionRecord.Reason__c = 'Bought product elsewhere';
        insert actionRecord;        
    }

    static testMethod void testDigitalLocker(){
        Test.startTest();
        createTestData();
        
        //Commented the code as Digital Locker is not going in this sprint so uncomment the code in next sprint to cover GEN_DigitalLockerController class
        /*ApexPages.currentPage().getParameters().put('Id', caseRecord.Id);
        
        GEN_DigitalLockerController controller = new GEN_DigitalLockerController();
        controller.newSearchText = actionRecord.Name;
        controller.getProducts();
        controller.getReasonValues();
        controller.remove();
        controller.getAddProducts();
        GEN_DigitalLockerController.createAction(actionRecord.Reason__c,actionRecord.Description__c,caseRecord.Id,accountRecord.Id);
        controller.back();
        controller.addEntitlements();
        controller.selected();
        controller.redirectToAction();
        controller.first();
        controller.last();
        controller.previous();
        controller.next();
        controller.searchProducts();*/
        Test.stopTest();
    }
}