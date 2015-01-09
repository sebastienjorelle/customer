/* ----------------------------------------------------------------------------------------------------------------------------------------------------------

   Name:          GEN_Action_InsertUpdate_ActivityTrigger

   Description:  This trigger for Action__C object to map Account__c field with the associated case contact info and also
                 it will enable Overdue__c check box. 
                     

                                                                       

      Date           Version            Author                                Summary of Changes

   -----------      ----------      -----------------                 ---------------------------------------------------------------------------------------------------

   Dec 2014            1.0           Masthan vali Patnam                      Initial Release
   Dec 2014            1.1           Masthan vali Patnam                      Added to Account__c field is mapping with associate contact info.

------------------------------------------------------------------------------------------------------------------------------------------------------------ */
 // This trigger for to enable 'Overdue' check box,if the Action_Due_date__c is having past date.

Trigger GEN_Action_BeforeInsUpdTrigger on Action__c(before Insert,before Update) {
    if(trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        for(Action__c ActionVal : trigger.new){
            if(ActionVal.Action_Date__c < system.today()){
               ActionVal.Overdue__c = true;
            }else{
               ActionVal.Overdue__c = false;
            }
        }
    }
    
    
  // This trigger will map Account__c filed with associated case contact info    
    
    if((trigger.isInsert || trigger.isUpdate) && trigger.IsBefore){
    set<id> conIds = new set<id>();
    set<id> caseIds = new set<id>();

    for(Action__c actionVal : trigger.new){
        if(actionVal.Case__c != null){
            caseIds.add(actionVal.Case__c);
        }
    }
    if(caseIds.size() > 0 ){
        map<id, case> caseMap = new map<id,case>([select id, ContactId from case where id=:caseIds]);
        for(case caseVal : caseMap.values()){
            if(caseVal.ContactId != null){
                conIds.add(caseVal.ContactId );
            }
        }
        if(conIds.size() > 0){
            map<id, contact> conMap = new map<id, contact>([select id, AccountId from contact where id=:conIds]);
            for(Action__c actionVal : trigger.new){
                if(actionVal.Case__c != null ){
                    if( conMap.get(caseMap.get(actionVal.Case__c).contactID).accountId!= null){
                    actionVal.Account__c = conMap.get(caseMap.get(actionVal.Case__c).contactID).accountId ;
                    } 
                }
            }   
        }
    }
}

    
}