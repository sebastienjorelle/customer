public class GEN_Case_Trigger_Util_Cls{


    public static void caseLimitMail(){
        
        list<Messaging.SingleEmailMessage> emailLst = new list<Messaging.SingleEmailMessage>();
        system.debug('INside trigger');
        decimal BHendTime;
        decimal BHstartTime;
        decimal TF1end;
        decimal TF1start;
        decimal TF2end;
        decimal TF2Start;
        decimal TF3End;
        decimal TF3Start;
        decimal Timeframe1threshold;
        decimal Timeframe2threshold;
        decimal Timeframe3threshold;
        decimal tf1; 
        decimal tf2; 
        decimal tf3; 
                
    CS_AlertCasesCreated__c t = CS_AlertCasesCreated__c.getInstance('Timeframe1 End');
    TF1end= t.value__C;

    t = CS_AlertCasesCreated__c.getInstance('Timeframe1 Start');
    TF1start= t.value__C;

    t = CS_AlertCasesCreated__c.getInstance('Timeframe2 End');
    TF2end= t.value__C;

    t = CS_AlertCasesCreated__c.getInstance('Timeframe2 Start');
    TF2Start= t.value__C;

    t = CS_AlertCasesCreated__c.getInstance('Timeframe3 End');
    TF3End= t.value__C;

    t = CS_AlertCasesCreated__c.getInstance('Timeframe3 Start');
    TF3Start= t.value__C;
    
    t = CS_AlertCasesCreated__c.getInstance('Timeframe1 Threshold');
    Timeframe1threshold= t.value__C;
    
    t = CS_AlertCasesCreated__c.getInstance('Timeframe2 Threshold');
    Timeframe2threshold= t.value__C;
    
    t = CS_AlertCasesCreated__c.getInstance('Timeframe3 Threshold');
    Timeframe3threshold= t.value__C;
    
    t = CS_AlertCasesCreated__c.getInstance('Email addresses');
    string email_addresses = t.Email_address__c;
    
    set<string> email_addresses_set = new set<string>();
    if(email_addresses.contains(';') && email_addresses != null){
        for(string s:email_addresses.split(';')){
            email_addresses_set.add(s);
        }
    }else if(email_addresses != null){
        email_addresses_set.add(email_addresses );
    }
     system.debug('TF1start....'+TF1start);
     system.debug('TF2start....'+TF2start);
     system.debug('TF3start....'+TF3start);
     
        tf1 = 0; 
        tf2 = 0; 
        tf3 = 0; 
        
        List<Case> casLst = [select id,createddate from case where CreatedDate = today or CreatedDate = yesterday];
        system.debug('INside trigger'+casLst );
        for(case c:casLst ){
            if((c.createddate.hour() >= TF1start && c.createddate.date() >= system.today()-1) ||( c.createddate.hour() < TF1end && c.createddate.date() == system.today())){
            system.debug('inside TF1start....');
            tf1 = tf1 +1;
            }
            else if(c.createddate.hour() >= TF2Start && c.createddate.date() == system.today() && c.createddate.hour() < TF2end){
            system.debug('inside TF2start....');
            tf2 = tf2 +1;
            }
            else if(c.createddate.hour() >= TF3Start && c.createddate.hour() < TF3End && c.createddate.date() == system.today()){
            system.debug('inside TF3start....');
            tf3 = tf3 +1;
            }
        }
        list<emailTemplate> etEmp = [select id from emailTemplate where developername='ALERT_case_threshold_reached']; 
        list<user> userLst = [select id, email from user where email =:email_addresses_set ];
         
    
         if(tf1 == Timeframe1threshold){
         
            for(user u:userLst){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();       
                mail.setTargetObjectId(u.id);       
                mail.setTemplateId(etEmp[0].id);
                mail.setSaveAsActivity(false);
                emailLst.add(mail);
            }
                
                
                
        }
         
        if(tf2 == Timeframe2threshold){
            for(user u:userLst){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();       
                mail.setTargetObjectId(u.id);       
                mail.setTemplateId(etEmp[0].id);
                mail.setSaveAsActivity(false);
                emailLst.add(mail);
            }
                
        }
       
        if(tf3 == Timeframe3threshold){
            for(user u:userLst){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();       
                mail.setTargetObjectId(u.id);       
                mail.setTemplateId(etEmp[0].id);
                mail.setSaveAsActivity(false);
                emailLst.add(mail);
            }
        }
        
        if(emailLst.size() > 0){
            Messaging.sendEmail(emailLst);
            system.debug('Mail sent');
        }
    }


    public static void FirstResponseSLAHoursInsrt(list<case> newCase){
        List<Caselimit__c> caslimt = [select id,First_Response_SLA_Hours__c,Case_Reopen_limit__c from Caselimit__c];
        for(Case CasVal : newCase){
            if(casVal.First_Response_SLA_Hours__c == null){
                if(caslimt[0].First_Response_SLA_Hours__c != NULL){
                    CasVal.First_Response_SLA_Hours__c = caslimt[0].First_Response_SLA_Hours__c;
                }
            }
         }
    }
    
    public static void FirstResponseDuetimeInsrt(list<case> newCase){
    
      BusinessHours stdBusinessHours = [select id from businesshours where isDefault = true];
        for (Case so : newCase){
            
        if (stdBusinessHours != NULL && so.First_Response_Duetime__c==Null) {            
          so.First_Response_Duetime__c = BusinessHours.addGmt(stdBusinessHours.id, system.now(),(so.First_Response_SLA_Hours__c * 60 * 60 * 1000L).longValue());
        }
                  
            }
    
   }
   
   public static void FirstResponseDuetimeUpdate(list<case> newCase){
     
     BusinessHours stdBusinessHours = [select id from businesshours where isDefault = true];
        for (Case so : newCase){
            
            System.debug('case values>>>>>'+newCase);
            System.debug('Statndard business hours>>>>>'+stdBusinessHours);
        if (stdBusinessHours != NULL && so.First_Response_Duetime__c==Null) {                   
        
        
                  so.First_Response_Duetime__c = BusinessHours.addGmt(stdBusinessHours.id, so.createdDate,(so.First_Response_SLA_Hours__c * 60 * 60 * 1000L).longValue());
        }
    
    

}
}
}