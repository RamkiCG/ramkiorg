public class ActionPollerExample
{

    public PageReference Counter() 
    {count++;

        return null;
    }

    public ActionPollerExample()
    {
        count =1;    
    }
 
  public integer count {get;set;}
  
     
}