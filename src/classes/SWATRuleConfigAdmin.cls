//**********************************************************
//Class Name        :    SWATRuleConfigAdmin  
//Purpose           :    Swat Rule Configurate contoller
//Created Date      :    
//Created By        :    
//Modified By       :   
//***********************************************************
public with sharing class SWATRuleConfigAdmin 
{
   public SWATRuleGroup__c ruleGroup {get; set;}
    public String selectedObject { get; set; }
    public string linkAction {get; set;}
    public SWATRule__c ruleDetails {get; set;}
    public SWATRuleMapping__c ruleMapping {get; set;}
    public SWATRule_Engine_Configuration__c ruleEngineConfiguration {get; set;}
    
    //Need Analysis
    //public SWAT_Need_Analysis__c needAnalysis {get; set;}
    public string objectType {get; set;}
    public string selectedObjectRecord {get; set;}
    public string recordId{get;set;}
    public string sObjectRecordId{get;set;}
    public static string sObjectRecord{get;set;}    
    public integer selectedIndex {get; set;}
    private Integer nextIdent{get;set;}
    public string selectedRecordToEdit {get; set;}
    public string selectedRecordToDelete {get; set;}
    public string activeTab {get; set;}
    
    public list<ExpressionWrapper> expressionList {get; set;}
    //public list<RuleWrapper> rulesList {get; set;}
    //public RuleAndGroupMappingWrapper ruleAndRuleGroupMapper {get; set;}
    public list<RuleEngineConfiguration> ruleEngineConfList {get; set;} 
    public list<SWATRule__c> rulesList{get; set;}
    
    
    //pagination
    public integer pageNumber {get; set;}
    public integer totalPages {get; set;}
    public integer lastPage {get; set;}
    public integer pageSize {get; set;}
    public integer previousPage {get; set;}
    public integer nextPage {get; set;}
    //public integer lastPage {get; set;}
    public integer startPage {get; set;}
    public integer endPage {get; set;}
    public integer adjacent {get; set;}
    public integer offsetPosition{get; set;}
    
    public map<string, string> panelTitleMap {get; set;}
    public string ruleEngineExecutionResult {get; set;}
    
    //constructor
    public SWATRuleConfigAdmin()
    {
        try
        {
            ruleDetails  = new SWATRule__c();
            ruleGroup = new SWATRuleGroup__c();
            ruleMapping = new SWATRuleMapping__c();
            
            //Need Analysis
           // needAnalysis = new SWAT_Need_Analysis__c(); 
            ruleEngineConfiguration = new SWATRule_Engine_Configuration__c();
            panelTitleMap = new map<string, string>{'home'=>'Home', 'create'=>'Create Rules', 'managerules'=>'Manage Rules','creategroup'=>'Create Rule Group','configure'=>'Configure Rules','productrecommend'=>'Product Recommendation'};
            linkAction = 'home'; 
            activeTab = 'rule';
            pageNumber  = 1;         
            init();
        }
        catch(Exception e)
        {           
            system.debug('Error from SWATAdmin  Constructor $:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        }       
    }
    
    public void init()
    {
        try
        {
            expressionList = new list<ExpressionWrapper>();
            ExpressionWrapper w = new ExpressionWrapper(0);
            w.disabled = true;
            w.logicalOperator = null;
            expressionList.add(w);          
            ruleEngineConfList = new list<RuleEngineConfiguration>();
            ruleEngineConfList.add(new RuleEngineConfiguration(0));
        
        }         
        catch(Exception e)
        {            
            system.debug('Error from SWATAdmin  init method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        }   
        /*ruleAndRuleGroupMapper = new RuleAndGroupMappingWrapper();
        ruleAndRuleGroupMapper.mappingElements = new list<MappingElementsWrapper>();
        ruleAndRuleGroupMapper.mappingElements.add(new MappingElementsWrapper(0)); */ 
    }
    
        
    public PageReference cancel() 
    {
        return null;
    }
    
    public void execute()
    {
        
        map<string, Id> referenceObjectMap = new map<string, Id>{'Lead'=>'00Q9000000mXKQk', 'Opportunity'=>'0069000000ViPF8'};
        ruleEngineExecutionResult = JSON.SerializePretty(SWAT_RuleEngineCore.executeRulesByProduct(ruleEngineConfiguration.ObjectRecordId__c, referenceObjectMap));       
    }
    
    public void addNewExpressionIntoRule() 
    {
       try
       {
            integer nextIndex;
            
            if(selectedIndex <> null )
            {
                system.debug('selected index'+selectedIndex );
                system.debug('size'+expressionList.size());
                if(selectedIndex  == (expressionList.size() - 1))
                {
                    nextIndex = selectedIndex + 1;
                    ExpressionWrapper newElement = new ExpressionWrapper(nextIndex);                
                    expressionList.add(newElement );
                } 
                else 
                {
                    List<ExpressionWrapper> experessionListTemp = new List<ExpressionWrapper>();                
                    for(Integer i = selectedIndex + 1; i < expressionList.size(); )
                    {
                        system.debug('to get' + i);
                        ExpressionWrapper w = expressionList.get(i);
                        experessionListTemp.add(w);
                        expressionList.remove(i);   
                        selectedIndex = selectedIndex;                  
                    }            
                    nextIndex = selectedIndex + 1;
                    ExpressionWrapper newElement = new ExpressionWrapper(nextIndex);                
                    expressionList.add( newElement );
                    
                    system.debug('actual list'+expressionList);
                    system.debug('temp list'+experessionListTemp);
                    
                    for(ExpressionWrapper temp: experessionListTemp)
                    {
                        temp.index = nextIndex + 1;
                        expressionList.add(temp);
                        nextIndex = temp.index;
                    }
                }
                system.debug('wrapper elements'+expressionList);
                if(expressionList.size() == 1)
                {
                    expressionList[0].disabled = true;
                }
                else 
                {
                    for(ExpressionWrapper w: expressionList)
                    {
                        w.disabled = false;
                    }
                }
            }
        }         
        catch(Exception e)
        {            
            system.debug('Error from SWATAdmin  addNewExpressionIntoRule method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        }  
    }
    
    public void deleteExpressionFromRule() 
    {
       try
       {
            if(selectedIndex <> null )
            {
                expressionList.remove(selectedIndex); 
            }        
            integer indx = 0;
            for(ExpressionWrapper w: expressionList)
            {
                w.index = indx;
                if(indx == 0)
                {
                    w.logicalOperator = null;
                }
                indx++;
            }        
            if(expressionList.size() == 1)
            {
                expressionList[0].disabled = true;
            }
            else 
            {
                for(ExpressionWrapper w: expressionList)
                {
                    w.disabled = false;
                }
            }
      }         
      catch(Exception e)
      {            
        system.debug('Error from SWATAdmin  deleteExpressionFromRule method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
      }
    }

    public void save() 
    {
      try
      {
                activeTab = 'rule';
                if(ruleDetails.Name != null && ruleDetails.Name!='' )
                {
                        list<JSONWrapper> wrapperList = new list<JSONWrapper>();
                        system.debug('Expression list'+expressionList);
                        for(ExpressionWrapper w: expressionList){
                            JSONWrapper jsonWrapper = new JSONWrapper();
                            jsonWrapper.orderNo = w.index;
                            jsonWrapper.objectName = w.objectName;
                            jsonWrapper.fieldName = w.fieldName;
                            jsonWrapper.operator = w.operator;
                            jsonWrapper.fieldValue= (w.selectedObject.get(w.fieldName) <> null)? string.valueOf(w.selectedObject.get(w.fieldName)) : w.fieldValue;
                            jsonWrapper.logicalOperator = w.logicalOperator; 
                            wrapperList.add(jsonWrapper);
                        }
                        system.debug('wrapper list'+wrapperList);
                        ruleDetails.Rule_Expression__c = JSON.serializePretty(wrapperList);
                        upsert ruleDetails; 
                        //initialize the rule object after the save
                        ruleDetails = new SWATRule__c();
                        expressionList = new list<ExpressionWrapper>();
                            ExpressionWrapper w = new ExpressionWrapper(0);
                            w.disabled = true;
                            expressionList.add(w);    
                }
                else
                {
                 ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please enter Rule Name')); 
                }
       }         
       catch(Exception e)
       {            
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Select Object, Fields, Operators and Corresponding Value ')); 
        system.debug('Error from SWATAdmin  addNewExpressionIntoRule method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
       }
        //return null;
    }

   /*
    // Need Analysis
    public void saveProductRecommendation()
     {
       
        activeTab = 'createreco';
        list<JSONWrapper> wrapperList = new list<JSONWrapper>();
        system.debug('Expression list'+expressionList);
        try
        {
            for(ExpressionWrapper w: expressionList)
            {
                JSONWrapper jsonWrapper = new JSONWrapper();
                jsonWrapper.orderNo = w.index;
                jsonWrapper.objectName = w.objectName;
                jsonWrapper.fieldName = w.fieldName;
                jsonWrapper.operator = w.operator;
                jsonWrapper.fieldValue= (w.selectedObject.get(w.fieldName) <> null)? string.valueOf(w.selectedObject.get(w.fieldName)) : w.fieldValue;
                jsonWrapper.logicalOperator = w.logicalOperator; 
                
                wrapperList.add(jsonWrapper);
            }
            system.debug('wrapper list'+wrapperList);
            needAnalysis.Rule_Expression__c = JSON.serializePretty(wrapperList);
            upsert needAnalysis; 
            
            //initialize the rule object after the save
            needAnalysis = new SWAT_Need_Analysis__c();
            expressionList = new list<ExpressionWrapper>();
                ExpressionWrapper w = new ExpressionWrapper(0);
                w.disabled = true;
                expressionList.add(w);
        }
        catch(Exception e)
        {
            system.debug('Error from SWATAdmin  saveProductRecommendation method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
      
        }
        
        //return null;
    }
    */
    
    public void saveRuleGroup() 
    {
        activeTab = 'rulegroup';
        try
        {
            upsert ruleGroup;
            linkAction = 'managerules';  
            ruleGroup = new SWATRuleGroup__c();
        }
        catch(Exception e)
        {
              system.debug('Error from SWATAdmin  saveRuleGroup method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
       
        }
        //return null;
    }
    
    public void saveRuleMapping()
    {
        activeTab = 'maprule';
        IF(ruleMapping.EffectiveDate__c > ruleMapping.ExpirationDate__c){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Expiration Date must be greater than Effective Date'));
        }
        IF(ruleMapping.EffectiveDate__c < System.today()){
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Effective Date cannot be a Past Date'));
        }
        try
        {
                upsert ruleMapping;     
                linkAction = 'managerules';
                ruleMapping.Id = null;
                ruleMapping.SWATRule__c = null;
                ruleMapping.EffectiveDate__c = null;
                ruleMapping.ExpirationDate__c = null;
                ruleMapping.Priority__c = null;
                ruleMapping.Message__c = null;
                ruleMapping.Severity__c = null;                 
                        
        }
        catch(Exception e)
        {
                 system.debug('Error from SWATAdmin  saveRuleMapping$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
       
        }
    }
    
    public void saveRuleEngineConfiguration()
    {
        linkAction = 'configure';
        try
        {
                upsert ruleEngineConfiguration;
                ruleEngineConfiguration.id = null;
                ruleEngineConfiguration.SWATRuleGroup__c = null;
                ruleEngineConfiguration.Priority__c = null;
                ruleEngineConfiguration.Active__c = null;
        }
        catch(Exception e)
        {
                 system.debug('Error from SWATAdmin  saveRuleEngineConfiguration$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        }
    }
    public string test {get; set;}
    public void editOrDeleteRecord() 
    {
        system.debug('***selectedRecordToDelete'+selectedRecordToDelete);
        system.debug('***selectedRecordToEdit'+selectedRecordToEdit);
        try
        {
                if(objectType <> null && objectType == 'SWATRule__c')
                {
                        activeTab = 'rule';
                        if(selectedRecordToEdit <> null )
                        {
                        ruleDetails = [Select Id, Name, RuleDescription__c, ActiveFlag__c, Rule_Expression__c from SWATRule__c where Id =: selectedRecordToEdit];
                        expressionList = new list<ExpressionWrapper>();
                        
                        if(ruleDetails.Rule_Expression__c <> null)
                        {
                                    list<Object> jsonValueList = (list<Object>)JSON.deserializeUntyped(ruleDetails.Rule_Expression__c);
                                    
                                    system.debug('serialize value$'+jsonValueList);
                                    integer index = 0;
                                    for(Object val: jsonValueList)
                                    {
                                        system.debug('single value$'+val);
                                        JSONWrapper info = (JSONWrapper)JSON.deserializeStrict(JSON.serializePretty((Map<String, Object>)val),JSONWrapper.Class);
                                        ExpressionWrapper wr = new ExpressionWrapper(index);
                                        wr.objectName = info.objectName;
                                        wr.fieldName = info.fieldName;
                                        wr.operator = info.operator;
                                        wr.fieldValue = info.fieldValue;
                                        wr.selectedObject = Schema.getGlobalDescribe().get(info.objectName).newSObject();
                                        System.debug('infoobjectName$'+info.objectName);
                                        System.debug('infofieldName$'+info.fieldName);
                                        System.debug('infofieldValue$'+info.fieldValue);
                                        System.debug('wr$'+wr);
                                        System.debug('index$'+index);
                                         Schema.SObjectType t = Schema.getGlobalDescribe().get(info.objectName); 
                                         Schema.DescribeSObjectResult r = t.getDescribe();
                                         Schema.DescribeFieldResult f = r.fields.getMap().get(info.fieldName).getDescribe(); 
                                          system.debug('field$$$$$'+f.getType());  
                                         string fieldType=  String.valueof(f.getType());
                                        if(fieldType == 'currency' || fieldType == 'double' || fieldType == 'percent' || fieldType == 'decimal' )
                                        {
                                        wr.selectedObject.put(info.fieldName,decimal.valueOf(info.fieldValue));
                                            //updateObj.put(field, decimal.valueOf(value)); 
                                        }
                                        else if(fieldType =='integer')
                                        {
                                          wr.selectedObject.put(info.fieldName,Integer.valueOf(info.fieldValue));
                                        }
                                        else if(fieldType == 'boolean')
                                        {
                                        wr.selectedObject.put(info.fieldName,Boolean.valueOf(info.fieldValue));
                                            //updateObj.put(field, Boolean.valueOf(value)); 
                                        }                   
                                        else if(fieldType == 'date')
                                        {
                                        wr.selectedObject.put(info.fieldName,date.valueOf(info.fieldValue));
                                           // updateObj.put(field, date.valueOf(value)); 
                                        } 
                                        else if(fieldType == 'DateTime')
                                        {
                                        wr.selectedObject.put(info.fieldName,DateTime.valueOf(info.fieldValue));
                                           // updateObj.put(field, date.valueOf(value)); 
                                        } 
                                        else if(fieldType == 'ID')
                                        {
                                        wr.selectedObject.put(info.fieldName,ID.valueOf(info.fieldValue));
                                           // updateObj.put(field, date.valueOf(value)); 
                                        }                                         
                                        else
                                        {
                                        wr.selectedObject.put(info.fieldName,info.fieldValue);
                                           // updateObj.put(field,value);
                                        }
                                                           // wr.selectedObject.put(info.fieldName,info.fieldValue);
                                        
                                        expressionList.add(wr);
                                        index++;
                                    }
                                    system.debug('expression list'+expressionList);
                        }
                    }
                    if(selectedRecordToDelete <> null )
                    {
                        LIST<SWATRuleMapping__c> noOfRuleCount = new LIST<SWATRuleMapping__c > (); 
                        noOfRuleCount =[select id from SWATRuleMapping__c where SWATRule__c=:selectedRecordToDelete];                     
                        if(noOfRuleCount.size() ==0)
                        {
                            delete [Select Id from SWATRule__c where Id =: selectedRecordToDelete];
                        }
                        else
                        {
                         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Cannot Delete Rule,this is mapped to MapRules'));
                        }
                        
                    }
                }
                /*
                else if(objectType <> null && objectType == 'SWAT_Need_Analysis__c')
                {
                        activeTab = 'createreco';
                       expressionList = new list<ExpressionWrapper>();
                        if(selectedRecordToEdit <> null )
                        {
                        needAnalysis = [select Id, Name, Rule_Description__c, Rule_Expression__c, Product_Name__c, Active__c from SWAT_Need_Analysis__c where Id =: selectedRecordToEdit];
                        expressionList = new list<ExpressionWrapper>();
                        
                        if(needAnalysis.Rule_Expression__c <> null)
                        {
                                    list<Object> jsonValueList = (list<Object>)JSON.deserializeUntyped(needAnalysis.Rule_Expression__c);
                                    
                                    system.debug('serialize value'+jsonValueList);
                                    integer index = 0;
                                    for(Object val: jsonValueList){
                                        system.debug('single value'+val);
                                        JSONWrapper info = (JSONWrapper)JSON.deserializeStrict(JSON.serializePretty((Map<String, Object>)val),JSONWrapper.Class);
                                        ExpressionWrapper wr = new ExpressionWrapper(index);
                                        wr.objectName = info.objectName;
                                        wr.fieldName = info.fieldName;
                                        wr.operator = info.operator;
                                        wr.fieldValue = info.fieldValue;
                                        wr.selectedObject = Schema.getGlobalDescribe().get(info.objectName).newSObject();
                                        wr.selectedObject.put(info.fieldName, info.fieldValue);
                                        expressionList.add(wr);
                                        index++;
                                    }
                                    system.debug('expression list'+expressionList);                                     
                        }                       
                    }
                    if(selectedRecordToDelete <> null )
                    {
                        delete [Select Id from SWAT_Need_Analysis__c where Id =: selectedRecordToDelete];
                    }
                }
                */
                else if(objectType <> null && objectType == 'SWATRuleGroup__c')
                {
                        activeTab = 'rulegroup';
                        if(selectedRecordToEdit <> null )
                        {
                                ruleGroup = [Select Id, Name, Active__c from SWATRuleGroup__c where Id =: selectedRecordToEdit];
                        }
                        if(selectedRecordToDelete <> null )
                        {
                        
                            LIST<SWATRuleMapping__c> noOfRuleCount = new LIST<SWATRuleMapping__c>(); 
                            noOfRuleCount =[select id from SWATRuleMapping__c where RuleGroupID__c=:selectedRecordToDelete];                     
                            if(noOfRuleCount.size() == 0 )
                            {
                                delete [Select Id from SWATRuleGroup__c where Id =: selectedRecordToDelete];
                            }
                            else
                            {
                              ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Cannot Delete Rule Group,this is mapped to MapRules'));
                            }
                        }
                  }
                else if(objectType <> null && objectType == 'SWATRuleMapping__c')
                {
                        activeTab = 'maprule';
                        if(selectedRecordToEdit <> null )
                        {
                                ruleMapping = [Select Id, Name, SWATRule__c,EffectiveDate__c,ExpirationDate__c, Priority__c, Message__c, Severity__c, RuleGroupID__c from SWATRuleMapping__c where Id =: selectedRecordToEdit];
                        }
                        if(selectedRecordToDelete <> null )
                        {
                            delete [Select Id from SWATRuleMapping__c where Id =: selectedRecordToDelete];
                        }
                }
                else if(objectType <> null && objectType == 'SWATRule_Engine_Configuration__c')
                {
                        //activeTab = 'maprule';
                        if(selectedRecordToEdit <> null )
                        {
                                ruleEngineConfiguration = [Select Id, Name, SWATRuleGroup__c, ObjectRecordId__c, Priority__c, Active__c, ObjectRecordName__c  from SWATRule_Engine_Configuration__c where Id =: selectedRecordToEdit];
                        }
                        if(selectedRecordToDelete <> null )
                        {
                         delete [Select Id from SWATRule_Engine_Configuration__c where Id =: selectedRecordToDelete];
                        }
                }
            
        }
        catch(Exception e)
        { 
            //system.debug('Exception '+e.getMessage());
             system.debug('Error from SWATAdmin  editOrDeleteRecord$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        
        }
    }
    
    
    public list<SelectOption> getRuleConfigurationTypes()
    {
        
        list<SelectOption> options = new list<SelectOption>();
        options.add(new selectoption('', '--Select--'));
        
        list<SWAT_BRE_Configuration__c> ruleConfigList = [Select Id, Name, Value__c,API_Name__c  from SWAT_BRE_Configuration__c where Group__c = 'Configuration' and Sub_Group__c = 'Type'];
           
        if(ruleConfigList.size() > 0)
        {    
            for(SWAT_BRE_Configuration__c rec: ruleConfigList)
            {                
                options.add(new selectoption(rec.API_Name__c,rec.Value__c));
            }
        }
        return options;   
    }
    
    
    
    public List<SWATRule__c> getRules() 
    {
        SWATRule__c[] rulesList = new list<SWATRule__c>();        
        
        //Set the page size - pagination start
        pageSize = 10;   
        adjacent = 7;  
            
        Integer totalRecords = [select count() from SWATRule__c ];        
        
        if (math.mod(totalRecords, pageSize  ) > 0) 
        {
            totalPages = totalRecords / pageSize  + 1;
        }
        else 
        {
            totalPages = (totalRecords / pageSize );
        }
                
        offsetPosition = (pageNumber - 1) * pageSize ;
        
        lastPage = (Integer)math.ceil((Double)totalRecords / (Double)pageSize );
        
        startPage = ( ( pageNumber - adjacent) > 0 ) ? pageNumber - adjacent : 1;
        endPage   = ( ( pageNumber + adjacent ) < lastPage ) ? pageNumber  + adjacent  : lastPage;
        
        //pagination end
        
        try 
        {
            system.debug('select Id, Name, RuleDescription__c, ActiveFlag__c from SWATRule__c order by Name limit' + pageSize +'  OFFSET ' +offsetPosition);
            rulesList = [select Id, Name, RuleDescription__c, ActiveFlag__c from SWATRule__c order by Name limit: pageSize OFFSET: offsetPosition];             
                     
        }
        catch (QueryException e) 
        {
            ApexPages.addMessages(e);
             system.debug('Error from SWATAdmin  getRules$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        
        }
        return rulesList;
    }
    /*
    //Need Analysis
    public List<SWAT_Need_Analysis__c> getProdRec() 
    {
        SWAT_Need_Analysis__c[] prodRecoList = new list<SWAT_Need_Analysis__c>();        
        
        //Set the page size - pagination start
        pageSize = 10;   
        adjacent = 7;  
            
        Integer totalRecords = [select count() from SWAT_Need_Analysis__c ];        
        
        if (math.mod(totalRecords, pageSize  ) > 0)
        {
            totalPages = totalRecords / pageSize  + 1;
        } 
        else
        {
            totalPages = (totalRecords / pageSize );
        }
                
        offsetPosition = (pageNumber - 1) * pageSize ;
        
        lastPage = (Integer)math.ceil((Double)totalRecords / (Double)pageSize );
        
        startPage = ( ( pageNumber - adjacent) > 0 ) ? pageNumber - adjacent : 1;
        endPage   = ( ( pageNumber + adjacent ) < lastPage ) ? pageNumber  + adjacent  : lastPage;
        
        //pagination end
        
        try 
        {
            //system.debug('select Id, Name, RuleDescription__c, ActiveFlag__c from SWATRule__c order by Name limit' + pageSize +'  OFFSET ' +offsetPosition);
            prodRecoList = [select Id, Name, Rule_Description__c, Active__c from SWAT_Need_Analysis__c order by Name limit: pageSize OFFSET: offsetPosition];             
                     
        } 
        catch (QueryException e) 
        {
            ApexPages.addMessages(e);
             system.debug('Error from SWATAdmin  getProdRec$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
        
        }
        return prodRecoList;
    }
    */
    
    public list<integer> getCounter()
    {
        list<integer> counterList = new list<integer>();
        for(integer i = startPage; i <= endPage; i++ )
        {
            counterList.add(i);
        }
        return counterList;
    }
    
    public void assignValuesIntoPaginationProperties()
    {
        
        
    }
    
    /*public List<RuleWrapper> getRules() {
        if(rulesList == null) {
            rulesList = new List<RuleWrapper>();
            for(SWATRule__c rl: [select Id, Name from SWATRule__c limit 10]) {                
                rulesList.add(new RuleWrapper(rl));
            }
        }
        return rulesList;
    }*/


    /*public PageReference processSelected() {
        List<SWATRule__c> selectedRules = new List<SWATRule__c>();
        for(RuleWrapper w: getRules()) {
            if(w.selected == true) {
                selectedRules.add(w.rule);
            }
        }
        
        for(SWATRule__c rl: selectedRules) {
            system.debug(rl);
        }
        rulesList = null; // we need this line if we performed a write operation  because getContacts gets a fresh list now
        return null;
    }*/
    
    public list<SWATRuleGroup__c> getRuleGroups()
    {
        //Set the page size - pagination start
        pageSize = 10;   
        adjacent = 7;  
            
        Integer totalRecords = [select count() from SWATRuleGroup__c ];        
        
        if (math.mod(totalRecords, pageSize  ) > 0) {
            totalPages = totalRecords / pageSize  + 1;
        } else {
            totalPages = (totalRecords / pageSize );
        }
                
        offsetPosition = (pageNumber - 1) * pageSize ;
        
        lastPage = (Integer)math.ceil((Double)totalRecords / (Double)pageSize );
        
        startPage = ( ( pageNumber - adjacent) > 0 ) ? pageNumber - adjacent : 1;
        endPage   = ( ( pageNumber + adjacent ) < lastPage ) ? pageNumber  + adjacent  : lastPage;
        
        //pagination end
        try
        {
                return [Select id, Name, Active__c from SWATRuleGroup__c order by Name limit: pageSize OFFSET: offsetPosition];
        }
        catch(Exception e)
        {
            system.debug('Error from SWATAdmin  getRuleGroups method$:'+e +' LineNumber '+e.getLineNumber()+' StackTraceString '+e.getStackTraceString()+' Message '+e.getMessage());    
            return null;
        }
    }
    
    public list<SWATRuleMapping__c> getRuleAndGroupMapping()
    {
        //system.debug('rule group id'+ruleMapping.RuleGroupID__c);
        return [Select Id, Name, SWATRule__c, EffectiveDate__c, ExpirationDate__c, Priority__c, Message__c, Severity__c, RuleGroupID__c  from SWATRuleMapping__c where RuleGroupID__c =: ruleMapping.RuleGroupID__c];
    }
    
    public list<SWATRule_Engine_Configuration__c> getRuleEngineConfigurationList()
    {       
        system.debug('rule group id'+ruleEngineConfiguration.SWATRuleGroup__c);
        system.debug('record id'+ruleEngineConfiguration.ObjectRecordId__c);
        return [Select Id, Name, SWATRuleGroup__c, ObjectRecordId__c, Priority__c, Active__c, ObjectRecordName__c  from SWATRule_Engine_Configuration__c where ObjectRecordId__c =: ruleEngineConfiguration.ObjectRecordId__c];
    }
    
    public list<SelectOption> getGroups()
    {
        list<SelectOption> options = new list<SelectOption>();
        options.add(new selectoption('', '--Select--')); 
        list<SWATRuleGroup__c> ruleGroupList = [Select id, Name from SWATRuleGroup__c where Active__c = true];
        for(SWATRuleGroup__c rec: ruleGroupList )
        {                
            options.add(new selectoption(rec.Id,rec.Name));        
        }
        return options;
    }
    

    public class RuleWrapper 
    {
        public SWATRule__c rule {get; set;}
        public Boolean selected {get; set;}
        public SWATRuleMapping__c ruleConfiguration {get; set;}

        public RuleWrapper(SWATRule__c c) 
        {
            rule = c;
            ruleConfiguration = new SWATRuleMapping__c();
            selected = false;
        }
    }
    
    

        
    public boolean isHomeRendered = false;
    public boolean getIsHomeRendered()
    {
        if(linkAction == 'home')
        {
            isHomeRendered = true;
        }
        else
        {
            isHomeRendered = false;
        }
        return isHomeRendered;
    }
    public void setIsHomeRendered(boolean val)
    {
        isHomeRendered = val;
    }
    
    
    public boolean isCreateRuleGroupRendered = false;
    public boolean getIsCreateRuleGroupRendered()
    {
        if(linkAction == 'creategroup')
        {
            isCreateRuleGroupRendered = true;
        }
        else
        {
            isCreateRuleGroupRendered = false;
        }
        return isCreateRuleGroupRendered;
    }
    public void setIsCreateRuleGroupRendered(boolean val)
    {
        isCreateRuleGroupRendered = val;
    }
    
    public boolean isCreateRuleRendered = false;
    public boolean getIsCreateRuleRendered()
    {
        if(linkAction == 'create')
        {
            isCreateRuleRendered = true;
        }
        else
        {
            isCreateRuleRendered = false;
        }
        return isCreateRuleRendered;
    }
    public void setIsCreateRuleRendered(boolean val)
    {
        isCreateRuleRendered = val;
    }
    
    public boolean isConfigRuleRendered = false;
    public boolean getIsConfigRuleRendered()
    {
        if(linkAction == 'configure')
        {
            isConfigRuleRendered = true;
        }
        else
        {
            isConfigRuleRendered = false;
        }
        return isConfigRuleRendered;
    }
    public void setIsConfigRuleRendered(boolean val)
    {
        isConfigRuleRendered = val;
    }
    
    public class RuleEngineConfiguration 
    {
        public integer index {get; set;}
        public SWATRule_Engine_Configuration__c conf{get; set;}
        
        public RuleEngineConfiguration(integer indx)
        {
            index = indx;
            conf = new SWATRule_Engine_Configuration__c();
        }
        
        public list<SelectOption> getGroups()
        {
            list<SelectOption> options = new list<SelectOption>();
            options.add(new selectoption('', '--Select--')); 
            list<SWATRuleGroup__c> ruleGroupList = [Select id, Name from SWATRuleGroup__c where Id IN(Select RuleGroupID__c from SWATRuleMapping__c)];
            for(SWATRuleGroup__c rec: ruleGroupList )
            {                
                options.add(new selectoption(rec.Id,rec.Name));        
            }
            return options;
        }
    }
    
    
    
    /*public class RuleAndGroupMappingWrapper {
        public string groupName {get; set;}
        public list<MappingElementsWrapper> mappingElements {get; set;}           
        
        public list<SelectOption> getGroups(){
                list<SelectOption> options = new list<SelectOption>();
                options.add(new selectoption('', '--Select--')); 
                list<SWATRuleGroup__c> ruleGroupList = [Select id, Name from SWATRuleGroup__c where Active__c = true];
                for(SWATRuleGroup__c rec: ruleGroupList ){                
                    options.add(new selectoption(rec.Id,rec.Name));        
                }
                return options;
            }
    } */  
    
    public class JSONWrapper 
    {
        public integer orderNo {get; set;}
        public string objectName {get; set;}
        public string fieldName {get; set;}
        public string operator {get; set;}
        public string fieldValue {get; set;}
        public string logicalOperator {get; set;}
    }
    
    public class ExpressionWrapper 
    {
        public string objectName {get; set;}
        public string fieldName {get; set;}
        public string operator {get; set;}
        public string fieldValue {get; set;}
        public string logicalOperator {get; set;}
        public integer index {get; set;} 
        public boolean disabled {get; set;}
        public sObject selectedObject {get; set;}
        
        public map<string, Schema.SObjectType> objectsMap {get; set;}
        public map<string, Schema.SObjectField> fieldsMap = new map<string, Schema.SObjectField>(); 
        
        public ExpressionWrapper(integer indx)
        {
            index = indx;
            objectsMap = new map<string, Schema.SObjectType>();
            objectsMap = Schema.getGlobalDescribe();
            disabled = false;
            logicalOperator = 'AND';
        }
        public ExpressionWrapper()
        {
             objectsMap = new map<string, Schema.SObjectType>();
             objectsMap = Schema.getGlobalDescribe();
             disabled = false;
        }
        //Need Analysis
        public list<SelectOption> getAnalysisObjects()
        {
            list<SelectOption> options = new list<SelectOption>();
            options.add(new selectoption('', '--Select--'));               
           
            list<SWAT_BRE_Configuration__c> ruleConfigList = [Select Id, Name, Value__c,API_Name__c from SWAT_BRE_Configuration__c where Group__c = 'Configuration' and Sub_Group__c = 'Object Name'];
                       
           
            if(ruleConfigList.size() > 0)
            {
                for(SWAT_BRE_Configuration__c rec:ruleConfigList)
                {
                    options.add(new selectoption(rec.API_Name__c,rec.Value__c));
                }
            }
            return options;   
        }
        
        public list<SelectOption> getObjects()
        {
            list<SelectOption> options = new list<SelectOption>();
            options.add(new selectoption('', '--Select--'));               
           
            list<SWAT_BRE_Configuration__c> ruleConfigList = [Select Id, Name, Value__c,API_Name__c from SWAT_BRE_Configuration__c where Group__c = 'Rule Expression' and Sub_Group__c = 'Object Name'];
                        
            /*if(objectsMap.size() > 0){ 
                for(string obj:objectsMap.keySet()){
                    Schema.SObjectType sobjType = objectsMap.get(obj); 
                    Schema.DescribeSObjectResult describeResult = sobjType.getDescribe();
                    options.add(new selectoption(describeResult.getName(),describeResult.getLabel()));
                }
            }*/
            if(ruleConfigList.size() > 0){
                for(SWAT_BRE_Configuration__c rec:ruleConfigList){
                    options.add(new selectoption(rec.API_Name__c,rec.Value__c));
                }
            }
            return options;   
        }
        
        public list<SelectOption> getFields()
        {
            system.debug('object name'+objectName ); 
            
            list<SelectOption> options = new list<SelectOption>();
            options.add(new selectoption('', '--Select--')); 
            if(objectName <> '' && objectName <> null)
            {
                selectedObject = Schema.getGlobalDescribe().get(objectName).newSObject();
                fieldsMap = objectsMap.get(objectName).getDescribe().fields.getMap(); 
                if(fieldsMap.size() > 0)
                {    
                    for(Schema.SObjectField field:fieldsMap.Values())
                    {
                        Schema.DescribeFieldResult fldInfo = field.getDescribe(); 
                        system.debug('field infor'+fldInfo );
                        options.add(new selectoption(fldInfo.getName(),fldInfo.getLabel()));
                    }
                }
            }
            return options;   
        } 
        
        public list<SelectOption> getOperators()
        {
            list<SelectOption> options = new list<SelectOption>();
            options.add(new selectoption('', '--Select--')); 
            map<string, string> operatorsMap = new map<string, string>{'='=>'equals','<>'=>'not equals to','LIKE'=>'contains','NOT LIKE'=>'does not contain','<'=>'less than','>'=>'greater than','<='=>'less or equal','>='=>'greater or equal'};
            for(string key: operatorsMap.keySet())
            {                
                options.add(new selectoption(key,operatorsMap.get(key)));        
            }
            return options;
        }
        
        public list<SelectOption> getLogicalOperators()
        {
            list<SelectOption> options = new list<SelectOption>();            
            map<string, string> logicalOperatorsMap = new map<string, string>{'AND'=>'AND','OR'=>'OR'};
            for(string key: logicalOperatorsMap.keySet())
            {                
                options.add(new selectoption(key,logicalOperatorsMap.get(key)));        
            }
            return options;
        }
              
    }
    
    
    
    public void resetForm(){
        ruleDetails.Name = NULL;
        ruleDetails.ActiveFlag__c = false;
        ruleDetails.RuleDescription__c = NULL;
        init();
    }
    
     public void resetRuleGrp(){
        ruleGroup.Name = NULL;
        ruleGroup.Active__c = false;
        
    }
    
    public void resetMapRule(){
        ruleMapping.SWATRule__c = NULL;
        ruleMapping.EffectiveDate__c = NULL;
        ruleMapping.ExpirationDate__c = NULL;
        ruleMapping.Priority__c = NULL;
        ruleMapping.Message__c = NULL;
        ruleMapping.Severity__c  =   NULL;     
    }
    
    
}