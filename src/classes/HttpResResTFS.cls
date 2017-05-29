public class HttpResResTFS {

    public void CallReq()
    {
         HttpRequest req = new HttpRequest();
     req.setEndpoint('https://softramki.visualstudio.com/DefaultCollection/_apis/projects?api-version=1.0');
     req.setMethod('GET');
     
     // Specify the required user name and password to access the endpoint
     // As well as the header and header information
 
     String username = 'ramakrishnan.a@live.com';
     String password = 'gnnryk3gyinctbph556dz5t6q7wepqlix73czf7nvvlyduvxi72q';
  
     Blob headerValue = Blob.valueOf(username + ':' + password);
     String authorizationHeader = 'BASIC ' +headerValue;
     //EncodingUtil.base64Encode(headerValue);
     req.setHeader('Authorization', authorizationHeader);
     req.setHeader('Content-Type', 'application/json');
     req.setHeader('Content-Length', '512');      
// Create a new http object to send the request object
     // A response object is generated as a result of the request  
  
     Http http = new Http();
     HTTPResponse res = http.send(req);
     System.debug(res.getBody());
    }
    
}