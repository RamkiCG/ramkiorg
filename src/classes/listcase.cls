public class listcase
 {
    ApexPages.StandardSetController controller;

    public listcase(ApexPages.StandardSetController controller) 
    {
        this.controller = controller;
        controller.setPageSize(5);
    }
    public pageReference ShowAll()
     {
        controller.setPageSize(controller.getResultSize());
        return null;
    }
}