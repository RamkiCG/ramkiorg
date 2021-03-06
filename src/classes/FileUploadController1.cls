public with sharing class FileUploadController1 {
 
  public Document document {
    get {
      if (document == null)
        document = new Document();
         ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Info,''+document.ContentType));
      return document;
    }
    set;
  }
 
  public PageReference upload() {
 
    document.AuthorId = UserInfo.getUserId();
    document.FolderId = UserInfo.getUserId(); // put it in running user's folder
 
    try {
      insert document;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading file'));
      return null;
    } finally {
      document.body = null; // clears the viewstate
      document = new Document();
    }
 
    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'File uploaded successfully'));
    return null;
  }
 
}