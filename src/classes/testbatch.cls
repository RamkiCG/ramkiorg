global class testbatch implements Database.batchable<SObject>
{
   

    global Database.QueryLocator start(Database.BatchableContext bc)
    {
    return null;
    }

    global void execute(Database.BatchableContext bc,LIST<SObject> listdemo)        
    {
    
    } 
    
    global void finish(Database.BatchableContext bc)
    {
    
    }
}