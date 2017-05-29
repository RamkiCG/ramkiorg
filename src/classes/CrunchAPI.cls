global class CrunchAPI
{

     public static JSONParser parseJSONResponse(string newEndpoint) 
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





}