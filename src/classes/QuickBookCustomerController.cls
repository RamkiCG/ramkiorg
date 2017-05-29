public class QuickBookCustomerController
{
    

   

 public QuickBooksConnector qbConnector { get; set; }
 
 public QuickBookCustomer qbCustomer {get;set;}
    
 public Boolean isQuickBooksAuthorized { get; set; }
 
 public QuickBookCustomerController() 
  {
        qbConnector = new QuickBooksConnector();
        qbCustomer=new QuickBookCustomer();
  }
 
 public void completeAuthorization() 
  {
        String token = ApexPages.currentPage().getParameters().get('oauth_token');
        String verifier = ApexPages.currentPage().getParameters().get('oauth_verifier');
        String realmId = ApexPages.currentPage().getParameters().get('realmId');
        
        if(token != NULL) 
        {
            isQuickBooksAuthorized = qbConnector.completeAuthorization(token, verifier, realmId);
        }
 
    }
    
    public void CreateCustomer()
    {
         
        qbConnector.CreateCustomer(qbCustomer);
       
    }
}