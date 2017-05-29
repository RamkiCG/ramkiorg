trigger SendMailwithAttachment on Case (after insert,after update) 
{
  map<Id,Case> MapCase = new map<Id,Case>();

 List<EmailMessage> EmailMessageList=new List<EmailMessage>();
 List<Messaging.SingleEmailMessage> sendMailList=new List<Messaging.SingleEmailMessage>();
 
   for(Case e:trigger.New)
    {
        if(e.Origin=='Email')
        {
            MapCase.put(e.id,e);      
        }
    }
    System.debug('MapCase$'+MapCase);
    
     if(MapCase != null && MapCase.Size() >0)
        {
         EmailMessageList=[Select id,ParentId,ActivityId,FromAddress,Subject,FromName,BccAddress,CcAddress,HasAttachment,Headers,HtmlBody,Incoming from EmailMessage where ParentId in:MapCase.keyset()];
        }
   
     if(EmailMessageList.size()>0)
     {
        for(EmailMessage emailMsg:EmailMessageList)
        {
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             mail.setToAddresses(new String[] {'softramki@gmail.com'}); 
             mail.setReplyTo(emailMsg.FromAddress);
             mail.setSenderDisplayName(emailMsg.FromName);
             mail.setSubject(emailMsg.Subject);
             // mail.setBccSender(false);
            // mail.setUseSignature(false);
             mail.setHtmlBody(emailMsg.HtmlBody);
             //mail.setWhatId(MapEmailMessage.get(c.Id).Id);
             System.debug('CaseID$'+emailMsg.ParentId);
             System.debug('EmailID$'+emailMsg.Id);
             System.debug('HasAttachment$'+emailMsg.HasAttachment);
             if(emailMsg.HasAttachment==true)
             {
                     List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                     string EMId=emailMsg.Id;
                     List<Attachment> AttachmentList=[Select Name, Body,OwnerId,BodyLength, ParentId from Attachment where ParentId=:EMId];
                     System.debug('AttachmentList$'+AttachmentList);
                     for (Attachment a : AttachmentList)
                     {
                      Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
                      efa.setFileName(a.Name);
                      efa.setBody(a.Body);
                      fileAttachments.add(efa);
                    }
                    mail.setFileAttachments(fileAttachments);
            }
           sendMailList.add(mail);
       }
     }

     if(sendMailList.size()>0)
        {     
          Messaging.sendEmail(sendMailList);        
        }
 
}