public with sharing class ImageController 
{
 public String imageURL{get;set;}
   
  public ImageController()
  {
    imageURL='/servlet/servlet.FileDownload?file=';
    List< Attachment > documentList=[select name from attachment where 
                                    Name='SamplePic'];
   
    if(documentList.size()>0)
    {
      imageURL=imageURL+documentList[0].id;
    }
  }
}