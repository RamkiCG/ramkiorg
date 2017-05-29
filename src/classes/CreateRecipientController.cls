global class CreateRecipientController
{

public static CreateRecipientApex CreateRecipient {get;set;}
global CreateRecipientController()
{
CreateRecipient =new CreateRecipientApex();
}


public void CreateNewRecipient()
{

  try
  {
      Http httpProtocol = new Http();      
      
      HttpRequest request = new HttpRequest();
      
      request.setMethod('POST');      
       
      request.setEndPoint('https://rest.lianamailer.com:443/api/v1/createRecipient');
      
      //request.setHeader('Authorization', authorizationHeader);
     // request.setHeader('Date', timestamp);
            // request.setHeader("Authorization", realm + " " + user + ":" + sign);
             request.setHeader('Content-Type', 'application/json');
            // request.setHeader("Content-MD5", md5);
      String gCalJSON = JSON.serialize(CreateRecipient);
      request.setBody(gCalJSON);
      HttpResponse response = httpProtocol.send(request);
      response.getBody();
      ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Info, response.getBody());
  }
  catch(Exception ex)
  {
  System.debug('CreateNewRecipient Debug'+ex);
   
  }

}

}