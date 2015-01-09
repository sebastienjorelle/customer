/* ----------------------------------------------------------------------------------------------------------------------------------------------------------

   Name:          GEN_DigitalLockerController.cls

   Description:  Controller for GEN_DigitalLocker page

                                                                       

   Date             Version        Author                                Summary of Changes

   -----------      ----------      -----------------                 ---------------------------------------------------------------------------------------------------

   Nov 2014     1.0        Shalabh Sharma                               Initial Release

------------------------------------------------------------------------------------------------------------------------------------------------------------ */

global with sharing class GEN_DigitalLockerController {

    List<GEN_ProductWrapper> products {get;set;}
    List<GEN_AddEntitlements> addProducts {get;set;}
    public Integer countProd{get;set;}
    public Boolean showAddEntitlement{get;set;}
    public Boolean showRemoveEntitlement{get;set;}
    public Boolean showCancelPreOrder{get;set;}
    public Integer countPage{get;set;}
    public String caseId;
    public Action__c action{get;set;}
    public String Reason{get;set;}
    public Boolean noRecordSelected{get;set;}
    public Case caseRecord{get;set;}
    public Boolean reasonNotSelected{get;set;}
    public String inputProduct{get;set;}
    public String actionStatus{get;set;}
    public String newSearchText;
    public Boolean showProd{get;set;}

    // instantiate the StandardSetController from a query locator
    public ApexPages.StandardSetController con {
        get {
            if(con == null) {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id, Name, Action_Name__c, Action_Date__c, Reason__c FROM Action__c Order By Action_Date__c DESC limit 100]));
                // sets the number of records in each page set
                con.setPageSize(5);
                
            }
            return con;
        }
        set;        
    }

    public GEN_DigitalLockerController(){
        
        //initialize variables
        showAddEntitlement = false;
        showRemoveEntitlement = false;
        showCancelPreOrder = false;
        action = new Action__c();

        RecordType rt = [Select Id from RecordType where Name='Action Record Type'];
        action.RecordTypeId = rt.Id;
        
        //returns the total count of records
        countProd = [Select count() FROM Action__c limit 100];

        // return the total number of pages
        Double value = ((Double)countProd)/5;
        countPage = (Integer)((Decimal)value).round(System.RoundingMode.UP);

        caseId = ApexPages.currentPage().getParameters().get('caseId');
        system.debug('caseId--->'+caseId);
        if(caseId!=null)
        caseRecord = [Select Id, CaseNumber, AccountId from Case where Id=:caseId];

        //give Add Entitlement access to specific set of CSRs
        CustomPermission custPerAdd = [Select Id from CustomPermission WHERE DeveloperName='AddEntitlements'];
        Map<Id,PermissionSetAssignment> mapUserPerSetAdd = new Map<Id,PermissionSetAssignment>();
        mapUserPerSetAdd = getPermissions(custPerAdd.Id);
        if(!mapUserPerSetAdd.containsKey(UserInfo.getUserId()))
            showAddEntitlement = true;

        // give Remove Entitlement access to specific set of CSRs
        CustomPermission custPerRemove = [Select Id from CustomPermission WHERE DeveloperName='RemoveEntitlements'];
        Map<Id,PermissionSetAssignment> mapUserPerSetRemove = new Map<Id,PermissionSetAssignment>();
        mapUserPerSetRemove = getPermissions(custPerRemove.Id);
        if(!mapUserPerSetRemove.containsKey(UserInfo.getUserId()))
            showRemoveEntitlement = true;

        // give Cancel Pre-order access to specific set of CSRs
        CustomPermission custPerCancel = [Select Id from CustomPermission WHERE DeveloperName='CancelPreOrder'];
        Map<Id,PermissionSetAssignment> mapUserPerSetCancel = new Map<Id,PermissionSetAssignment>();
        mapUserPerSetCancel = getPermissions(custPerCancel.Id);
        if(mapUserPerSetCancel.containsKey(UserInfo.getUserId()))
            showCancelPreOrder = true;

        system.debug('showCancelPreOrder-->'+showCancelPreOrder);
        
        Map<String,ActionScreen__c> customSettingActionScreen = new Map<String,ActionScreen__c>();
        customSettingActionScreen = ActionScreen__c.getAll();
        actionStatus = customSettingActionScreen.values().Status__c;
    }

    // returns a list of wrapper objects for the sObjects in the current page set
    public List<GEN_ProductWrapper> getProducts() {
        products = new List<GEN_ProductWrapper>();
        for (Action__c prod : (List<Action__c>)con.getRecords())
            products.add(new GEN_ProductWrapper(prod));
        return products;
    }

    // return custom permission details
    public Map<Id,PermissionSetAssignment> getPermissions(String permissionId){
        Map<Id,PermissionSetAssignment> mapUserPerSetAssign = new Map<Id,PermissionSetAssignment>();
        for(PermissionSetAssignment objPerSet : [SELECT AssigneeId, PermissionSetId,
                                                PermissionSet.Label
                                                FROM PermissionSetAssignment
                                                WHERE PermissionSetId
                                                IN (SELECT ParentId
                                                   FROM SetupEntityAccess
                                                   WHERE SetupEntityType =
                                                'CustomPermission' AND SetupEntityId =: permissionId)]){
            if(objPerSet.AssigneeId != null)
            mapUserPerSetAssign.put(objPerSet.AssigneeId,objPerSet);          
        }
        return mapUserPerSetAssign;
    }

    // create picklist for Reason field
    public List<SelectOption> getReasonValues() {             
        return getPicklistFieldValues('Action__c','Reason__c');
    }

    // Private method to get picklist values from Objects
    private List<SelectOption> getPicklistFieldValues(String strObjectAPIName, String strFieldAPIName)
    {
        List<SelectOption> options = new List<SelectOption>();
        Schema.SObjectType targetType = Schema.getGlobalDescribe().get(strObjectAPIName);//From the Object Api name retrieving the SObject
        Sobject Object_name = targetType.newSObject();
        Schema.sObjectType objOppReg = Object_name.getSObjectType(); 
        Schema.DescribeSObjectResult objDescribe = objOppReg.getDescribe();       
        Map<String, Schema.SObjectField> mapFieldAndSchemaObject = objDescribe.fields.getMap(); 
        List<Schema.PicklistEntry> values = mapFieldAndSchemaObject.get(strFieldAPIName).getDescribe().getPickListValues();
        system.debug('values--->'+values);
        options.add(new SelectOption('','--None--'));
        for (Schema.PicklistEntry a : values)
        { 
            options.add(new SelectOption(a.getLabel(), a.getValue())); 
            
        }
            
        return options;
    }

    // insert action record
    @RemoteAction
    global static void createAction(String reason, String description, String caseId, String accountId){ 
            Action__c cancelOrder = new Action__c();
            cancelOrder.Reason__c = reason;
            cancelOrder.Description__c = description;
            cancelOrder.Action_Name__c = 'Cancel pre-order';
            cancelOrder.Case__c = caseId;
            cancelOrder.Account__c = accountId;
            cancelOrder.Status__c = 'Completed';
            cancelOrder.Action_Date__c = System.Today();

            insert cancelOrder;
    }

    // displays the selected items
     public PageReference selected() {
         
         return null;
     }

     public PageReference remove() {
         List<Action__c> lstSelectedEntitlements = new List<Action__c>();
         for(GEN_ProductWrapper prodWrap : products){
            if(prodWrap.checked == true){
                lstSelectedEntitlements.add(prodWrap.prod);
            }
         }
         system.debug('lstSelectedEntitlements-->'+lstSelectedEntitlements.size());
         if(lstSelectedEntitlements.size()==0){
             noRecordSelected = true;
         }
         else{
            noRecordSelected = false;
         }
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

     public PageReference addEntitlements(){
        return new PageReference('/apex/GEN_AddEntitlements');
     }

     //returns a list of products to add as entitlements
     public void searchProducts(){
        showProd = true;           
     }

     public List<GEN_AddEntitlements> getAddProducts(){
        newSearchText = '%'+inputProduct+'%';
        addProducts = new List<GEN_AddEntitlements>();
        for (Action__c prod : [Select Id, Name, Action_Date__c from Action__c where Name LIKE: newSearchText LIMIT 20])
            addProducts.add(new GEN_AddEntitlements(prod));
         return addProducts;    
     }

     public PageReference redirectToAction() {
        return new PageReference('/a00/o');
     }
     
     public class GEN_ProductWrapper {

     public Boolean checked{ get; set; }
     public Action__c prod { get; set;}

         public GEN_ProductWrapper(Action__c p){
             prod = p;
             checked = false;
        }
    }
     public class GEN_AddEntitlements
     {
        public Boolean selected{ get; set; }
        public Action__c addProducts { get; set;}

        public GEN_AddEntitlements(Action__c p){
            addProducts = p;
            selected = false;
        }
     }
}