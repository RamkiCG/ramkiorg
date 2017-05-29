global class EmailDemoReceive implements Messaging.InboundEmailHandler {
  global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.Inboundenvelope envelope) {
     Account account;
     Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();

          try {
        //  The email and envelope arguments have several public attributes you can access directly. First, let’s grab the email’s subject and create a new account record if it doesn’t already exist.
           // Look for account whose name is the subject and create it if necessary
                 if ([select count() from Account where Name =:email.subject] == 0) {
                       account = new Account();
                       account.Name = email.subject;
                       insert account;
                 } else {
                       account = [select Id from Account where Name =:email.subject];
                 }

   //    You can even access text and binary attachments:

       // Save attachments, if any
       for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
             Attachment attachment = new Attachment(); 
             attachment.Name = tAttachment.fileName;
             attachment.Body = Blob.valueOf(tAttachment.body);
             attachment.ParentId = account.Id;
             insert attachment;
       }
       for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
             Attachment attachment = new Attachment();
           attachment.Name = bAttachment.fileName;
            attachment.Body = bAttachment.body;
             attachment.ParentId = account.Id;
             insert attachment;
       }

      // And of course, you can access the body of an email as well. In this case we’re assuming a plain email (not an HTML one) and use the plainTextBody field:

       // Turn email body into note
       Note note = new Note();
       note.Title = email.fromName + ' (' + DateTime.now() + ')';
       note.Body = email.plainTextBody;
       note.ParentId = account.Id;
       insert note;

      // Here we explicitly indicate success or failure by setting the success field of our InboundEmailResult object.

      result.success = true;
     } catch (Exception e) {
           result.success = false;
           result.message = 'Oops, I failed.';
    }

    return result;
  }
}