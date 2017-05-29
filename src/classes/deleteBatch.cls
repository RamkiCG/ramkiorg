global class deleteBatch implements Database.Batchable<sObject>
{
   global final String Query;
   

   global deleteBatch(String q)
   {
             Query=q;
   }

   global Database.QueryLocator start(Database.BatchableContext BC)
   {
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC,List<sObject> scope)
   {
      //for(Sobject s : scope){s.put(Field,Value); 
     // }    //  update scope;
     delete scope;
   }

   global void finish(Database.BatchableContext BC)
   {
   Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
mail.setToAddresses(new String[] {'softramki@gmail.com'});
mail.setReplyTo('softramki@gmail.com');
mail.setSenderDisplayName('Batch Processing');
mail.setSubject('Batch Process Completed');
mail.setPlainTextBody('Batch Process has completed');

Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

   }

}