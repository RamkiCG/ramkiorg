@istest
public class CaseEmailAttachmentTest 
{

  public static void sendMail(string message)
  {
      

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'softramki@w-2vw7wgzhnwul3fr2gl2olkc9odirvl268sifkznh3v1xtpvmkv.9-ntuueam.ap1.case.salesforce.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('My Test Email2Case ');
        mail.setUseSignature(false);
        mail.setHtmlBody(message);    
            
       
      
         Messaging.EmailFileAttachment efa = new Messaging.EmailFileAttachment();
         efa.setFileName('email2case');
         efa.setBody(blob.valueof('attachment body'));
         mail.setFileAttachments(new Messaging.EmailFileAttachment[] { efa });
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    }  
   
    static testmethod void email2case() 
    {
    
     case newtest=new case();
     newtest.origin='Email';
     insert newtest;
     
     EmailMessage testemailmessage=new EmailMessage();
     testemailmessage.HtmlBody='<html><body><p>Please plan to present your status for the following projects...</p></body></html>';
     testemailmessage.FromAddress='softramki@gmail.com';
     testemailmessage.FromName='softramki@gmail.com';
     testemailmessage.Subject='testemail2case';
     testemailmessage.ToAddress='softramki@gmail.com';
     testemailmessage.ParentId=newtest.id;
     insert testemailmessage;
     
     Attachment testattach=new Attachment();
     testattach.name='test att';
     testattach.body=blob.valueof('attachment body');
     testattach.parentid =testemailmessage.id;
     insert testattach;

     
     
    }  
}