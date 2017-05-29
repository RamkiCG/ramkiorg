public with sharing class QuickBooksLoginController {
    public QuickBooksConnector qbConnector { get; set; }
    
    public Boolean isQuickBooksAuthorized { get; set; }
    
    public string CustomerName {get;set;}
    
    public QuickBooksLoginController() {
        qbConnector = new QuickBooksConnector();
    }
    
    public void customerNameValue()
    {
    qbConnector.CustomerName=CustomerName;
    }
    
    public void completeAuthorization() {
        String token = ApexPages.currentPage().getParameters().get('oauth_token');
        String verifier = ApexPages.currentPage().getParameters().get('oauth_verifier');
        String realmId = ApexPages.currentPage().getParameters().get('realmId');
        
        if(token != NULL) {
            isQuickBooksAuthorized = qbConnector.completeAuthorization(token, verifier, realmId);
        }
    }
}