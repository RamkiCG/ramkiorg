@isTest
public class CCLcSobjectLookup_Test
{
  @istest
  public static void CCLcSobjectLookup()
  {
    /*
    CCLcSobjectLookup testObj;
    testObj = new CCLcSobjectLookup();
    System.currentPageReference().getParameters().put('lksearch','Test');
    testObj = new CCLcSobjectLookup();
    testObj.getTextBox();
    testObj.getTextBoxId();
    testObj.search();
    System.currentPageReference().getParameters().put('lknw','1');
    testObj = new CCLcSobjectLookup();
    */
    SWATRule__c myRule=new SWATRule__c();  
    myRule.ActiveFlag__c=true;
    myRule.RuleDescription__c='testrule';
    myRule.Rule_Expression__c='[{"orderNo" : 0,"operator" : "=","objectName" : "SWATRule__c","logicalOperator" : null,"fieldValue" : "true","fieldName" : "ActiveFlag__c"}'+
    +',{"orderNo" : 1,"operator" : "<","objectName" : "SWATRule__c","logicalOperator" : "AND","fieldValue" : "test","fieldName" : "RuleDescription__c"}]';
    insert myrule;
    
    CCLcConfiguration.sObjectName='SWATRule__c';
    CCLcConfiguration.sObjectLookupFieldsSet= new Set<String>{'Id,Name'};
    //CCLcConfiguration.whereCond= '';
    

    PageReference pgRef = Page.CCLvSobjectLookup;
    pgRef.getParameters().put('objName','SWATRule__c');   
    pgRef.getParameters().put('lknw',null);
    pgRef.getParameters().put('lkid',''+myrule.id);
        
    Test.setCurrentPageReference(pgRef);
    CCLcSobjectLookup lookup=new CCLcSobjectLookup();
    //lookup.getTextBox();
    //lookup.getTextBoxId();
    lookup.Search();
    
  }
}