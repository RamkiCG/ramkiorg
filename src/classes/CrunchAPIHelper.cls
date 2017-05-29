global class CrunchAPIHelper
{

    global CrunchAPIHelper()
    {
     //  parseJSONPeopleResponse();     
     parseJSONSingleOrganizationResponse(); 
    }
    
    

global static OrganizationJSONApex JSON2ApexORGNewValue {get;set;}

global static OrganizationJsonParser OrganizationJsonParserNew {get;set;}


   
global static List<CrunchPeople> CrunchPeopleList {get;set;}



 global static String ActiveTab {get; set;} 
 global OrganizationJSONApex OrganizationJSONApexInfo {get;set;}
 
 
 global  class Properties {
        global  Boolean role_company {get;set;}
        global  String email_address {get;set;}
        global  String description {get;set;}
        global  String short_description {get;set;}
        global  Integer founded_on_day {get;set;}
        global  Integer founded_on_month {get;set;}
        global  Integer founded_on_year {get;set;}
        global  String founded_on {get;set;}
        global  Integer founded_on_trust_code {get;set;}
        global  String permalink {get;set;}
        global  String primary_role {get;set;}
        global  Integer closed_on_trust_code {get;set;}
        global  String homepage_url {get;set;}
        global  String name {get;set;}
        global  Boolean is_closed {get;set;}
        global  Integer num_employees_max {get;set;}
        global  Integer num_employees_min {get;set;}
        global  Boolean secondary_role_for_profit {get;set;}
        global  Object closed_on_day {get;set;}
        global  Object closed_on_month {get;set;}
        global  Object closed_on_year {get;set;}
        global  Object closed_on {get;set;}
        global  Boolean role_investor {get;set;}
        global  Integer created_at {get;set;}
        global  Integer updated_at {get;set;}
        global  Integer total_funding_usd {get;set;}
        global  Integer number_of_investments {get;set;}
        global  String stock_symbol {get;set;}
        global  Integer number_of_employees {get;set;}
        }
 

global class CrunchOrganization
{
    global String uuid {get;set;}    
    global String type{get;set;}
    
}

 global  class Metadata {
        global  String version {get;set;}
        global  String www_path_prefix {get;set;}
        global  String api_path_prefix {get;set;}
        global  String image_path_prefix {get;set;}
        }
global class CrunchPeople
{
    global String updated_at{get;set;}
    global String name{get;set;}
    global String created_at{get;set;}
    global String path{get;set;}
    global String type{get;set;}
    
}


  

    //@future(callout=true)
    public static void parseJSONPeopleResponse() 
    {
      string endpoint ='http://api.crunchbase.com/v/2/people?user_key=f781f4a0a7bedbad9861dd607069fd1b'; //'http://www.cheenath.com/tutorial/sfdc/sample1/response.php';
      system.debug('endpoint$' + endpoint );
     
    parseJSONResponse(endpoint);
    
    ///CrunchPeopleListTest=new List<CrunchPeople>();
    ///    CrunchPeopleListTest=[select updated_at,name,created_at,path,type from CrunchPeopleList limit:blockSize ];
    
  
    }
    
     //@future(callout=true)
    public static void parseJSONProductResponse() 
    {
     string endpoint ='http://api.crunchbase.com/v/2/products?user_key=f781f4a0a7bedbad9861dd607069fd1b';
     system.debug('endpoint$' + endpoint );     
     parseJSONResponse(endpoint);
 
    }
   global static String OrganizationType{get; set;} 
  
  public List<SelectOption> getOrganizationTypes() 
  {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('company','company'));
        options.add(new SelectOption('investor','investor'));
        options.add(new SelectOption('school','school'));
        options.add(new SelectOption('group','group'));
        return options;
    }
  
  public static JSONParser parseJSONResponseNew(string newEndpoint) 
     {        
   
        Http httpProtocol = new Http();      
        HttpRequest request = new HttpRequest();
        String endpoint=newEndpoint;   
        request.setEndPoint(endpoint);
        system.debug('endpoint$' + endpoint);        
        // Set the HTTP verb to GET.
        request.setMethod('GET');       
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        System.debug(response.getBody());       
        JSONParser parser = JSON.createParser(response.getBody());
        system.debug('parser ' +parser);      
        return parser;
    }   

    public static void parseJSONSingleOrganizationResponse()
    {
    //string endpoint='http://api.crunchbase.com/v/2/organization/google?user_key=f781f4a0a7bedbad9861dd607069fd1b';
    
        Http httpProtocol = new Http();      
        HttpRequest request = new HttpRequest();
      //  String endpoint=newEndpoint;   
        request.setEndPoint('http://api.crunchbase.com/v/2/organization/google?user_key=f781f4a0a7bedbad9861dd607069fd1b');
       // system.debug('endpoint$' + endpoint); 
        request.setMethod('GET');       
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        System.debug(response.getBody()); 
          JSONParser parser = JSON.createParser(response.getBody());
          
        System.debug('metadatanewparser$'+parser);
     
           
            while (parser.nextToken() != JSONToken.END_OBJECT) 
            {
                System.debug('parser.nextToken()$'+parser.nextToken());
                Metadata metadata1=new Metadata();
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                 {
                    String text = parser.getText();
                    System.debug('text$'+text);                    
                        if (text == 'version') 
                        {
                            metadata1.version = parser.getText();
                        }
                        else if (text == 'www_path_prefix') 
                        {
                            metadata1.www_path_prefix = parser.getText();
                        }
                        else if (text == 'api_path_prefix')
                        {
                            metadata1.api_path_prefix = parser.getText();
                        } 
                        else if (text == 'image_path_prefix')
                        {
                            metadata1.image_path_prefix = parser.getText();
                        }
                 }
                 System.debug('metadata1$'+metadata1);     
           }
     //System.debug('metadatanew$'+metadatanew);
    
    
    
    
   // JSON2ApexORGNewValue=OrganizationJSONApex.parse(string.valueof(parser));
    
   // JSON2ApexORGNewValue= (OrganizationJSONApex)parser.readValueAs(OrganizationJSONApex.class);
     //System.debug('JSON2ApexORGNewValue$'+JSON2ApexORGNewValue);   
    
   // OrganizationJSONApex.consumeObject(parser);
    //OrganizationJSONApex.Sub_organizations subOrg=new OrganizationJSONApex.Sub_organizations(parser);
   // System.debug('subOrg$'+subOrg);    
  //  OrganizationJSONApex.News orgnews=new OrganizationJSONApex.News(parser);
  ////  System.debug('orgnews$'+orgnews);    
   // OrganizationJSONApex.Properties OrgProp=new OrganizationJSONApex.Properties(parser);
   // System.debug('OrgProp$'+OrgProp);    
     
     
    
    }
    public static void parseJSONOrganizationResponse()
    {
    
     string endpoint='http://api.crunchbase.com/v/2/organizations?organization_types='+OrganizationType+'&user_key=f781f4a0a7bedbad9861dd607069fd1b';
     system.debug('endpoint$' + endpoint );     
     parseJSONResponse(endpoint);

    }
   
   // @RemoteAction
    public static void parseJSONResponse(string newEndpoint) 
    {        
    
        CrunchPeopleList=new List<CrunchPeople>();
        Http httpProtocol = new Http();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
         String endpoint=newEndpoint;
        // Set the endpoint URL.
       
         
       
        
  
        request.setEndPoint(endpoint);
          system.debug('endpoint$' + endpoint );    
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);
        System.debug(response.getBody());
       
        JSONParser parser = JSON.createParser(response.getBody());
        
        while (parser.nextToken() != null) 
        {
           
            if (parser.getCurrentToken() == JSONToken.START_ARRAY) 
            {
                    while (parser.nextToken() != null) 
                    {
                        // Advance to the start object marker to
                        //  find next invoice statement object.
                            if (parser.getCurrentToken() == JSONToken.START_OBJECT) 
                            {
                                
                                 CrunchPeople people= (CrunchPeople)parser.readValueAs(CrunchPeople.class);
                               
                                   CrunchPeopleList.add(people);
                             
                                parser.skipChildren();
                            }
                    }
            }
        }
        
      system.debug('CrunchPeopleList ' +CrunchPeopleList);
     // return CrunchPeopleList;
    }   



}