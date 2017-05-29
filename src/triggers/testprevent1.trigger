trigger testprevent1 on SampleTest__c(before insert,before update)
{
    //ramki__Products__c
    //ramki__IsActive__c
    //
    
    System.debug('System.Trigger.new#'+System.Trigger.new);
       System.debug('System.Trigger.old#'+System.Trigger.old);
          System.debug('System.Trigger.newmap#'+System.Trigger.newmap);
             System.debug('System.Trigger.oldmap#'+System.Trigger.oldmap);
    Map<String, SampleTest__c> sampleMap = new Map<String, SampleTest__c>();
    for (SampleTest__c sample : System.Trigger.new)
     {
        
       
        if ((sample.ramki__IsActive__c == true) &&
           (System.Trigger.isInsert ||
            (System.Trigger.IsUpdate )))
            {
        
          
            if (sampleMap.containsKey(sample.ramki__Products__c))
            {
               if(sample.ramki__IsActive__c != sampleMap.get(sample.ramki__Products__c).ramki__IsActive__c || sample.ramki__IsActive__c != System.Trigger.oldMap.get(sample.Id).ramki__IsActive__c)
               {
               sampleMap.remove(sample.ramki__Products__c);
               }
               else
               {
                sample.ramki__Products__c.addError('Another new Sample has the '
                                    + 'same product ');
               }
            } 
            else
            {
                sampleMap.put(sample.ramki__Products__c, sample);
            }
       }
    }
    
    // Using a single database query, find all the leads in  
    
    // the database that have the same email address as any  
    
    // of the leads being inserted or updated.  
    
   /* for (SampleTest__c samp : [SELECT ramki__Products__c FROM SampleTest__c WHERE ramki__Products__c IN :sampleMap.KeySet()])
    {
        SampleTest__c newsample = sampleMap.get(samp.ramki__Products__c);
        newsample.ramki__Products__c.addError('A Sample with this Product '
                               + ' already exists.');
    }*/
   }