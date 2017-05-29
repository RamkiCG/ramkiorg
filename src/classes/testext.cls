public class testext
{

    public testext(ApexPages.StandardSetController controller)
     {

    }

public void save()
    {
    ApexPages.Message planErrorMessage = new ApexPages.Message(ApexPages.Severity.Info, 'Test Ext2');
                ApexPages.addMessage(planErrorMessage);
    }

  public static  void Display123()
  {
     ApexPages.Message planErrorMessage = new ApexPages.Message(ApexPages.Severity.Error, 'Test Ext2');
                ApexPages.addMessage(planErrorMessage); 
  }
}