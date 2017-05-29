public with sharing class QuickBooksConnector 
{
    // OAuth Service 
    public OAuthService__c service { get; set; }
    
    //OAuth Token
    public OAuth_Token__c oaToken { get; set; }
    
    public string CustomerName {get;set;}
    
    //customer
    public  QuickBookCustomer newContact {get;set;}
    
     //display xml string
    public String outxmlstring{get;set;}
    
    private String token;
    private String tokenSecret;
    private String verifier;
    
    private String Detail;
    private String Message;
    
     
    
    private String nonce;
    private String timestamp;
    private String signature;
    private String consumerKey;
    private String consumerSecret;
    
    private String callbackUrl;
    
    private Map<String, String> parameters = new Map<String, String>();
    
    public QuickBooksConnector() 
    {
        service = [
                SELECT Request_Token_URL__c, Access_Token_URL__c, Consumer_Key__c, Consumer_Secret__c,
                    Authorization_URL__c, Application_Token__c,
                    (SELECT Token__c, Secret__c, Is_Access__c, Realm_Id__c
                    FROM OAuth_Token__r
                    WHERE Owner__c = :UserInfo.getUserId())
                FROM OAuthService__c
                WHERE Name = 'QuickBooks' LIMIT 1];
       
        if(service != NULL && ! service.OAuth_Token__r.isEmpty()) {
            oaToken = service.OAuth_Token__r.get(0);
        }
    }
    
    public void retrieveAllQBAccounts() 
    {
        verifier = NULL;
        callbackUrl = NULL;
        
        token = oaToken.Token__c;
        tokenSecret = oaToken.Secret__c;
        consumerKey = service.Consumer_Key__c;
        consumerSecret = service.Consumer_Secret__c;
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://qbo.intuit.com/qbo27/resource/payments/v2/' + oaToken.Realm_Id__c);
        //req.setEndPoint('https://qb.sbfinance.intuit.com/v3/company/1183910435/customer/1');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        sign(req);
        // System.debug('::::: Request = ' + req.getBodyDocument());
        System.debug('::::: Request = ' + req.getHeader('Content-Type'));
        System.debug('::::: Request = ' + req.getHeader('oauth_token'));
        System.debug('::::: Request = ' + req.getHeader('oauth_consumer_key'));
        System.debug('::::: Request = ' + req.getHeader('Host'));
        System.debug('::::: Request = ' + req.getHeader('oauth_version'));
        System.debug('::::: Request = ' + req.getHeader('oauth_nonce'));
        System.debug('::::: Request = ' + req.getHeader('oauth_signature_method'));
        System.debug('::::: Request = ' + req.getHeader('oauth_signature'));
        
        HttpResponse res;
        if(Test.isRunningTest())
        {
          res = new HttpResponse();
        } 
        else
        {
            res = h.send(req);
        }
        
        
        System.debug('::::: Response = (' + res.getStatusCode() + ')' + res.getBody());
        DOM.Document doc = new DOM.Document(); 
        doc.load(res.getBody().replace('qbo:',''));
        string xmlnamespace=doc.getRootElement().getNamespace();
        system.debug('@@@@@@@@@@@@@@@@@@@'+doc.getRootElement().getName());
        system.debug('@@@@@@@@@@@@@@@@@@@'+xmlnamespace);
       
         
        system.debug('@@@@@@@@@@@@@@@@@@@'+doc.getRootElement().getChildElements()[0].getname());
        system.debug('@@@@@@@@@@@@@@@@@@@'+doc.getRootElement().getChildElement('Count',xmlnamespace).getChildElements());
        for(dom.XmlNode node : doc.getRootElement().getChildElements()[0].getChildElements()) 
        {
          system.debug('-----------------'+node.getChildElement('Line',xmlnamespace).getChildElement('Amount',xmlnamespace).getName()+'-----------------'+node.getChildElement('Line',xmlnamespace).getChildElement('Amount',xmlnamespace).getText());
        }
        for(dom.XmlNode node : doc.getRootElement().getChildElement('CdmCollections',xmlnamespace).getChildElements()) 
        {
          system.debug('$$$$$$$$$$$$$$$'+node.getName());
        }
    }
    
    public void createCustomers()
    {
        token = oaToken.Token__c;
        tokenSecret = oaToken.Secret__c;
        consumerKey = service.Consumer_Key__c;
        consumerSecret = service.Consumer_Secret__c;
        System.debug('---------------------+CustomerName+-----------$');
        string str=  '<Customer xmlns="http://schema.intuit.com/finance/v3" domain="QBO" sparse="false"><FamilyName>'+CustomerName+'</FamilyName></Customer>';
        
        // '<?xml version="1.0" encoding="utf-8"?><Customer xmlns:ns2="http://www.intuit.com/sb/cdm/qbo" xmlns="http://www.intuit.com/sb/cdm/v2"><TypeOf>Person</TypeOf><Name>testing book</Name><Address>'+
         // '<Line1>Park Avenue</Line1><City>Woodland Hills</City><CountrySubDivisionCode>CA</CountrySubDivisionCode><PostalCode>91367</PostalCode></Address><Phone><DeviceType>Mobile</DeviceType><FreeFormNumber>(770) 349-1200</FreeFormNumber>'+
          //'</Phone><Phone><DeviceType>Fax</DeviceType><FreeFormNumber>(770) 349-1300</FreeFormNumber></Phone><WebSite><URI>http://www.digitalinsight.mint.com/</URI></WebSite><Email><Address>john_doe@digitalinsight.mint.com</Address></Email>'+
          //'<GivenName>John</GivenName><MiddleName>J</MiddleName><FamilyName>Doe</FamilyName><DBAName>Mint</DBAName><SalesTermId>5</SalesTermId></Customer>';
           
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://qb.sbfinance.intuit.com/v3/company/'+ oaToken.Realm_Id__c+'/customer');// + oaToken.Realm_Id__c);
        //req.setEndpoint('https://qb.sbfinance.intuit.com/v3/company/1270517005/customer' + oaToken.Realm_Id__c);
        //https://qbo.intuit.com/qbo27/resource/customer/v2/
        // https://qb.sbfinance.intuit.com/v3/company/1270517005/customer
        //req.setEndPoint('https://qb.sbfinance.intuit.com/v3/company/1183910435/customer/1');
        req.setHeader('Content-Type', 'application/xml');     
        
       
        sign(req);
        req.setBody(str);
        System.debug('::::: Request = ' + req);
        
        HttpResponse res;
        if(Test.isRunningTest()) 
        {
          res = new HttpResponse();
        } 
        else 
        {
            res = h.send(req);
        }
        
        system.debug('$$$$$'+res);
        System.debug('::::: response = ' + res.getbody());
    }
    
    public void CreateCustomer(QuickBookCustomer quickbookCust)
    {    
        token = oaToken.Token__c;
        tokenSecret = oaToken.Secret__c;
        consumerKey = service.Consumer_Key__c;
        consumerSecret = service.Consumer_Secret__c;
        System.debug('---------------------+quickbookCust+-----------$'+quickbookCust);
        newContact =quickbookCust;
       
        string str=  '<Customer xmlns="http://schema.intuit.com/finance/v3" domain="QBO" sparse="false"><FamilyName>'+quickbookCust.FamilyName+'</FamilyName><GivenName>'+quickbookCust.GivenName+'</GivenName><Active>'+quickbookCust.IsActive+'</Active><Balance>'+quickbookCust.Balance+'</Balance><Mobile><FreeFormNumber>'+quickbookCust.Mobile+'</FreeFormNumber></Mobile><PrimaryEmailAddr><Address>'+quickbookCust.Email+'</Address></PrimaryEmailAddr></Customer>';
     //  string str=  '<Customer xmlns="http://schema.intuit.com/finance/v3" domain="QBO" sparse="false"><FamilyName>'+quickbookCust.FamilyName+'</FamilyName><GivenName>'+quickbookCust.GivenName+'</GivenName><Active>'+quickbookCust.IsActive+'</Active><Balance>'+quickbookCust.Balance+'</Balance><FreeFormNumber>'+quickbookCust.Mobile+'</FreeFormNumber> </Customer>';
        
        // '<?xml version="1.0" encoding="utf-8"?><Customer xmlns:ns2="http://www.intuit.com/sb/cdm/qbo" xmlns="http://www.intuit.com/sb/cdm/v2"><TypeOf>Person</TypeOf><Name>testing book</Name><Address>'+
         // '<Line1>Park Avenue</Line1><City>Woodland Hills</City><CountrySubDivisionCode>CA</CountrySubDivisionCode><PostalCode>91367</PostalCode></Address><Phone><DeviceType>Mobile</DeviceType><FreeFormNumber>(770) 349-1200</FreeFormNumber>'+
          //'</Phone><Phone><DeviceType>Fax</DeviceType><FreeFormNumber>(770) 349-1300</FreeFormNumber></Phone><WebSite><URI>http://www.digitalinsight.mint.com/</URI></WebSite><Email><Address>john_doe@digitalinsight.mint.com</Address></Email>'+
          //'<GivenName>John</GivenName><MiddleName>J</MiddleName><FamilyName>Doe</FamilyName><DBAName>Mint</DBAName><SalesTermId>5</SalesTermId></Customer>';
           
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint('https://qb.sbfinance.intuit.com/v3/company/'+ oaToken.Realm_Id__c+'/customer');// + oaToken.Realm_Id__c);
        //req.setEndpoint('https://qb.sbfinance.intuit.com/v3/company/1270517005/customer' + oaToken.Realm_Id__c);
        //https://qbo.intuit.com/qbo27/resource/customer/v2/
        // https://qb.sbfinance.intuit.com/v3/company/1270517005/customer
        //req.setEndPoint('https://qb.sbfinance.intuit.com/v3/company/1183910435/customer/1');
        req.setHeader('Content-Type', 'application/xml');       
        sign(req);
        req.setBody(str);
        System.debug('::::: Request = ' + req);
        
        HttpResponse res;
        if(Test.isRunningTest())
        {
            res = new HttpResponse();
        } 
        else 
        {
            res = h.send(req);
        }        
        system.debug('$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$'+res);
        System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ response = ' + res.getbody());
         System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ getHeaderKeys = ' + res.getHeaderKeys());
        
   
             
        
        parseXml(res.getbody());
       System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ outxmlstring = ' +outxmlstring);
            
    if(Detail != null && Message != null)
    {
         System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ Error = ' +message);
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Message:'+Message+ + '<br/>' +
        'Details:'+Detail);
       ApexPages.addMessage(myMsg);
    }
    else
    {
      System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ Confirm = ' +newContact.Id);
        if(newContact.Id != null)
        {
      
         ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.Confirm,'Custromer is successfully created, Customer Id is'+newContact.Id);
         ApexPages.addMessage(myMsg);
         Contact cont=new Contact();
         cont.ramki__QucikBookCustomerId__c=string.valueof(newContact.Id);
         cont.FirstName=newContact.GivenName;
         cont.LastName=newContact.FamilyName;
         cont.ramki__QuickBookIsActive__c=newContact.IsActive;
         cont.MobilePhone=newContact.Mobile;
         cont.Email=newContact.Email;
         insert cont;
        }
    }
    ApexPages.getMessages().clear();
    }
   
    
    
    public PageReference authorize() 
    {
        if(service == NULL) 
        {
            return NULL;
        }
        
        // Use 'oob' when you do not have a callback url
        //callbackUrl =
         //   EncodingUtil.urlEncode('http://' + ApexPages.currentPage().getHeaders().get('Host') +
           //     '/QuickBooksLogin', 'UTF-8');
           
       // callbackUrl=EncodingUtil.urlEncode('https://c.ap1.visual.force.com/apex/QuickBooksLogin','UTF-8');
        
        string currentUrl = 'https://' +ApexPages.currentPage().getHeaders().get('Host')+ApexPages.currentPage().getURL();
        system.debug('++++++++++++++++++++++++++currentUrl+++++++++++++++++++'+currentUrl);
        callbackUrl=EncodingUtil.urlEncode(currentUrl,'UTF-8');
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('GET');
        req.setEndpoint(service.Request_Token_URL__c);
        
        consumerKey = service.Consumer_Key__c;
        consumerSecret = service.Consumer_Secret__c;
        
        sign(req);
        
        HttpResponse res = NULL;
        
        if(Test.isRunningTest())
        {
            res = new HttpResponse();
        } 
        else
        {
            res = h.send(req);
        }
        
        System.debug('::::: Response from request token request: (' + res.getStatusCode() + ')' + res.getBody());
        
        String resParams = (Test.isRunningTest() ? 'oauth_token=token&oauth_token_secret=token_secret' :    res.getBody());
        
        Map<String, String> rp = getUrlParams(resParams);
        
        oaToken = new OAuth_Token__c(
                Owner__c = UserInfo.getUserId(),
                OAuthService__c = service.Id,
                Token__c = rp.get('oauth_token'),
                Secret__c = rp.get('oauth_token_secret'),
                Is_Access__c = false);
        
        insert oaToken;
        
        String authorizePage = service.Authorization_URL__c + '?oauth_token=' +
            EncodingUtil.urlDecode(oaToken.Token__c, 'UTF-8') + '&oauth_consumer_key=' +
            service.Consumer_Key__c;
        
        return new PageReference(authorizePage);
    }
    
    public void sign(HttpRequest req) 
    {
        nonce = String.valueOf(Crypto.getRandomLong());
        timestamp = String.valueOf(DateTime.now().getTime() / 1000);
        
        refreshParameters();
        
        String s = createBaseString(parameters, req);
        
        Blob sig = Crypto.generateMac('HmacSHA1', Blob.valueOf(s), Blob.valueOf(consumerSecret + '&' +
            (tokenSecret != NULL ? tokenSecret : '')));
        
        signature = EncodingUtil.urlEncode(EncodingUtil.base64encode(sig), 'UTF-8');
        
        String header = 'OAuth ';
        for(String key : parameters.keySet()) {
            header = header + key + '="' + parameters.get(key) + '", ';
        }
        
        header = header + 'oauth_signature="' + signature + '"';
        
        System.debug('::::: header = ' + header);
        
        req.setHeader('Authorization', header);
    }
    
    public Boolean completeAuthorization(String p_Token, String p_Verifier, String p_RealmId) 
    {
        oaToken = NULL;
        
        try {
            oaToken = [
                    SELECT OAuthService__r.Name, OAuthService__r.Access_Token_Url__c,
                        OAuthService__r.Consumer_Key__c, OAuthService__r.Consumer_Secret__c,
                        Token__c, Secret__c, Is_Access__c, Realm_Id__c
                    FROM OAuth_Token__c
                    WHERE Owner__c = :UserInfo.getUserId()
                    AND Token__c = :EncodingUtil.urlEncode(p_Token, 'UTF-8')
                    AND Is_Access__c = false];
        
        }
        catch(System.QueryException e)
        {
            return false;
        }
        
        consumerKey = oaToken.OAuthService__r.Consumer_Key__c;
        consumerSecret = oaToken.OAuthService__r.Consumer_Secret__c;
        
        this.token = oaToken.Token__c;
        tokenSecret = oaToken.Secret__c;
        
        if(p_Verifier != NULL) 
        {
            this.verifier = EncodingUtil.urlEncode(p_Verifier, 'UTF-8');
        }
        
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setEndpoint(oaToken.OAuthService__r.Access_Token_Url__c);
        req.setBody('');
        
        sign(req);
        
        HttpResponse res = NULL;
        
        if(Test.isRunningTest()) 
        {
            res = new HttpResponse();
        }
        else 
        {
            res = h.send(req);
        }
        
        System.debug('::::: Response from request token request: (' + res.getStatusCode() + ')' + res.getBody());
        
        if(res.getStatusCode() > 299) 
        {
            return false;
        }
        
        String resParams = (Test.isRunningTest() ?  'oauth_token=token&oauth_token_secret=token_secret' :   res.getBody());
        
        Map<String, String> rp = new Map<String, String>();
        for(String s : resParams.split('&'))
        {
            List<String> kv = s.split('=');
            rp.put(kv[0], kv[1]);
        }
        
        oaToken.Token__c = rp.get('oauth_token');
        oaToken.Secret__c = rp.get('oauth_token_secret');
        oaToken.Realm_Id__c = p_RealmId;
        oaToken.Is_Access__c = true;
        
        Database.update(oaToken);
        
        return true;
    }
    
    private void refreshParameters()
     {
        parameters.clear();
        parameters.put('oauth_consumer_key', consumerKey);
        
        if(token != NULL) {
            parameters.put('oauth_token', token);
        }
        
        if(verifier != NULL) {
            parameters.put('oauth_verifier', verifier);
        }
        
        if(callbackUrl != NULL) {
            parameters.put('oauth_callback', callbackUrl);
        }
        
        parameters.put('oauth_signature_method', 'HMAC-SHA1');
        parameters.put('oauth_timestamp', timestamp);
        parameters.put('oauth_nonce', nonce);
        parameters.put('oauth_version', '1.0');
        parameters.put('Host','qbo.intuit.com');
       // parameters.put('X-NewRelic-ID','UQMAU15RGwEFXVFUBQE=');
       // parameters.put('X-NewRelic-Transaction','PxQOI1BaCnEFJlNadgYAVCEDFB8EBw8RVT8=');
        parameters.put('Connection','Keep-Alive');
    }
    
    private String createBaseString(Map<String,String> oauthParams, HttpRequest req) 
    {
        Map<String,String> p = oauthParams.clone();
        
       // if(req.getMethod().equalsIgnoreCase('post') && req.getBody() != NULL &&
           // req.getHeader('Content-Type') == 'application/x-www-form-urlencoded') {
            
            p.putAll(getUrlParams(req.getBody()));
           
        //}
        
        String host = req.getEndpoint();
        Integer n = host.indexOf('?');
        
        if(n > -1) 
        {
            p.putAll(getUrlParams(host.substring(n + 1)));
            host = host.substring(0, n);
        }
        
        List<String> keys = new List<String>();
        keys.addAll(p.keySet());
        keys.sort();
        
        String s = (keys.get(0) != 'status' ?
            EncodingUtil.urlEncode(keys.get(0) + '=' + p.get(keys.get(0)), 'UTF-8') :
            urlEncode(keys.get(0) + '=' + p.get(keys.get(0))));
            
        for(Integer i = 1; i < keys.size(); i++) 
        {
            if(keys.get(i) != 'status') {
                s += EncodingUtil.urlEncode('&' + keys.get(i) + '=' + p.get(keys.get(i)), 'UTF-8');
            } else {
                s += EncodingUtil.urlEncode('&', 'UTF-8');
                s += urlEncode(keys.get(i) + '=' + p.get(keys.get(i)));
            }
        }
        
        return req.getMethod().toUpperCase() + '&' + EncodingUtil.urlEncode(host, 'UTF-8') + '&' + s;
    }
    
    private Map<String, String> getUrlParams(String value) 
    {
        Map<String, String> res = new Map<String, String>();
        
        if(value == NULL || value.trim() == '')
        {
            return res;
        }
        
        for(String s : value.split('&')) 
        {
            List<String> kv = s.split('=');
            if(kv.size() > 1) {
                res.put(kv[0], kv[1]);
            }
        }
        
        return res;
    }
    
    private String urlEncode(String unencodedString) 
    {
        String returnVal = NULL;
        
        if(unencodedString != NULL) 
        {
            returnVal = '';
            
            for(Integer i = 0; i < unencodedString.length(); i++)
             {
                String c = charAt(unencodedString, i);
                
                if(' '.equals(c)) 
                {
                    returnVal += '%20';
                } else 
                {
                    returnVal += EncodingUtil.urlEncode(c, 'UTF-8');
                }
            }
        }
        
        return returnVal;
    }
    
    private String charAt(String str, Integer index)
     {
        if(str == NULL)
        {
            return NULL;
        }
        
        if(str.length() <= 0)
        {
            return str;
        }
        
        if(index < 0 || index >= str.length())
        {
            return null;
        }
        
        return str.substring(index, index + 1);
    }
    
    public void parseXml(string xmlstring)
    {
    try
     {
           DOM.Document xmlDOC = new DOM.Document(); 
           xmlDOC.load(xmlstring); 
           DOM.XMLNode rootElement = xmlDOC.getRootElement();
           outxmlstring=String.valueof(xmlDOC.getRootElement().getName());
           for(DOM.XMLNode xmlnodeobj:xmlDOC.getRootElement().getChildElements())
           {         
                 System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ xmlnodeobj = ' +xmlnodeobj);
              loadChilds(xmlnodeobj);  
                     
           }       
       }
       catch(Exception ex)
       {
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
       ApexPages.addMessage(myMsg);
       }
      
    }
    
    //loading the child elements
    public void loadChilds(DOM.XMLNode xmlnode)
    {
     try
     {
            for(Dom.XMLNode child : xmlnode.getChildElements()) 
            {
                  System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ child = ' +child);
              if(child.getText()!= null)
              {
              outxmlstring+='\n'+child.getName()+': '+child.getText(); 
              System.debug(':::::$$$$$$$$$$$$$$$$$$$$$$$$$$$ child.getName() = ' +child.getName()+': '+child.getText());
              
                if (child.getName()=='Detail')
                {
                     Detail = child.getText();
                }
                else if(child.getName()=='Message')
                {  
                     Message = child.getText();
                }
                else if(child.getName()=='Id')
                {  
                     newContact.Id=integer.valueof(child.getText());
                }
                else if(child.getName()=='DisplayName')
                {  
                     newContact.DisplayName= child.getText();
                }
              }
              loadChilds(child);        
            }
        }
       catch(Exception ex)
       {
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
       ApexPages.addMessage(myMsg);
       }
    }
}