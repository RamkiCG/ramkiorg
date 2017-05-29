trigger SendMailTest on Attachment (After insert)
{

    List<Messaging.SingleEmailMessage> sendMailList=new List<Messaging.SingleEmailMessage>();
    Set<ID> caseId = new Set<ID>();
    map<Id,EmailMessage> MapEmailMessage = new map<Id,EmailMessage>();
    for( Attachment a : trigger.new )
    {  
        // Check the parent ID - if it's 02s, this is for an email message   
       if( a.parentid == null )     
            continue;       
        String s = string.valueof( a.parentid );     
        if( s.substring( 0, 3 ) == '02s' )
        {  
            EmailMessage e= [Select id,ParentId,ActivityId,FromAddress,Subject,FromName,BccAddress,CcAddress,HasAttachment,Headers,HtmlBody,Incoming  from EmailMessage where id = :a.parentid];   
            MapEmailMessage.put(e.ParentId,e);
            caseId.add(e.ParentId);
        }
    }
    
     for(Id c:caseId)
    {
       if(MapEmailMessage != null && MapEmailMessage.get(c) != null )
        {
    
             Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
              mail.setToAddresses(new String[] {'softramki@gmail.com'}); 
             //mail.setToAddresses(new String[] {'rachelmary@expsoltech.com'}); 
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
             if(MapEmailMessage.get(c).HasAttachment==true)
             {
                     List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
                     string EMId=MapEmailMessage.get(c).Id;
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
       
        if(sendMailList.size()>0)
        {     
        Messaging.sendEmail(sendMailList);        
        }
    }
    
}