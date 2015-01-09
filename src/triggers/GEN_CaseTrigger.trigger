/* ----------------------------------------------------------------------------------------------------------------------------------------------------------

   Name:          GEN_CaseSlaHoursandThreshold.trigger

   Description:  1)Works for when case threshold is reached in non business hours then it will send an email alert.
                 2)Works for when case is created then First Response SLA hours will be mapped from Custom settings.
                 3)Works for when case is created or updated then the First Response Dutime will be mapped.
                     

                                                                       

      Date           Version            Author                                Summary of Changes

   -----------      ----------      -----------------                 ---------------------------------------------------------------------------------------------------

   Dec 2014            1.0           Masthan vali Patnam                      Initial Release
  
------------------------------------------------------------------------------------------------------------------------------------------------------------ */

Trigger GEN_CaseTrigger on Case(Before insert,before update,after insert){
         
          
     // This code is handle to populate First_Response_SLA_Hours__c  from the custom setting and to populate First_Response_Duetime__c field value.
        if(trigger.isInsert && Trigger.isBefore){
             GEN_Case_Trigger_Util_Cls.FirstResponseSLAHoursInsrt(trigger.new);
             GEN_Case_Trigger_Util_Cls.FirstResponseDuetimeInsrt(trigger.new);
        }
        
     // This code is handle to update First_Response_Duetime__c field value.        
        if(trigger.isUpdate && Trigger.isBefore){
             GEN_Case_Trigger_Util_Cls.FirstResponseSLAHoursInsrt(trigger.new);
             GEN_Case_Trigger_Util_Cls.FirstResponseDuetimeUpdate(trigger.new);
           
        }   
     // This code handle to send an email alert when case threshold reached in non business hours.
        if(trigger.isAfter && Trigger.isInsert){
             GEN_Case_Trigger_Util_Cls.caseLimitMail();
           
        }                 
     
    }