public with sharing class OtherSalesforce 
{
  String LOGIN_DOMAIN = 'www';
    public String pwd{get;set;}
    public String userName{get;set;}
    public List<Account> acc{get;set;}
    public String errMsg{get;set;}
    public String displayError{get;set;}
    public OtherSalesforce()
    { displayError = 'none';}
    public void fetch()
    {
        errMsg  = 'Some error occurred, please try again';
        try
        {
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://' + LOGIN_DOMAIN + '.salesforce.com/services/Soap/u/22.0');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'text/xml;charset=UTF-8');
        request.setHeader('SOAPAction', '""');
         system.debug('start restapi****************'+request);
        request.setBody('<Envelope xmlns="http://schemas.xmlsoap.org/soap/envelope/"><Header/><Body><login xmlns="urn:partner.soap.sforce.com"><username>' + userName+ '</username><password>' + pwd+ '</password></login></Body></Envelope>');
        system.debug(' _________request.setBody_____________________'+ request);
        Dom.XmlNode resultElmt = (new Http()).send(request).getBodyDocument().getRootElement()
        .getChildElement('Body', 'http://schemas.xmlsoap.org/soap/envelope/')
        .getChildElement('loginResponse', 'urn:partner.soap.sforce.com')
         .getChildElement('result', 'urn:partner.soap.sforce.com');
           system.debug('resultElmt _____________________'+resultElmt );
          final String SERVER_URL = resultElmt.getChildElement('serverUrl', 'urn:partner.soap.sforce.com') .getText().split('/services')[0];
          final String SESSION_ID = resultElmt.getChildElement('sessionId', 'urn:partner.soap.sforce.com') .getText();
          final PageReference theUrl = new PageReference(SERVER_URL + '/services/data/v22.0/query/');
          system.debug('theUrl ^^^^^^^^^^^^^^^^^^'+theUrl );
          theUrl.getParameters().put('q','Select a.Phone, a.Name, a.CreatedBy.FirstName, a.CreatedById From Account a limit 10');
          request = new HttpRequest();
          request.setEndpoint(theUrl.getUrl());
          system.debug('request&&&&&&&&&&&&&&&&&&&&&&&&&'+request);
          request.setMethod('GET');
          request.setHeader('Authorization', 'OAuth ' + SESSION_ID);
          system.debug('request&&&&&&&&&&&&&&&&&&&&&&&&&'+request);
          String body = (new Http()).send(request).getBody();
          system.debug('body$$$$$$$$$$$$$$$$$$$$$$$$$$$'+body);
         JSONParser parser = JSON.createParser(body);
        do
        {
         parser.nextToken();

        }
        while(parser.hasCurrentToken() && !'records'.equals(parser.getCurrentName()));
        parser.nextToken();
        acc = (List<Account>) parser.readValueAs(List<Account>.class);

        }
        catch(Exception e)
        {
         system.debug('catch@@@@@@@@@@@@@@@@@@@@@@@@@@'+e.getmessage());
         displayError = 'block'; 
         }
    }

}