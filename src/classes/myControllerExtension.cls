public class myControllerExtension 
{

 
    private  Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public myControllerExtension(ApexPages.StandardController stdController) 
    {
    Account acct=new Account();
    
   acct.Name='testjj';
    stdController.save();
       // this.acct = (Account)stdController.getRecord();
    }

 public myControllerExtension()
 {
 }
   
   
    public String getGreeting()
     {
        return 'Hello ';
    }
}