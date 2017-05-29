public class childcount
{
    
    public static void childcount(Account[] accounts) 
    {
        integer count=0;
        for (Account account : accounts)
        {
            if(account.Parent.Name=='metasts')
            {
                count++;
                account.Child_Count__c+=count;
            }
        }
    }
}