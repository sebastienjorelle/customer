/* ----------------------------------------------------------------------------------------------------------------------------------------------------------

   Name:          GEN_CaseBatchtoCountCreatedcases.batchcls

   Description:  This batch class used to store the number of cases  created in non business hours.

                                                                       

   Date             Version        Author                                Summary of Changes

   -----------      ----------      -----------------                 ---------------------------------------------------------------------------------------------------

   Dec 2014           1.0          Masthan vali Patnam                  Initial Release

------------------------------------------------------------------------------------------------------------------------------------------------------------ */

global class GEN_CaseBatchtoCountCreatedcases implements Database.Batchable<SObject>,Database.Stateful{ 

                decimal BHendTime;
                decimal BHstartTime;
                decimal TF1end;
                decimal TFstart;
                decimal TF2end;
                decimal TF2Start;
                decimal TF3End;
                decimal TF3Start;
                Integer tf1; 
                Integer tf2; 
                Integer tf3; 
                global GEN_CaseBatchtoCountCreatedcases(){
                                CS_AlertCasesCreated__c t = CS_AlertCasesCreated__c.getInstance('BH End time');
                                BHendTime= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('BH Start Time');
                                BHstartTime= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('TF1 End');
                                TF1end= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('TF1 Start');
                                TFstart= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('TF2 End');
                                TF2end= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('TF2 Start');
                                TF2Start= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('TF3 End');
                                TF3End= t.value__C;
                                
                                t = CS_AlertCasesCreated__c.getInstance('TF3 Start');
                                TF3Start= t.value__C;
                                
                                tf1 = 0; 
                                tf2 = 0; 
                                tf3 = 0; 
                }

 
    global database.QueryLocator start(database.batchableContext bc){
        try{
            string qry = 'SELECT Id,CreatedDate  FROM Case WHERE CreatedDate = today or CreatedDate = yesterday';
            return dataBase.getQueryLocator(qry);
        }catch(exception e){
            return null;
        }
    }
    
    
    global void execute(database.batchableContext bc,List<Case> CaseLst){
                
                                
                                
                            for(case c:caseLst){
                            if((c.createddate.hour() >= TFstart && c.createddate.date() >= system.today()-1) ||( c.createddate.hour() < TF1end && c.createddate.date() == system.today())){
                            tf1 = tf1 +1;
                            }
                            else if(c.createddate.hour() >= TF2Start && c.createddate.date() == system.today() && c.createddate.hour() < TF2end){
                            tf2 = tf2 +1;
                            }
                            else if(c.createddate.hour() >= TF3Start && c.createddate.hour() < TF3End && c.createddate.date() == system.today()){
                            tf3 = tf3 +1;
                            }
                            }
                            
   
            
    }
    
    global void finish(database.batchableContext bc){
                                integer tot = tf1+tf2+tf3;
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();                    
                                mail.setToaddresses(new string[]{'masthan.vali.patnam@accenture.com','sebastien.jorelle@accenture.com'});
                                string msg = '<body>hi<br/><br/>';
                                msg = msg + 'From 11 pm to 2 am:'+tf1+'<br/>';
                                msg = msg + 'From 2 am to 5 am:'+tf2+'<br/>';
                                msg = msg + 'From 5 am to 8 am:'+tf3+'<br/>';
                                msg = msg + 'Cases created in out of business hours:'+tot+'<br/></body>';
                                mail.setHtmlBody(msg);
                                mail.setSubject('Case Count');
                                Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
       
    }
}