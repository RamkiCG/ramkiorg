public class SWAT_RuleEngineCore 
{  
    //get or set objectsInTheRuleMap
    public static map<string, set<string>> objectsInTheRuleMap {get; set;}
    
    //get or set describeObjectResults
    public static list<Schema.DescribeSobjectResult> describeObjectResults {get; set;}
    
    //get or set fieldsMap
    public static map<string, Schema.SObjectField> fieldsMap {get; set;} 
    
    //get or set fieldsDescribeResultMap
    public static map<string, Schema.DescribeFieldResult> fieldsDescribeResultMap {get; set;} 
    
    //constructor
    public SWAT_RuleEngineCore(){}
       
    //Rule Info Class   
    public class RuleInfo
    {
        
        public string ruleID;
        public string ruleName;
        public string ruleDescription;
        //public string ruleExpression;
        public list<SWATRuleConfigAdmin.JSONWrapper> ruleExpression;
        public decimal priority;
        public date effectiveDate;
        public date expiryDate;
        public string message;
        public string severity;
        
        public RuleInfo()
        {
            ruleExpression = new list<SWATRuleConfigAdmin.JSONWrapper>();
        }
    }
    
    //RulegroupMapping Class
    public class RuleGroupMapping
    {
        public string groupId;
        public string groupName;
        public decimal execPriority;
        public boolean active; 
        public list<RuleInfo> attachedRuleList;   
    }
    
    //ExecutionResult Class
    public class ExecutionResult 
    {
        public string groupName {get; set;}
        public list<string> errorMessages {get; set;} //variable to hold the error text
        public list<RuleResult> ruleExecutedResults {get; set;}   
        
        public ExecutionResult()
        {
            errorMessages = new list<string>();
            ruleExecutedResults = new list<RuleResult>();
        }    
    }
    
    //RuleResult Class
    public class RuleResult 
    {
        public string ruleName {get; set;}
        public list<String> errorFields {get; set;} //variable to hold the field name
        public string message {get; set;} //variable to hold the error text
        public string severity {get; set;} 
        
        public RuleResult()
        {
            errorFields = new list<String>();
        } 
    }
    
    //ExpressionResult Class
    public class ExpressionResult
    {
        public boolean status {get; set;}
        public list<string> errorFields{get; set;}
        public string message{get; set;}    
        
        public ExpressionResult()
        {
            errorFields = new list<string>();
        }
        
    }
    
    // Returns all rules associated with a rule group
    public static map<Id, list<RuleInfo>> getRulesByGroup(set<Id> ruleGroupIds)
    {
      try
      {
            map<Id, list<RuleInfo>> attachedRuleMap = new map<Id, list<RuleInfo>>();
            objectsInTheRuleMap = new map<string, set<string>>();
            
            String query = 'select ID, Name,RuleGroupID__c,SWATRule__r.ID, SWATRule__r.RuleDescription__c, SWATRule__r.Rule_Expression__c, SWATRule__r.name, EffectiveDate__c, ExpirationDate__c, Message__c, Priority__c, Severity__c from SWATRuleMapping__c where RuleGroupID__c IN : ruleGroupIds and RuleGroupID__r.Active__c = true';
            for(SWATRuleMapping__c ruleMappingInfo: database.query(query))
            {
                RuleInfo attachedRule = new RuleInfo();
                attachedRule.ruleID = ruleMappingInfo.SWATRule__r.ID;
                attachedRule.ruleName = ruleMappingInfo.SWATRule__r.name;
                attachedRule.ruleDescription = ruleMappingInfo.SWATRule__r.RuleDescription__c;

                if(ruleMappingInfo.SWATRule__r.Rule_Expression__c <> null)
                {
                    list<Object> jsonValueList = (list<Object>)JSON.deserializeUntyped(ruleMappingInfo.SWATRule__r.Rule_Expression__c);
                    
                    attachedRule.ruleExpression =  new list<SWATRuleConfigAdmin.JSONWrapper>();
                    for(Object val: jsonValueList)
                    {
                        SWATRuleConfigAdmin.JSONWrapper info = (SWATRuleConfigAdmin.JSONWrapper)JSON.deserializeStrict(JSON.serializePretty((Map<String, Object>)val),SWATRuleConfigAdmin.JSONWrapper.Class);
                        attachedRule.ruleExpression.add(info);
                        
                        system.debug('json wrapper'+info);
                        
                        set<string> fieldSet = new set<string>();
                        if(objectsInTheRuleMap.containsKey(info.objectName))
                        {
                            fieldSet = objectsInTheRuleMap.get(info.objectName);
                            fieldSet.add(info.fieldName);
                        }
                        else
                        {
                            fieldSet.add(info.fieldName);
                        }
                        objectsInTheRuleMap.put(info.objectName, fieldSet);
                    }
                    system.debug('object map $$$$$$$'+objectsInTheRuleMap);
                }
                
                attachedRule.priority = ruleMappingInfo.Priority__c;
                attachedRule.effectiveDate = ruleMappingInfo.EffectiveDate__c;
                attachedRule.expiryDate = ruleMappingInfo.ExpirationDate__c;
                attachedRule.message = ruleMappingInfo.Message__c;
                attachedRule.severity = ruleMappingInfo.Severity__c;   
                
                list<RuleInfo> ruleInfoList = new list<RuleInfo>();    
                if(attachedRuleMap.containsKey(ruleMappingInfo.RuleGroupID__c))
                {
                    ruleInfoList = attachedRuleMap.get(ruleMappingInfo.RuleGroupID__c);
                    ruleInfoList.add(attachedRule);             
                }
                else
                { 
                    ruleInfoList.add(attachedRule);             
                }
                attachedRuleMap.put(ruleMappingInfo.RuleGroupID__c, ruleInfoList);
            }
            return attachedRuleMap;
       }
        catch(Exception e)
        {
            system.debug('Error from SWAT_RuleEngineCore  getRulesByGroup method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
            return null;
        }
    }
    
     // Returns all rules associated with a rule group by name
    public static List<RuleInfo> getRulesByGroupName(string groupName)
    {
      try
      {
              list<RuleInfo> ruleInfoList = new list<RuleInfo>();    
            objectsInTheRuleMap = new map<string, set<string>>();
            
            String query = 'select ID, Name,RuleGroupID__c,SWATRule__r.ID, SWATRule__r.RuleDescription__c, SWATRule__r.Rule_Expression__c, SWATRule__r.name, EffectiveDate__c, ExpirationDate__c, Message__c, Priority__c, Severity__c from SWATRuleMapping__c where RuleGroupID__r.Name=: groupName and RuleGroupID__r.Active__c = true';
            for(SWATRuleMapping__c ruleMappingInfo: database.query(query))
            {
                RuleInfo attachedRule = new RuleInfo();
                attachedRule.ruleID = ruleMappingInfo.SWATRule__r.ID;
                attachedRule.ruleName = ruleMappingInfo.SWATRule__r.name;
                attachedRule.ruleDescription = ruleMappingInfo.SWATRule__r.RuleDescription__c;

                if(ruleMappingInfo.SWATRule__r.Rule_Expression__c <> null)
                {
                    list<Object> jsonValueList = (list<Object>)JSON.deserializeUntyped(ruleMappingInfo.SWATRule__r.Rule_Expression__c);
                    
                    attachedRule.ruleExpression =  new list<SWATRuleConfigAdmin.JSONWrapper>();
                    for(Object val: jsonValueList)
                    {
                        SWATRuleConfigAdmin.JSONWrapper info = (SWATRuleConfigAdmin.JSONWrapper)JSON.deserializeStrict(JSON.serializePretty((Map<String, Object>)val),SWATRuleConfigAdmin.JSONWrapper.Class);
                        attachedRule.ruleExpression.add(info);
                        
                        system.debug('json wrapper'+info);
                        
                        set<string> fieldSet = new set<string>();
                        if(objectsInTheRuleMap.containsKey(info.objectName))
                        {
                            fieldSet = objectsInTheRuleMap.get(info.objectName);
                            fieldSet.add(info.fieldName);
                        }
                        else
                        {
                            fieldSet.add(info.fieldName);
                        }
                        objectsInTheRuleMap.put(info.objectName, fieldSet);
                    }
                    system.debug('object map $$$$$$$'+objectsInTheRuleMap);
                }
                
                attachedRule.priority = ruleMappingInfo.Priority__c;
                attachedRule.effectiveDate = ruleMappingInfo.EffectiveDate__c;
                attachedRule.expiryDate = ruleMappingInfo.ExpirationDate__c;
                attachedRule.message = ruleMappingInfo.Message__c;
                attachedRule.severity = ruleMappingInfo.Severity__c;   
                
              
               
                    ruleInfoList.add(attachedRule);             
               
            }
            return ruleInfoList;
       }
        catch(Exception e)
        {
            system.debug('Error from SWAT_RuleEngineCore  getRulesByGroupName method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
            return null;
        }
    }
   
    
   // Returns all Rules Grouped by Rule Group for a given Product Id
    public static map<Id, RuleGroupMapping> getRulesByProduct(String productId)
    {
       try
       {
            map<Id, RuleGroupMapping> ruleGroupConfigMap = new map<id, RuleGroupMapping>();
            map<Id, list<RuleInfo>> ruleInfoMap = new  map<Id, list<RuleInfo>>();
            
            for(SWATRule_Engine_Configuration__c rec: [select ID, SWATRuleGroup__c,SWATRuleGroup__r.Name, Priority__c, Active__c from SWATRule_Engine_Configuration__c where ObjectRecordId__c =: productId and Active__c = true and SWATRuleGroup__r.Active__c = true])
            {
                RuleGroupMapping wrp = new RuleGroupMapping();
                wrp.groupId = rec.SWATRuleGroup__c;
                wrp.groupName = rec.SWATRuleGroup__r.Name;
                wrp.execPriority = rec.Priority__c;
                wrp.active = rec.Active__c;
                ruleGroupConfigMap.put(rec.SWATRuleGroup__c, wrp);
            }

            //get the rules list
            ruleInfoMap = getRulesByGroup(ruleGroupConfigMap.keySet());

            
            for(Id groupId: ruleGroupConfigMap.keySet())
            {
                RuleGroupMapping w = ruleGroupConfigMap.get(groupId);
                w.attachedRuleList = (ruleInfoMap.containsKey(groupId))? ruleInfoMap.get(groupId) : null;
            }

            return ruleGroupConfigMap;     
        }
        catch(Exception e)
        {
            system.debug('Error from SWAT_RuleEngineCore  getRulesByProduct method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
            return null;
        }
    }

    // Execute all rule groups / rules for a given product
    public static list<ExecutionResult> executeRulesByProduct(String productId, map<string, Id> referenceObjectMap)
    {        
        list<ExecutionResult> results = new list<ExecutionResult>();
        fieldsDescribeResultMap = new map<string, Schema.DescribeFieldResult>();
        
        map<Id, RuleGroupMapping> assingedRuleGroupMap = getRulesByProduct(productId);
        
        try
        {
            //describe available objects information 
            system.debug('object in the map'+ objectsInTheRuleMap);
            describeObjectResults = Schema.describeSObjects(convertToList(objectsInTheRuleMap.keySet()));
            system.debug('describe results'+ describeObjectResults );
            for(Schema.DescribeSobjectResult res : describeObjectResults) 
            {
                for(Schema.SObjectField field: res.fields.getMap().values())
                {
                    if(objectsInTheRuleMap.get(res.getName()).contains(string.valueOf(field)))
                    {  
                        Schema.DescribeFieldResult fldInfo = field.getDescribe(); 
                        fieldsDescribeResultMap.put(fldInfo.getName(), fldInfo);
                    }
                }
            }
            
            
            
            for(Id ruleGroupId: assingedRuleGroupMap.keySet()){         
                ExecutionResult result = new ExecutionResult();
                
                RuleGroupMapping ruleGroup = assingedRuleGroupMap.get(ruleGroupId); 
                result.groupName = ruleGroup.groupName;
                
                if(ruleGroup.attachedRuleList <> null && ruleGroup.attachedRuleList.size() > 0)
                {
                    for(RuleInfo rule: ruleGroup.attachedRuleList)
                    {             
                        if(rule.effectiveDate <= date.today() && rule.expiryDate >= date.today())
                        {
                            
                            ExpressionResult expResult = validateExpression(rule.ruleExpression, referenceObjectMap);
                            //
                            if(!expResult.status)
                            {                      
                                if(expResult.message <> null)
                                {
                                    result.errorMessages.add(expResult.message);
                                } 
                                else 
                                {    
                                    RuleResult rlResult = new RuleResult();                     
                                    rlResult.ruleName = rule.ruleName;
                                    rlResult.message = rule.message;
                                    rlResult.severity = rule.severity;  
                                    rlResult.errorFields.addAll(expResult.errorfields);
                                    result.ruleExecutedResults.add(rlResult);
                                }
                            }
                            else
                            {
                                RuleResult rlResult = new RuleResult();                     
                                rlResult.ruleName = rule.ruleName;
                                rlResult.message = 'SUCCESS';
                                result.ruleExecutedResults.add(rlResult);
                            }
                        }
                        else
                        {                  
                            result.errorMessages.add(rule.ruleName+' Expired');
                        }
                    }
                }
                results.add(result);
            }
     } 
     catch(exception e)
     {
         system.debug('Error from SWAT_RuleEngineCore  executeRulesByProduct method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
     }
     return results;
    }
    
    
     // Execute all rule groups / rules for a given product
    public static list<ExecutionResult> executeRulesByGroupName(String groupName, map<string, Id> referenceObjectMap)
    {        
        list<ExecutionResult> results = new list<ExecutionResult>();
        fieldsDescribeResultMap = new map<string, Schema.DescribeFieldResult>();
        try
        {
           List<RuleInfo> myRuleInfoList=new List<RuleInfo>();
           myRuleInfoList=getRulesByGroupName(groupName);
            
                     
                ExecutionResult result = new ExecutionResult();
                
             
               // getRulesByGroupName(groupName);
                if(myRuleInfoList <> null && myRuleInfoList.size() > 0)
                {
                    for(RuleInfo rule: myRuleInfoList)
                    {             
                        if(rule.effectiveDate <= date.today() && rule.expiryDate >= date.today())
                        {
                            
                            ExpressionResult expResult = validateExpression(rule.ruleExpression, referenceObjectMap);
                            //
                            if(!expResult.status)
                            {                      
                                if(expResult.message <> null)
                                {
                                    result.errorMessages.add(expResult.message);
                                } 
                                else 
                                {    
                                    RuleResult rlResult = new RuleResult();                     
                                    rlResult.ruleName = rule.ruleName;
                                    rlResult.message = rule.message;
                                    rlResult.severity = rule.severity;  
                                    rlResult.errorFields.addAll(expResult.errorfields);
                                    result.ruleExecutedResults.add(rlResult);
                                }
                            }
                            else
                            {
                                RuleResult rlResult = new RuleResult();                     
                                rlResult.ruleName = rule.ruleName;
                                rlResult.message = 'SUCCESS';
                                result.ruleExecutedResults.add(rlResult);
                            }
                        }
                        else
                        {                  
                            result.errorMessages.add(rule.ruleName+' Expired');
                        }
                    }
                }
                results.add(result);
            
     } 
     catch(exception e)
     {
         system.debug('Error from SWAT_RuleEngineCore  executeRulesByProduct method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
     }
     return results;
    }
    
     // Execute all rule groups / rules for a given product
    public static list<ExecutionResult> executeRulesByGroupName(String groupName, Sobject sobj)
    {        
        list<ExecutionResult> results = new list<ExecutionResult>();
        fieldsDescribeResultMap = new map<string, Schema.DescribeFieldResult>();
        try
        {
           List<RuleInfo> myRuleInfoList=new List<RuleInfo>();
           myRuleInfoList=getRulesByGroupName(groupName);
           system.debug('myruleinfolist$'+myruleInfolist);
                     
                ExecutionResult result = new ExecutionResult();
                
             
               // getRulesByGroupName(groupName);
                if(myRuleInfoList <> null && myRuleInfoList.size() > 0)
                {
                    for(RuleInfo rule: myRuleInfoList)
                    {             
                        if(rule.effectiveDate <= date.today() && rule.expiryDate >= date.today())
                        {
                            
                            ExpressionResult expResult = validateExpression(rule.ruleExpression, sobj);
                            //
                            if(!expResult.status)
                            {                      
                                if(expResult.message <> null)
                                {
                                    result.errorMessages.add(expResult.message);
                                } 
                                else 
                                {    
                                    RuleResult rlResult = new RuleResult();                     
                                    rlResult.ruleName = rule.ruleName;
                                    rlResult.message = rule.message;
                                    rlResult.severity = rule.severity;  
                                    rlResult.errorFields.addAll(expResult.errorfields);
                                    result.ruleExecutedResults.add(rlResult);
                                }
                            }
                            else
                            {
                                RuleResult rlResult = new RuleResult();                     
                                rlResult.ruleName = rule.ruleName;
                                rlResult.message = 'SUCCESS';
                                result.ruleExecutedResults.add(rlResult);
                            }
                        }
                        else
                        {                  
                            result.errorMessages.add(rule.ruleName+' Expired');
                        }
                    }
                }
                results.add(result);
            
     } 
     catch(exception e)
     {
         system.debug('Error from SWAT_RuleEngineCore  executeRulesByProduct method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
     }
     return results;
    }
    
    //validateExpression from rule JSOn and give referenceObjectMap Id
    public static ExpressionResult validateExpression(list<SWATRuleConfigAdmin.JSONWrapper> expressionJSON, map<string, Id> referenceObjectMap)
    {
      try
      {
        ExpressionResult expResult =  new ExpressionResult();   
        boolean conditionstatus = false;
        list<string> queryStringList = new list<string>();
        for(SWATRuleConfigAdmin.JSONWrapper info: expressionJSON)
        {
            Schema.DescribeFieldResult fieldDescResult = fieldsDescribeResultMap.get(info.fieldName);
            system.debug('Field Describe'+fieldDescResult );
            
            string query = 'SELECT Id,';
            query = query + info.fieldName + ' FROM '+ info.objectName +' WHERE ' + getWhereClause(info.fieldName,info.operator, info.fieldValue, string.valueOf(fieldDescResult.getType()));
            query = query + ' AND Id=\''+referenceObjectMap.get(info.objectName)+'\'';
            queryStringList.add(query);
            
            system.debug('Query ####'+query );

            
            // If query returned rows, then condition passed (value = true) 
            List<sObject> result = Database.query(query);
            if(result.size() > 0)
            {
                if(info.logicalOperator == null)
                {
                    conditionstatus = true;
                }
                else
                {
                    if(info.logicalOperator == 'AND')
                    {
                        conditionStatus = (conditionStatus && true);    
                    }
                    else if (info.logicalOperator == 'OR')
                    {
                        conditionStatus = true;                 
                    } 
                }
            } 
            else 
            {
                if(info.logicalOperator == null)
                {
                    conditionstatus = false;
                    expResult.errorFields.add(info.objectName + '.' + info.fieldName);
                }
                else
                {
                    if(info.logicalOperator == 'AND')
                    {
                        conditionStatus = false;
                        expResult.errorFields.add(info.objectName + '.' + info.fieldName);
                    }
                }
            }
        }
        expResult.status = conditionStatus;
        return expResult;
        } 
     catch(exception e)
     {
         system.debug('Error from SWAT_RuleEngineCore  validateExpression method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
         return null;
     }
        
    }
    
    //getWhereClause method for generate dynamic condition query
    public static string getWhereClause(string fieldName, string operator, string value, string fieldType)
    {
       try
       {
        string whereClause = '';
        
        system.debug('Field type' + fieldType);
        
        if(operator == 'LIKE')
        {
            whereClause = whereClause + fieldName + 'LIKE \'%' +value + '%\'';
        }
        else if(operator == 'NOT LIKE')
        {
            whereClause = whereClause + 'NOT(' + fieldName + 'LIKE \'%' +value + '%\')';
        }
        else
        {
            if(fieldType == 'integer' || fieldType == 'double' || fieldType == 'boolean' || fieldType == 'CURRENCY')
            {
                whereClause = whereClause + fieldName + operator + value;
            } 
            else 
            {
                whereClause = whereClause + fieldName + operator + '\'' + value + '\'';
            }
        }
        return whereClause;
        }
        
     catch(exception e)
     {
         system.debug('Error from SWAT_RuleEngineCore  getWhereClause method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
         return null;
     }
    }
    
    //convertList 
    public static list<string> convertToList(set<string> setToConvert) 
    {
      try
      {
        list<string> lstString = new list<string>();
        lstString.addAll(setToConvert);
        return lstString;
      }
      catch(exception e)
      {
         system.debug('Error from SWAT_RuleEngineCore  getWhereClause method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
          return null;
      } 
    }
    
    //ExecuteRules By ProductName with param1-productname ,param2-Sobject
    public static list<ExecutionResult> ExecuteRulesByProductName(String productName, SObject SObj)
    {   
     try
         {     
            list<ExecutionResult> exeresult=new list<ExecutionResult>();
            SWATRule_Engine_Configuration__c ruleconfig=[select ID,ObjectRecordId__c,SWATRuleGroup__c,SWATRuleGroup__r.Name, Priority__c, Active__c from SWATRule_Engine_Configuration__c where ObjectRecordName__c =: productName and Active__c = true and SWATRuleGroup__r.Active__c = true limit 1];
             if(ruleconfig != null)
             {
             exeresult=ExecuteRulesByProduct(ruleconfig.ObjectRecordId__c,SObj);

             }
             else
             {
             return null;
             }
             return exeresult;
         } 
      catch(exception e)
      {
          system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesByProductName method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
          return null;
      }
    }
    
    //ExecuteRules By ProductName with param1-productname ,param2-referenceObjectMap 
    public static list<ExecutionResult> ExecuteRulesByProductName(String productName,  map<string, Id> referenceObjectMap)
    {   
     try
         {     
            list<ExecutionResult> exeresult=new list<ExecutionResult>();
            SWATRule_Engine_Configuration__c ruleconfig=[select ID,ObjectRecordId__c,SWATRuleGroup__c,SWATRuleGroup__r.Name, Priority__c, Active__c from SWATRule_Engine_Configuration__c where ObjectRecordName__c =: productName and Active__c = true and SWATRuleGroup__r.Active__c = true limit 1];
             if(ruleconfig != null)
             {
             exeresult=ExecuteRulesByProduct(ruleconfig.ObjectRecordId__c,referenceObjectMap);

             }
             else
             {
             return null;
             }
             return exeresult;
         } 
      catch(exception e)
      {
          system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesByProductName method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
          return null;
      }
    }
    
   
    
    // Execute all rule groups / rules for a given product and pass SObject  
    public static list<ExecutionResult> ExecuteRulesByProduct(String productId, SObject SObj)
    {        
        list<ExecutionResult> results = new list<ExecutionResult>();
        fieldsDescribeResultMap = new map<string, Schema.DescribeFieldResult>();        
        map<Id, RuleGroupMapping> assingedRuleGroupMap = getRulesByProduct(productId);        
        try
        {
        //describe available objects information 
        system.debug('object in the map'+ objectsInTheRuleMap);
        describeObjectResults = Schema.describeSObjects(convertToList(objectsInTheRuleMap.keySet()));
        system.debug('describe results'+ describeObjectResults );
        for(Schema.DescribeSobjectResult res : describeObjectResults) 
        {
            for(Schema.SObjectField field: res.fields.getMap().values())
            {
                if(objectsInTheRuleMap.get(res.getName()).contains(string.valueOf(field)))
                {  
                    Schema.DescribeFieldResult fldInfo = field.getDescribe(); 
                    fieldsDescribeResultMap.put(fldInfo.getName(), fldInfo);
                }
            }
        }
        
        
        
        for(Id ruleGroupId: assingedRuleGroupMap.keySet())
        {         
            ExecutionResult result = new ExecutionResult();            
            RuleGroupMapping ruleGroup = assingedRuleGroupMap.get(ruleGroupId); 
            result.groupName = ruleGroup.groupName;
            
            if(ruleGroup.attachedRuleList <> null && ruleGroup.attachedRuleList.size() > 0)
            {
                for(RuleInfo rule: ruleGroup.attachedRuleList)
                {             
                    if(rule.effectiveDate <= date.today() && rule.expiryDate >= date.today())
                    {
                        
                        ExpressionResult expResult =validateExpression(rule.ruleExpression, SObj);// null;//validateExpression(rule.ruleExpression, referenceObjectMap);
                        //
                        if(!expResult.status)
                        {                      
                            if(expResult.message <> null)
                            {
                                result.errorMessages.add(expResult.message);
                            } 
                            else 
                            {    
                                RuleResult rlResult = new RuleResult();                     
                                rlResult.ruleName = rule.ruleName;
                                rlResult.message = rule.message;
                                rlResult.severity = rule.severity;  
                                rlResult.errorFields.addAll(expResult.errorfields);
                                result.ruleExecutedResults.add(rlResult);
                            }
                        }
                        else
                        {
                            RuleResult rlResult = new RuleResult();                     
                            rlResult.ruleName = rule.ruleName;
                            rlResult.message = 'SUCCESS';
                            result.ruleExecutedResults.add(rlResult);
                        }
                    }
                    else
                    {                  
                        result.errorMessages.add(rule.ruleName+' Expired');
                    }
                }
            }
            results.add(result);
        }
        return results;
     } 
     catch(exception e)
     {
          system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesByProduct method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
          return null;
     }
        
    }
    
     //validate expression with params List of expressionJson, Sobject
     public static ExpressionResult validateExpression(list<SWATRuleConfigAdmin.JSONWrapper> expressionJSON, SObject SObj)
     {
      
        ExpressionResult expResult =  new ExpressionResult(); 
          
        boolean conditionstatus = true;
        boolean ischeckValidate= false;
        list<string> queryStringList = new list<string>();
        try
          {
          system.debug('expressionJSON++++' +expressionJSON);
           for(SWATRuleConfigAdmin.JSONWrapper info: expressionJSON)
           {
                Schema.DescribeFieldResult fieldDescResult = fieldsDescribeResultMap.get(info.fieldName);
                system.debug('Field Describe'+fieldDescResult);              
                system.debug('getSObjectType####'+string.valueof(SObj.getSObjectType()));
                system.debug('objectName####'+info.objectName);
                system.debug('objectName condition####'+string.valueof(SObj.getSObjectType()).equals(info.objectName));
                system.debug('SWATAdmin JSONWrapper  info'+info);
               /* if(string.valueof(SObj.getSObjectType()).equals(info.objectName))
                {
                ischeckValidate=checkValidate(info,Sobj);
                }
                else
                {
                ischeckValidate=true;
                }*/
                ischeckValidate=validateExpressionSObject(info,Sobj);
                system.debug('ischeckValidate $$$$'+ischeckValidate);
                if(IscheckValidate)
                {
               
                   system.debug('logicalOperator if$$$$'+info.logicalOperator );
                    if(info.logicalOperator == null)
                    {
                        conditionstatus = true;
                    }
                    else
                    {
                        if(info.logicalOperator == 'AND')
                        {
                            conditionStatus = (conditionStatus && true);    
                        }
                        else if (info.logicalOperator == 'OR')
                        {
                            conditionStatus = true;                 
                        } 
                    }
                
                } 
                else 
                {
               
                   system.debug('logicalOperator else$$$$'+info.logicalOperator );
                    if(info.logicalOperator == null)
                    {
                        conditionstatus = false;
                      
                        system.debug('logicalOperator else1$$$$'+info.logicalOperator );
                        expResult.errorFields.add(info.objectName + '.' + info.fieldName);
                    }
                    else
                    {
                        if(info.logicalOperator == 'AND')
                        {
                            conditionStatus = false;
                         //   expResult.FieldName=info.fieldName;
                            system.debug('logicalOperator else2$$$$'+info.logicalOperator );
                            expResult.errorFields.add(info.objectName + '.' + info.fieldName);
                        }
                    }
                    
                }
        }
        expResult.status = conditionStatus;        
        return expResult;
        } 
     catch(exception e)
    {
          system.debug('Error from SWAT_RuleEngineCore  validateExpression method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
          return null;
     }
    }
    
    //validate expressionSObject Params Jsonwrapper,SObject
    public static boolean validateExpressionSObject(SWATRuleConfigAdmin.JSONWrapper info,SObject SObj)
    {
       try
         {       
                 boolean isValidate;
                 Schema.SObjectType t = Schema.getGlobalDescribe().get(string.valueof(SObj.getSObjectType())); 
                 Schema.DescribeSObjectResult r = t.getDescribe();                 
                 Schema.DescribeFieldResult f = r.fields.getMap().get(info.fieldName).getDescribe();
                  if( f!= null)
                  { 
                      system.debug('field$$$$$'+f.getname()+'-----'+f.getType()); 
                
                      string inputvalue=string.valueof(SObj.get(info.fieldName));
                      
                      String fielddatatype = String.valueof(f.getType());
                     // type t1= Type.forName(String.valueof(f.getType()));
                
                     system.debug('field$$$$$--'+f.getType()+'-----');
                     object test;
                     //if( t1.getname() == 'currency' || t1.getname() == 'double' || t1.getname() == 'percent' || t1.getname() == 'decimal')
                     if( fielddatatype == 'currency' || fielddatatype == 'double' || fielddatatype == 'percent' || fielddatatype == 'decimal')
                     {
                           system.debug('the info.operator---'+info.operator);
                         system.debug('the info.fieldValue---'+info.fieldValue);
                         system.debug('the info.inputvalue---'+inputvalue); 
                         if(info.operator =='>=')// '<=', '>', '<'
                         {
                         decimal d1 = decimal.valueof(info.fieldValue);
                         decimal d2 =  decimal.valueof(inputvalue);//decimal.valueof(SObj.get(info.fieldName));               
                         test=d2 >= d1 ;
                         }
                         else if(info.operator =='<=')// '<=', '>', '<'
                         {
                         decimal d1 = decimal.valueof(info.fieldValue);
                          decimal d2 =  decimal.valueof(inputvalue);               
                         test=d2 <= d1 ;
                         }
                         else if(info.operator =='>')// '<=', '>', '<'
                         {
                         decimal d1 = decimal.valueof(info.fieldValue);
                         decimal d2 =  decimal.valueof(inputvalue);               
                         test=d2 > d1 ;
                         }
                         else if(info.operator =='<')// '<=', '>', '<'
                         {
                         decimal d1 = decimal.valueof(info.fieldValue);
                         decimal d2 =  decimal.valueof(inputvalue);               
                         test=d2 < d1 ;
                         }
                          else if(info.operator =='==')// '<=', '>', '<'
                         {
                         decimal d1 = decimal.valueof(info.fieldValue);
                         decimal d2 =  decimal.valueof(inputvalue);               
                         test=d2 == d1 ;
                         }
                         else if(info.operator =='<>')// '<=', '>', '<'
                         {
                         decimal d1 = decimal.valueof(info.fieldValue);
                         decimal d2 =  decimal.valueof(inputvalue);               
                         test=d2 <> d1 ;
                         }
                         
                     }
                     else if(fielddatatype =='integer')
                     {
                         if(info.operator =='>=')// '<=', '>', '<'
                         {
                         integer d1 = integer.valueof(info.fieldValue);
                         integer d2 =  integer.valueof(inputvalue);               
                         test=d2 >= d1 ;
                         }
                         else if(info.operator =='<=')// '<=', '>', '<'
                         {
                         integer d1 = integer.valueof(info.fieldValue);
                         integer d2 =  integer.valueof(inputvalue);               
                         test=d2 <= d1 ;
                         }
                         else if(info.operator =='>')// '<=', '>', '<'
                         {
                         integer d1 = integer.valueof(info.fieldValue);
                         integer d2 =  integer.valueof(inputvalue);               
                         test=d2 > d1 ;
                         }
                         else if(info.operator =='<')// '<=', '>', '<'
                         {
                         integer d1 = integer.valueof(info.fieldValue);
                         integer d2 =  integer.valueof(inputvalue);               
                         test=d2 < d1 ;
                         }
                         else if(info.operator =='=')// '<=', '>', '<'
                         {
                         integer d1 = integer.valueof(info.fieldValue);
                         integer d2 =  integer.valueof(inputvalue);               
                         test=d2 == d1 ;
                         }
                         else if(info.operator =='<>')// '<=', '>', '<'
                         {
                         integer d1 = integer.valueof(info.fieldValue);
                         integer d2 =  integer.valueof(inputvalue);               
                         test=d2 <> d1 ;
                         }
                         
                     }
                    else if(fielddatatype =='string' || fielddatatype =='REFERENCE')
                     {
                         system.debug('the info.operator---'+info.operator);
                         system.debug('the info.fieldValue---'+info.fieldValue);
                         system.debug('the info.inputvalue---'+inputvalue);                         
                       if(info.operator == '=')// '<=', '>', '<'
                         {
                         string d1 = string.valueof(info.fieldValue);
                         string d2 =  string.valueof(inputvalue); 
                          system.debug('the d1 == d2--'+d1.equals(d2)+'-----');            
                         test = d2.equals(d1);
                          
                         }
                         else if(info.operator == '<>')// '<=', '>', '<'
                         {
                         string d1 = string.valueof(info.fieldValue);
                         string d2 =  string.valueof(inputvalue);               
                         test=d2 <> d1 ;
                         }
                     }                 
                      Boolean ret = Boolean.valueOf(test); 
                      system.debug('ret $$$$$'+ret );
                      if(ret)
                      {
                          isValidate=true;
                      }
                      else
                      { 
                          isValidate=false;                          
                          system.debug('isValidate$$$$$'+isValidate);
                      }
                  }
                  else
                  {
                   isValidate=true;  
                   system.debug('FieldName does not exists in this object $'+info.objectName+',the field name is'+info.fieldName);               
                  }
                  return isValidate;
                   
                }
            
        
        catch(Exception e)
        {
                system.debug('Error from SWAT_RuleEngineCore  validateExpressionSObject method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
                return false;              
        }
    }
    
     //get Errormessage list from list of ExecutionResult
     public static List<string> getErrorMessageList(List<ExecutionResult> ruleEngineExecutionResult)
     {
         try
         {
            List<String> errorMsgs = new List<String>();
           for(ExecutionResult res: ruleEngineExecutionResult)
                      {                  
                          for(RuleResult ruleResult: res.ruleExecutedResults)
                          {
                             if(ruleResult.message <> 'SUCCESS')
                                {
                                errorMsgs.Add(ruleResult.message);                                       
                                }
                          }
                       }    
                       system.debug('errorMsgs'+errorMsgs);          
                      return errorMsgs;
                 }
                 catch(Exception e)
                 {
                   system.debug('Error from SWAT_RuleEngineCore  getErrorMessageList$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
                   return null;
                 }
      }       
     
     
      //Execute Rules using params productId,Sobject
      public static List<string> ExecuteRules(string prodid,SObject obj)
        {
              try
              {
                  List<String> errorMsgs = new List<String>();                 
                  List<ExecutionResult> ruleEngineExecutionResult = ExecuteRulesByProduct(prodid, obj); 
                  errorMsgs=getErrorMessageList(ruleEngineExecutionResult );          
                  return errorMsgs;
             }
             catch(Exception e)
             {
               system.debug('Error from SWAT_RuleEngineCore  ExecuteRules$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
               return null;
             }
        }
        
        //Execute Rules using params productId,referenceObjectMap
        public static List<string> ExecuteRules(string prodid,map<string, Id> referenceObjectMap)
        {
              try
              {
                  List<String> errorMsgs = new List<String>();                 
                  List<ExecutionResult> ruleEngineExecutionResult = ExecuteRulesByProduct(prodid, referenceObjectMap); 
                  errorMsgs=getErrorMessageList(ruleEngineExecutionResult );  
                  return errorMsgs;
             }
             catch(Exception e)
             {
               system.debug('Error from SWAT_RuleEngineCore  ExecuteRules$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
               return null;
             }
        }
        
        
          //Execute Rules using params productId,Sobject
      public static List<string> ExecuteRulesProductName(string prodName,SObject obj)
        {
              try
              {
                  List<String> errorMsgs = new List<String>();                 
                  List<ExecutionResult> ruleEngineExecutionResult = ExecuteRulesByProductName(prodName, obj); 
                  errorMsgs=getErrorMessageList(ruleEngineExecutionResult );          
                  return errorMsgs;
             }
             catch(Exception e)
             {
               system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesProductName$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
               return null;
             }
        }
        
        //Execute Rules using params productId,referenceObjectMap
        public static List<string> ExecuteRulesProductName(string prodName,map<string, Id> referenceObjectMap)
        {
              try
              {
                  List<String> errorMsgs = new List<String>();                 
                  List<ExecutionResult> ruleEngineExecutionResult = ExecuteRulesByProductName(prodName, referenceObjectMap); 
                  errorMsgs=getErrorMessageList(ruleEngineExecutionResult );  
                  return errorMsgs;
             }
             catch(Exception e)
             {
               system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesProductName$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
               return null;
             }
        }
   
   
           //Execute Rules using params productId,Sobject
      public static List<string> ExecuteRulesGroupName(string prodName,SObject obj)
        {
              try
              {
                  List<String> errorMsgs = new List<String>();                 
                  List<ExecutionResult> ruleEngineExecutionResult = ExecuteRulesByGroupName(prodName, obj); 
                  errorMsgs=getErrorMessageList(ruleEngineExecutionResult );          
                  return errorMsgs;
             }
             catch(Exception e)
             {
               system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesGroupName$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
               return null;
             }
        }
        
        //Execute Rules using params productId,referenceObjectMap
        public static List<string> ExecuteRulesGroupName(string prodName,map<string, Id> referenceObjectMap)
        {
              try
              {
                  List<String> errorMsgs = new List<String>();                 
                  List<ExecutionResult> ruleEngineExecutionResult = ExecuteRulesByGroupName(prodName, referenceObjectMap); 
                  errorMsgs=getErrorMessageList(ruleEngineExecutionResult );  
                  return errorMsgs;
             }
             catch(Exception e)
             {
               system.debug('Error from SWAT_RuleEngineCore  ExecuteRulesGroupName$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
               return null;
             }
        }
   
     
        
}