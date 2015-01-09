global with sharing class GEN_PaymentInformation_Ctrl {
    
    public list<selectOption> range {get; set;}
    public list<selectOption> pType {get; set;}
    private String initialsortField = 'Name';
    public String sortDir {
        // To set a Direction either in ascending order or descending order.
                                get  { if (sortDir == null) {  sortDir = 'asc'; } return sortDir;}
        set;
    }
    public String sortField {get; set;}
    
    public Integer countPage{get;set;}
    
    
    
    
    List<GEN_ProductWrapper> products {get;set;}
    public Integer countProd{get;set;}
    public String caseId;
    public Boolean noRecordSelected{get;set;}
    public Case caseRecord{get;set;}
    public String actionStatus{get;set;}

    // instantiate the StandardSetController from a query locator
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id, Name, Action_Name__c, Action_Date__c, Reason__c,Status__c FROM Action__c Order By Action_Date__c DESC limit 100]));
                // sets the number of records in each page set
                con.setPageSize(10);
                list<Action__c> l = new list<Action__c>();
                l = [Select Id, Name, Action_Name__c, Action_Date__c, Reason__c,Status__c FROM Action__c Order By Action_Date__c DESC limit 100];
                countPage = l.size();
            }
            return con;
        }
        set;        
    }

   public GEN_PaymentInformation_Ctrl() {
        range = new list<selectoption>();
        pType = new list<selectoption>();
        range.add(new selectoption('Last 7 days','Last 7 days'));
        range.add(new selectoption('Last 14 days','Last 14 days'));
        range.add(new selectoption('Last 30 days','Last 30 days'));
        range.add(new selectoption('AllTime','AllTime'));
        pType.add(new selectoption('select Payment type','select Payment type'));
        pType.add(new selectoption('Credit Card','Credit Card'));
        
        
        
        //initialize variables


        caseId = ApexPages.currentPage().getParameters().get('caseId');
        caseRecord = [Select Id, CaseNumber, AccountId from Case where Id=:caseId];

        
    }

    // returns a list of wrapper objects for the sObjects in the current page set
    public List<GEN_ProductWrapper> getProducts() {
        products = new List<GEN_ProductWrapper>();
        for (Action__c prod : (List<Action__c>)con.getRecords())
            products.add(new GEN_ProductWrapper(prod));
        return products;
    }





    // displays the selected items
     public PageReference selected() {
         
         return null;
     }


    // indicates whether there are more records after the current page set.
    public Boolean hasNext {
        get {
            return con.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            return con.getHasPrevious();
        }
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get {
            return con.getPageNumber();
        }
        set;
    }

    // returns the first page of records
     public void first() {
         con.first();
     }

     // returns the last page of records
     public void last() {
         con.last();
     }

     // returns the previous page of records
     public void previous() {
         con.previous();
     }

     // returns the next page of records
     public void next() {
         con.next();
     }
    // returns the PageReference of the original page, if known, or the home page.
     public PageReference back() {
         return new PageReference('/'+caseId);
     }



     
     public class GEN_ProductWrapper {

     public Boolean checked{ get; set; }
     public Action__c prod { get; set;}

         public GEN_ProductWrapper(Action__c p){
             prod = p;
             checked = false;
        }
    }
    
    public pageReference sortList(){
    	try{
	    	sortDir = sortDir.equals('asc') ? 'desc' : 'asc';
	    	string qry = 'Select Id, Name, Action_Name__c, Action_Date__c, Reason__c,Status__c FROM Action__c order by '+sortField+' '+sortDir+ ' limit 100';
	    	system.debug('Query----->'+qry);
	    	con = new ApexPages.StandardSetController(Database.getQueryLocator(qry));
	    	con.setPageSize(10);
	    	list<Action__c> l = new list<Action__c>();
	        l = database.query(qry);
	        countPage = l.size();
    	}catch(exception e){
    		system.debug(e.getMessage());
    	}
		return null;    	
    }
    


}