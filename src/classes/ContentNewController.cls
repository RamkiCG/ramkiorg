public class ContentNewController 
{

  public String var {get;set;}

  public ContentNewController (ApexPages.StandardController controller)
  { }
  public Pagereference pageredir()
    {

        var= ApexPages.currentPage().getParameters().get('Id'); 
        if(var!=null)
            {
            Pagereference newpage = new Pagereference ('/apex/ContentEntryPage?'+var+'&action=edit');
            return newpage;
            }
        else
            {
            Pagereference newpage =Page.ContentEntryPage;
            return newpage;
            }
        }
}