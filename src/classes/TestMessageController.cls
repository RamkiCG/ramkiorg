public class TestMessageController
{
    public Account test{get;set;}
    public TestMessageController()
    {
      //  test = <span id="IL_AD1" class="IL_AD">new Account</span>();
        test=new Account();
        
    }
    
    public void testmessage()
    {
        //test.Id.addError('Correct');
        
         test.Name.addError('Cant Empty');
    }
}