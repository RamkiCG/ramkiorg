//Error Message Handler
global class ErrorMessageHandler
{

    //It's used for Show the ApexPageMessages
    global static void ShowMessage(ApexPages.Severity severity, String message)
    {
        ApexPages.Message pageMessage = new ApexPages.Message(severity, message);
        ApexPages.addMessage(pageMessage);
    }
    
    //Show Confirm
    public static void ShowConfirm(String confirm)
    {
         ShowMessage(ApexPages.Severity.Confirm,confirm);
    }
    
    //Show Info
    public static void ShowInfo(String info)
    {
        ShowMessage(ApexPages.Severity.Info,info);
    }
    
    //Show Warning
    public static void ShowWarning(String warning)
    {
        ShowMessage(ApexPages.Severity.Warning,warning);
    }
    
    //Show Error
    global static void ShowError(String error)
    {
       ShowMessage(ApexPages.Severity.Error,error);
    }
    
    global static boolean IsValueValid(object value)
    {
        boolean toReturn=false;
        if(value!=null)
        {
            string sval=String.valueOf(value);            
            toReturn=String.isBlank(sval);
        }
        return toReturn;
    }

}