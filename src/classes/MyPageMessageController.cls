public class MyPageMessageController {
    Account account;

    public PageReference save() 
    {
    try{
        update account;
    }
    catch(DmlException ex){
        ApexPages.addMessages(ex);
    }
    return null;
    }

    public String getName() { 
        return 'MyController';
    }

    public Account getAccount()
     {
        
        account = [select id, name from Account limit 1];
        return account;
    }
}