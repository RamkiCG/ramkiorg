global class LeadBatch implements Database.Batchable<SObject>, Database.Stateful {
    global string query;
    global LeadBatch(){
        query = 'Select id, owner.name, ownerid, isconverted, lead_name__c, leadsource from lead where (owner.name = \'Alex Tarin\' or owner.name = \'Han Butler\' or owner.name = \'Lee Street\' or owner.name = \'Mitchell Howell\') and isconverted = false';
    }
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(query);   
    }
    global void execute(Database.BatchableContext BC, List<SObject> Scope){
        List<Lead> leadList = scope;
        User chris = [Select id, name From User Where name = 'Christopher Reimche'];
        for(Lead l: leadList){
            l.ownerId = chris.id; 
        }
        update leadList;
    }
    global void finish(Database.BatchableContext BC){
    }
    
}