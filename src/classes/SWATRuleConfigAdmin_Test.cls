@isTest
public class SWATRuleConfigAdmin_Test
{

  @istest
  public static void RuleEngineConfiguration()
  {
    User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
       SWATRuleGroup__c myRuleGroup = new SWATRuleGroup__c();
       myRuleGroup.Name='testrulegroup1';
       myRuleGroup.Active__c=true;
       insert myRuleGroup;
       SWATRuleConfigAdmin ruleConfig=new SWATRuleConfigAdmin();         
       ruleConfig.ruleEngineConfiguration.SWATRuleGroup__c = myRuleGroup.id;
       ruleConfig.ruleEngineConfiguration.Priority__c = 1;
       ruleConfig.ruleEngineConfiguration.Active__c = true;
       ruleConfig.saveRuleEngineConfiguration();
       
      
       
        SWATRuleConfigAdmin ruleConfig1=new SWATRuleConfigAdmin();         
        ruleConfig1.ruleEngineConfiguration=null;
        ruleConfig1.saveRuleEngineConfiguration();
    }
  }
 
  @istest
  public static void SaveRuleGroup()
  {
    User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
       
       SWATRuleConfigAdmin ruleConfig=new SWATRuleConfigAdmin();
       ruleConfig.ruleGroup.Name='testrulegroup';
       ruleConfig.ruleGroup.Active__c=true;
       ruleConfig.saveRuleGroup();
       Id testgroupid=[select id from SWATRuleGroup__c where name='testrulegroup' limit 1].id;
       System.assertnotequals(testgroupid,null);
       
      
       
      
       SWATRuleConfigAdmin ruleConfig1=new SWATRuleConfigAdmin();
       ruleConfig1.ruleGroup=null;
       ruleConfig1.saveRuleGroup();
      
    }
  
  }
  
  @istest
  public static void SaveRuleMapping()
  {
    User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
   SWATRuleConfigAdmin ruleConfig=new SWATRuleConfigAdmin();
   
   SWATRuleGroup__c myRuleGroup = new SWATRuleGroup__c();
   myRuleGroup.Name='testrulegroup1';
   myRuleGroup.Active__c=true;
   insert myRuleGroup;
   
       ruleConfig.objectType = 'SWATRuleGroup__c';
       ruleConfig.selectedRecordToEdit=string.valueof(myRuleGroup.id);
       ruleConfig.editOrDeleteRecord();
       ruleConfig.selectedRecordToDelete=string.valueof(myRuleGroup.id);
       ruleConfig.editOrDeleteRecord();
   
   
   SWATRule__c myRule=new SWATRule__c();   
   myRule.RuleDescription__c='testrule';
   myRule.Rule_Expression__c='[{"orderNo" : 0,"operator" : ">","objectName" : "TM_Application_Form__c","logicalOperator" : null,"fieldValue" : "10000.00","fieldName" : "Gross_Annual_Income__c"  } ]';
   insert myrule;
   
       ruleConfig.objectType = 'SWATRule__c';
       ruleConfig.selectedRecordToEdit=string.valueof(myrule.id);
       ruleConfig.editOrDeleteRecord();
       ruleConfig.selectedRecordToDelete=string.valueof(myrule.id);
       ruleConfig.editOrDeleteRecord();
   
       /*
       SWATRule_Engine_Configuration__c ruleEngineconfig=new SWATRule_Engine_Configuration__c();
       ruleEngineconfig.SWATRuleGroup__c = myRuleGroup.id;
       ruleEngineconfig.Priority__c = 1;
       ruleEngineconfig.Active__c = true;
       insert ruleEngineconfig;
   
     
      
       ruleConfig.objectType = 'SWATRule_Engine_Configuration__c';
       ruleConfig.selectedRecordToEdit=string.valueof(ruleEngineconfig.id);
       ruleConfig.editOrDeleteRecord();
       ruleConfig.selectedRecordToDelete=string.valueof(ruleEngineconfig.id);
       ruleConfig.editOrDeleteRecord();
       
       */
       
      
   
   

   ruleConfig.ruleMapping.EffectiveDate__c=Date.today();
   ruleConfig.ruleMapping.ExpirationDate__c=Date.today()+7;
   ruleConfig.ruleMapping.Message__c='test';
   ruleConfig.ruleMapping.Priority__c=1;
   ruleConfig.ruleMapping.Severity__c='DEVIATION';
    ruleConfig.ruleMapping.SWATRule__c=myrule.id;
    ruleConfig.ruleMapping.RuleGroupID__c=myRuleGroup.id;
   ruleConfig.saveRuleMapping();
   
   
    //SWATRuleConfigAdmin ruleConfig1=new SWATRuleConfigAdmin();
    //ruleConfig1.ruleMapping=null;
    // ruleConfig1.saveRuleMapping();
  }
  }
  
  
  @istest
  public static void SaveRule()
  {
  User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
   SWATRuleConfigAdmin ruleConfig=new SWATRuleConfigAdmin();
   
   ruleConfig.getRuleConfigurationTypes();
   ruleConfig.getRules();
   ruleConfig.getGroups();
  ruleConfig.resetForm();
  ruleConfig.resetRuleGrp();
  ruleConfig.resetMapRule();
   ruleConfig.getCounter();
   ruleConfig.getRuleGroups();
   ruleConfig.getRuleAndGroupMapping();
   ruleConfig.getRuleEngineConfigurationList();
   ruleConfig.assignValuesIntoPaginationProperties();
   ruleConfig.execute();
   ruleConfig.cancel();
   ruleConfig.getIsHomeRendered();
   ruleConfig.getIsCreateRuleGroupRendered();
   ruleConfig.getIsCreateRuleRendered();
   ruleConfig.getIsConfigRuleRendered();
   SWATRuleConfigAdmin.RuleEngineConfiguration ruleconfig11=new SWATRuleConfigAdmin.RuleEngineConfiguration(0);
   ruleconfig11.getGroups();
   SWATRuleConfigAdmin.RuleWrapper ruleWrap=new SWATRuleConfigAdmin.RuleWrapper(new SWATRule__c());
   ruleConfig.selectedObject='';
   ruleConfig.selectedObjectRecord='';
   ruleConfig.recordId='';
   ruleConfig.sObjectRecordId='';
   SWATRuleConfigAdmin.sObjectRecord='';
   
   //SWAT_BRE_Configuration__c
   
   
 //  "orderNo" : 0,
 // "operator" : ">",
 // "objectName" : "TM_Application_Form__c",
 // "logicalOperator" : null,
 // "fieldValue" : "10000.00",
 // "fieldName" : "Gross_Annual_Income__c"Travel_Insurance__c

   
   SWAT_BRE_Configuration__c breconfig=new SWAT_BRE_Configuration__c();
   breconfig.Active__c=true;
   breconfig.API_Name__c='TM_Application_Form__c';
   breconfig.Group__c='Configuration';
   breconfig.Sub_Group__c='Type';
   breconfig.Value__c='TM_Application_Form__c';
   insert breconfig;
   
   //SWATRule__c 
   //ruleConfig.expressionList=new List<SWAT_RuleConfiguration.ExpressionWrapper>();
   ruleConfig.ruleDetails.name='testrule1';
   ruleConfig.ruleDetails.ActiveFlag__c=true;
   ruleConfig.ruleDetails.RuleDescription__c='test Description';
   // ruleConfig.expressionList=new List<SWAT_RuleConfiguration.ExpressionWrapper>();
   SWATRuleConfigAdmin.ExpressionWrapper wr = new SWATRuleConfigAdmin.ExpressionWrapper(0);
   SWATRuleConfigAdmin.ExpressionWrapper wr3 = new SWATRuleConfigAdmin.ExpressionWrapper();
   wr.objectName = 'TM_Application_Form__c';
   wr.fieldName = 'Gross_Annual_Income__c';
   wr.operator = '>';
   wr.fieldValue = '10000';   
   wr.logicalOperator='null';
    wr.getAnalysisObjects();
    wr.getObjects();
   wr.getFields();
   wr.getOperators();
   wr.getLogicalOperators();
   ruleConfig.expressionList.add(wr);
   SWATRuleConfigAdmin.ExpressionWrapper wr1 = new SWATRuleConfigAdmin.ExpressionWrapper(1);
   
   wr1.objectName = 'TM_Application_Form__c';
   wr1.fieldName = 'Travel_Insurance__c';
   wr1.operator = '>';
   wr1.fieldValue = '5000';   
   wr1.logicalOperator='AND';
    wr1.getAnalysisObjects();
    wr1.getObjects();
   wr1.getFields();
   wr1.getOperators();
   wr1.getLogicalOperators();
   ruleConfig.expressionList.add(wr1);
   system.debug('Expression list'+ruleConfig.expressionList);
   ruleConfig.selectedIndex=0;
   ruleConfig.deleteExpressionFromRule(); 
   ruleConfig.selectedIndex=1; 
   ruleConfig.addNewExpressionIntoRule();  
   ruleConfig.save();
 
   
   ruleConfig.selectedIndex=0; 
   ruleConfig.addNewExpressionIntoRule();
   ruleConfig.save();
  
   
   
   
   }
  }

}