public with sharing class CCLcSobjectLookup {
 
  //public Account account {get;set;} // new account to create
  public List<sObject> results{get;set;} // search results
  public string searchString{get;set;} // search keyword
  public boolean newRecordForm{get;set;}
  public boolean searchResultForm{get;set;}
  public String qString{get;set;}
  
  public String sObjectName = CCLcConfiguration.sObjectName;
  private set<String> sOjbLookupFieldSet = CCLcConfiguration.sObjectLookupFieldsSet; 
  public Map<String,String> lookupFieldsDataToBeDisplayed{get;set;}
 
  public CCLcSobjectLookup() {
       this.newRecordForm = false;
       this.searchResultForm = true;
       //account = new Account();
       
       qString= ApexPages.currentPage().getParameters().get('lknw');
       System.debug('lknw$$'+qString);
       sObjectName =  ApexPages.currentPage().getParameters().get('objName');
         System.debug('objName$$'+sObjectName );
       if(qString<> null && qString<> ''){
           this.newRecordForm = true;
           this.searchResultForm = false;
       }else{
             searchString = System.currentPageReference().getParameters().get('lksearch'); 
             runSearch();  
       }        
             
  }
 
 
  // performs the keyword search
  public void search() {
    newRecordForm = false;
    searchResultForm = true;
    runSearch();
   
  }
  
 /*
  // performs the keyword search
  public PageReference search() {
    newRecordForm = false;
    searchResultForm = true;
    runSearch();
    return null;
  }
  
  */
  
  /*public pageReference newRec(){
      PageReference pageRef = new PageReference('/apex/CustomAccountLookup?lknw=1');
      pageRef.setRedirect(true);
      return pageRef;
  }*/
 
  // prepare the query and issue the search command
  private void runSearch() {
    performSearch(searchString);
  } 

  private void performSearch(string searchString) {
             System.debug('searchString$$'+searchString);
    String whereCond = '';
    if(searchString != '' && searchString != null) {
        if(searchString == '*'){
            whereCond = '';
        }else {
            whereCond = ' name LIKE \''+ string.escapeSingleQuotes(searchString) +'%\'';
        }
    }
    
    List<sObject> sObj = CCLcDataController.getRecord(sObjectName, sOjbLookupFieldSet, whereCond, '20');
    lookupFieldsDataToBeDisplayed = new Map<String,String>();
    for(sObject o: sObj){
        for(String key: CCLcConfiguration.sObjectLookupFieldsMap.keyset()){
            String fieldKey = key;
            String fieldValue = CCLcConfiguration.sObjectLookupFieldsMap.get(key);        
            lookupFieldsDataToBeDisplayed.put(String.valueOf(o.get(fieldKey)),String.valueOf(o.get(fieldValue)));
        }
    }    
    System.debug('Map data'+lookupFieldsDataToBeDisplayed); 
  }
 
  // save the new account record
  /*public PageReference saveAccount() {
    insert account;
    // reset the account
    account = new Account();
    return null;
  }*/
 
  // used by the visualforce page to send the link to the right dom element
  public string getTextBox() {
      System.debug('getTextBox++'+System.currentPageReference().getParameters().get('lkname')); 
    return System.currentPageReference().getParameters().get('lkname');
  }
   
  // used by the visualforce page to send the link to the right dom element for the text box
  public string getTextBoxId() {
       System.debug('getTextBoxId++'+System.currentPageReference().getParameters().get('lkid')); 
    return System.currentPageReference().getParameters().get('lkid');
  }

    /*public static testMethod void testMember() {
        
        sObject sObj = Schema.getGlobalDescribe().get(CCLcConfiguration.sObjectName).newSObject() ;
        for(String s: CCLcConfiguration.sObjectLookupFieldsSet){
            if(s <> 'Id'){
                sObj.put(s,'Test record1 from test method');
            }
        }       
        insert sObj;
        
        List<sObject> sObjList = CCLcDataController.getRecord(CCLcConfiguration.sObjectName,CCLcConfiguration.sObjectLookupFieldsSet,'id =\''+sObj.Id+'\'','');
        for(sObject ac:sObjList){
            for(String s: CCLcConfiguration.sObjectLookupFieldsSet){
                if(s <> 'Id'){
                    System.assertEquals('Test record1 from test method',ac.get(s));
                }
            }   
        }  
        
        CCLcSobjectLookup testObj;
        
        testObj = new CCLcSobjectLookup();
        System.currentPageReference().getParameters().put('lksearch','Test');
        testObj = new CCLcSobjectLookup();
        testObj.getTextBox();
        testObj.getTextBoxId();
        testObj.search();

        System.currentPageReference().getParameters().put('lknw','1');
        testObj = new CCLcSobjectLookup();
    }*/
    

}