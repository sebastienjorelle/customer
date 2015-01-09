public with sharing class GEN_PaymentActions_Extn {
    
    public list<wrapper> wrpLst {get; set;}
    public string caseId {get; set;}
    public GEN_PaymentActions_Extn(ApexPages.StandardController controller) {
    	
    	//To get case id from URL
    	caseId = apexPages.currentPage().getParameters().get('id');
    	
    	
        wrpLst = new list<wrapper>();
        wrpLst.add(new wrapper('10/11/2014 09:59','s1 E4 dr who','$1.99'));
        wrpLst.add(new wrapper('09/11/2014 09:59','Complete s2 sherlock','$2.99'));
        wrpLst.add(new wrapper('08/11/2014 09:59','s5 E8 Top Gear','$0.99'));
        wrpLst.add(new wrapper('07/11/2014 09:59','s1 E4 dr who','$.99'));
        wrpLst.add(new wrapper('06/11/2014 09:59','s1 E4 dr who','$0.99'));
        wrpLst.add(new wrapper('05/11/2014 09:59','s1 E4 dr who','$0.99'));
        
    }
    
    public class wrapper{
        public string dt {get; set;}
        public string title {get; set;}
        public string amount {get; set;}   
        public wrapper(string d, string t, string a){
            dt= d;
            title = t;
            amount = a;
        }
    }
    
    public pageReference rediretToViewDigitalLocker(){
    	if(caseId != null)
		return new pageReference('/apex/GEN_DigitalLocker?caseId='+caseId);
		else
		return null;    	
    }
    

}