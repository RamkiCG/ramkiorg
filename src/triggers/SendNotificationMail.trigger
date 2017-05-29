trigger SendNotificationMail on EmailMessage (after insert,after update)
{
    map<Id,EmailMessage> MapEmailMessage = new map<Id,EmailMessage>();
    Set<Id> CaseIdList=new Set<Id>();
    List<Case> newList = new List<Case>();
    List<Messaging.SingleEmailMessage> sendMailList=new List<Messaging.SingleEmailMessage>();
    for(EmailMessage e:trigger.New)
    {
        MapEmailMessage.put(e.ParentId,e);     
    }
   
    list<Case> lstC = [select Id,ramki__DescriptionTest__c from Case where id in:MapEmailMessage.keyset()];
    for(Case c:lstC)
    {       
        CaseIdList.add(c.id);      
    }
    for(Id c:CaseIdList)
    {
       if(MapEmailMessage != null && MapEmailMessage.get(c) != null )
        {
    
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setToAddresses(new String[] {'softramki@gmail.com'}); 
             mail.setReplyTo(MapEmailMessage.get(c).FromAddress);
             mail.setSenderDisplayName(MapEmailMessage.get(c).FromName);
             mail.setSubject(MapEmailMessage.get(c).Subject);
            // mail.setBccSender(false);
            // mail.setUseSignature(false);
             mail.setHtmlBody(MapEmailMessage.get(c).HtmlBody);
             //mail.setWhatId(MapEmailMessage.get(c.Id).Id);
                System.debug('CaseID$'+c);
             System.debug('EmailID$'+MapEmailMessage.get(c).Id);
             System.debug('HasAttachment$'+MapEmailMessage.get(c).HasAttachment);
             if(MapEmailMessage.get(c).HasAttachment==false)
             {
               sendMailList.add(mail);
             }
          
       }
       
        
    }
       if(sendMailList.size()>0)
        {     
        Messaging.sendEmail(sendMailList);        
        }
}