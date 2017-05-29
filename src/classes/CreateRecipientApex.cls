public class CreateRecipientApex 
{

    public String email{get;set;}
    public String sms{get;set;}
    public String props{get;set;}
    public String autoconfirm{get;set;}
    public String reason{get;set;}
    public String origin{get;set;}

    
    public static CreateRecipientApex parse(String json)
    {
        return (CreateRecipientApex) System.JSON.deserialize(json, CreateRecipientApex.class);
    }
    
   /* 
    static testMethod void testParse() {
        String json = '{'+
        '  \"email\": \"string\",'+
        '  \"sms\": \"string\",'+
        '  \"props\": \"array[]\",'+
        '  \"autoconfirm\": \"int\",'+
        '  \"reason\": \"string\",'+
        '  \"origin\": \"string\"'+
        '}';
        CreateRecipientApex obj = parse(json);
        System.assert(obj != null);
    }*/
}