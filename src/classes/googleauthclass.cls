public class googleauthclass
{

public string authtoken{get;set;}
public string refereshtoken{get;set;}
public string bodyprint{get;set;}

//Settings needed on the google cloud console.One can store this securely in custom settings or an object.

public static final string CLIENT_SECRET='muYMbMrMB7S9tu0aUbg2Lc5l';//Fill as per your registered app settings in google console
public static final string CLIENT_ID='247746389343-4ierno6hceo8g4gneo7nv6d95a0cgd64.apps.googleusercontent.com';//Fill as per your registered app settings in google console
public static final string REDIRECT_URL='https://ramki-dev-ed.my.salesforce.com/apex/GoogleAuth';

public static final string OAUTH_TOKEN_URL='https://accounts.google.com/o/oauth2/token';
public static final string OAUTH_CODE_END_POINT_URL='https://accounts.google.com/o/oauth2/auth';

public static final string GRANT_TYPE='grant_type=authorization_code';

//Scope URL as per oauth 2.0 guide of the google 
public static final string SCOPE='https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile';
public static final string STATE='/profile';

//Approval Prompt Constant
public static final string APPROVAL_PROMPT='force';




   public pagereference connect(){
   
     String x=OAUTH_CODE_END_POINT_URL+'?scope='+EncodingUtil.urlEncode(SCOPE,'UTF-8')+'&state='+EncodingUtil.urlEncode(STATE,'UTF-8')+'&redirect_uri='+EncodingUtil.urlEncode(REDIRECT_URL,'UTF-8')+'&response_type=code&client_id='+CLIENT_ID+'&approval_prompt='+APPROVAL_PROMPT;
     
     pagereference p=new pagereference(x);
     return p;
     
   }
   
    public pagereference showtoken(){
   
   string codeparam=apexpages.currentpage().getparameters().get('code');
      
            // Instantiate a new http object
    Http h = new Http();
    
    String body='code='+codeparam+'&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&redirect_uri='+REDIRECT_URL+'&'+GRANT_TYPE;
    
// Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
    HttpRequest req = new HttpRequest();
    req.setEndpoint(OAUTH_TOKEN_URL);
    req.setHeader('Content-Type','application/x-www-form-urlencoded');
    req.setMethod('POST');
    req.setBody(body);
    
    system.debug('REQUEST BODY'+body);

// Send the request, and return a response
    HttpResponse res = h.send(req);
    
    system.debug('body'+res.getbody());
    
    bodyprint=res.getbody();
    
    return null;
   
   }
   
  
}