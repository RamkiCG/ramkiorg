trigger testprevent on SampleTest__c (before insert,before update)
{
Map<string,boolean> SampleTestMap=new Map<string,boolean>(); //{get;set;}
Map<String,Id> SampleTestMapUpdate=new Map<String,Id>();
List<SampleTest__c> sampleList=new List<SampleTest__c>();//[Select id,ramki__Products__c,ramki__IsActive__c from SampleTest__C];  
//List<SampleTest__c> sampleOldList=[Select id,ramki__Products__c,ramki__IsActive__c from SampleTest__C];  

    for(List<SampleTest__c> sampleList1 : [Select id,ramki__Products__c,ramki__IsActive__c from SampleTest__C])
    {
    sampleList=sampleList1;
    }
    
    for(SampleTest__c f :sampleList)
    {
      if(f.ramki__IsActive__c != false)
      {
          SampleTestMap.put(f.ramki__Products__c, f.ramki__IsActive__c);   
          SampleTestMapUpdate.put(f.ramki__Products__c,f.id);
      }
   }

   System.debug('=========================sampleList======================='+sampleList);
   
   System.debug('==========================SampleTestMap======================'+SampleTestMap);
    for (SampleTest__c a : Trigger.new) 
    {
   
        if(SampleTestMap.containsKey(a.ramki__Products__c))
        {
            // Iterate over each sObject
             System.debug('===============================a.ramki__Products__c================='+a.ramki__Products__c);
             boolean value = SampleTestMap.get(a.ramki__Products__c);
             System.debug('===============================value ================='+value );
           
            if(value!=a.ramki__IsActive__c)
            {
              System.debug('===============================a.ramki__IsActive__c================='+a.ramki__IsActive__c);
            }
            else
            {
            id tempid=SampleTestMapUpdate.get(a.ramki__Products__c);
            if(tempid!=a.id)
            {
            a.adderror('already this product is activated');
            }
            }
         }
     
    
    
    }
    
   
   
   
    

}