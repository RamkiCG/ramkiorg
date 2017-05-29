public class MyController 
{

    public MyController() {

    }

    Account account;

    public MyController(String name,String Namw)
    {
    }

    public PageReference save() {
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
     public String getFoo() {
        return 'foo-Zero';
    }

    public Account getAccount() 
    {
        if(account == null)
        account = [select id,name from Account where id = :ApexPages.currentPage().getParameters().get('id')];
        return account;

    }
}