public with sharing class testmerger 
{


    
    public static void TestMerge()
    {
      // Create master account
Account master = new Account(Name='Account1');
insert master;

// Create duplicate accounts
Account[] duplicates = new Account[]{
    // Duplicate account 
    new Account(Name='Account1, Inc.'),
    // Second duplicate account
    new Account(Name='Account 1')
};
insert duplicates;

// Create child contact and associate it with first account
Contact c = new Contact(firstname='Joe',lastname='Smith', accountId=duplicates[0].Id);
insert c;


// Merge accounts into master
Database.MergeResult[] results = Database.merge(master, duplicates, false);

for(Database.MergeResult res : results) {
    if (res.isSuccess()) {
        // Get the master ID from the result and validate it
        System.debug('Master record ID: ' + res.getId());
        System.assertEquals(master.Id, res.getId());                
        
        // Get the IDs of the merged records and display them
        List<Id> mergedIds = res.getMergedRecordIds();
        System.debug('IDs of merged records: ' + mergedIds);                
        
        // Get the ID of the reparented record and 
        // validate that this the contact ID.
        System.debug('Reparented record ID: ' + res.getUpdatedRelatedIds());
        System.assertEquals(c.Id, res.getUpdatedRelatedIds()[0]);               
    }
    else {
        for(Database.Error err : res.getErrors()) {
            // Write each error to the debug output
            System.debug(err.getMessage());
        }
    }
}     System.debug('test merge');
    }
    

}