@isTest
public class SWAT_RuleEngineCore_Test
{

  @istest
  public static void callingclsmethod()
  {
    User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
    
      SWATRule__c myRule=new SWATRule__c();  
       myRule.ActiveFlag__c=true;
      myRule.RuleDescription__c='testrule';
      myRule.Rule_Expression__c='[{"orderNo" : 0,"operator" : "=","objectName" : "SWATRule__c","logicalOperator" : null,"fieldValue" : "true","fieldName" : "ActiveFlag__c"}'+
       +',{"orderNo" : 1,"operator" : "<","objectName" : "SWATRule__c","logicalOperator" : "AND","fieldValue" : "test","fieldName" : "RuleDescription__c"}]';
      insert myrule;
      
      SWATRuleGroup__c myRuleGroup = new SWATRuleGroup__c();
      myRuleGroup.Name='testrulegroup1';
      myRuleGroup.Active__c=true;
      insert myRuleGroup;
      
      SWATRuleMapping__c ruleMapping=new SWATRuleMapping__c();
      ruleMapping.EffectiveDate__c=Date.today();
      ruleMapping.ExpirationDate__c=Date.today()+7;
      ruleMapping.Message__c='test';
      ruleMapping.Priority__c=1;
      ruleMapping.Severity__c='DEVIATION';
      ruleMapping.SWATRule__c=myrule.id;
      ruleMapping.RuleGroupID__c=myRuleGroup.id;
      insert ruleMapping;
      
     
    /*
      TM_Application_Form__c appform=new TM_Application_Form__c();
      appform.First_Name__c='testname';
      appform.Last_Name__c='test';
      appform.Gross_Annual_Income__c=150000;
      appform.Net_Monthly_Income__c=15000;
      appform.Purchase_Price__c=13000;
      appform.Term_of_Finance__c=12;
      appform.Gender__c='Male';
      appform.Product_Set_Name__c='LOS';
      insert appform;
      
        TM_Application_Form__c appform1=new TM_Application_Form__c();
        appform1.First_Name__c='testname';
        appform1.Last_Name__c='test';
      appform1.Gross_Annual_Income__c=150001;
      appform1.Net_Monthly_Income__c=15000;
      appform1.Purchase_Price__c=13000;
      appform1.Term_of_Finance__c=12;
      appform1.Gender__c='Male';
      appform1.Product_Set_Name__c='LOS';
      insert appform1;
      */
      
        SWATRule_Engine_Configuration__c ruleEngineconfig=new SWATRule_Engine_Configuration__c();
        ruleEngineconfig.SWATRuleGroup__c = myRuleGroup.id;
        ruleEngineconfig.ObjectRecordId__c=myRule.ID;
        ruleEngineconfig.ObjectRecordName__c='App Form';
        ruleEngineconfig.Priority__c = 1;
        ruleEngineconfig.Active__c = true;
        insert ruleEngineconfig;
    
        SWAT_RuleEngineCore swatRuleEngineCore=new SWAT_RuleEngineCore();
        //swatRuleEngineCore.fieldsMap =new map<string, Schema.SObjectField>();
        
        map<string, Id> referenceObjectMap = new map<string, Id>{'SWATRule__c'=>myRule.id};    
       // SWAT_RuleEngineCore.executeRulesByProduct(appform.id, referenceObjectMap );
        SWAT_RuleEngineCore.executeRulesByProductName('App Form', referenceObjectMap ); 
        SWAT_RuleEngineCore.executeRulesByGroupName('testrulegroup1', referenceObjectMap );    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, referenceObjectMap );
        
      
       SWAT_RuleEngineCore.executeRulesProductName('App Form', referenceObjectMap );
        SWAT_RuleEngineCore.executeRulesGroupName('testrulegroup1', referenceObjectMap );    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, referenceObjectMap );
        
        
        map<string, Id> referenceObjectMap1 = new map<string, Id>{'SWATRule__c'=>null};    
       // SWAT_RuleEngineCore.executeRulesByProduct(appform.id, referenceObjectMap );
        SWAT_RuleEngineCore.executeRulesByProductName('App Form', referenceObjectMap1 ); 
        SWAT_RuleEngineCore.executeRulesByGroupName('testrulegroup1', referenceObjectMap1 );    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, referenceObjectMap1 );
       
       // SWAT_RuleEngineCore.executeRulesByProduct(appform1.id, appform1);
        SWAT_RuleEngineCore.executeRulesByProductName('App Form', myRule);
        SWAT_RuleEngineCore.executeRulesByGroupName('testrulegroup1', myRule);    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, myRule);
        
        SWAT_RuleEngineCore.executeRulesProductName('App Form', myRule);
        SWAT_RuleEngineCore.executeRulesGroupName('testrulegroup1', myRule);    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, myRule);
        
        SWAT_RuleEngineCore.executeRulesProductName('App Form', myRule);
        SWAT_RuleEngineCore.executeRulesGroupName('testrulegroup1', myRule);    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, myRule);
        
        
        //-ve
        SWAT_RuleEngineCore.executeRulesByProductName('App Form', new SWATRule__c());
        SWAT_RuleEngineCore.executeRulesByGroupName('testrulegroup1', new SWATRule__c());    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, new SWATRule__c());
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, myRule);
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id,new map<string, Id>{'TM_Application_Form__c'=>myRule.id} );
        
        SWAT_RuleEngineCore.executeRulesProductName('App Form', new map<string, Id>{'TM_Application_Form__c'=>myRule.id});
        SWAT_RuleEngineCore.executeRulesGroupName('testrulegroup1', new map<string, Id>{'TM_Application_Form__c'=>myRule.id});    
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, new map<string, Id>{'TM_Application_Form__c'=>myRule.id});
        
        SWAT_RuleEngineCore.ExecuteRules(''+myRule.id, new map<string, Id>{'TM_Application_Form__c'=>null});
        SWAT_RuleEngineCore.executeRulesProductName('App Form', new map<string, Id>{'TM_Application_Form__c'=>null});
        SWAT_RuleEngineCore.executeRulesGroupName('testrulegroup1', new map<string, Id>{'TM_Application_Form__c'=>null});
        
        
    
    }
  }

}