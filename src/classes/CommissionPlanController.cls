public class CommissionPlanController
{

    Public Integer noOfRecords{get; set;}
    Public Integer size{get;set;}

    //Constructor
    public CommissionPlanController(ApexPages.StandardSetController controller) 
    {
        this.existingPlans=(ramki__COMMISSION_PLAN__c)controller.getRecord(); 
    }
    
    //Commission Plan Wrapper List
    public  List<CommissionPlanWrapper> CommissionPlanWrapperList {get; set;}
   
    //No of Order Id
    public  Integer addOrderCount {get; set;}
    
    //Commission Plan Name
    public  String  PlanName {get; set;}
    
    //Commission Plan Object
    private final ramki__COMMISSION_PLAN__c existingPlans;
   
    // commandlink Edit CommissionPlan property
    public String EditCommissionPlanId{get;set;}
    
    // Delete CommissionPlan 
    public String DeleteCommissionPlanId {get;set;} 
    
    // Clone CommissionPlan 
    public String CloneCommissionPlanId {get;set;} 
    
    //get existing PlanNames
    private List<String> existingPlanNames=new List<String>();
    
    //get the Existing Plan Records
    public ApexPages.StandardSetController planRecords
    {
        get 
        {
            if(planRecords == null) 
            {
                 size = 11;
                planRecords = new ApexPages.StandardSetController(
                    Database.getQueryLocator([SELECT Id,Name,ramki__ORDER_ID__c,ramki__LOWER_RANGE__c,ramki__UPPER_RANGE__c ,
                    ramki__COMMISSION_PERCENTAGE__c FROM ramki__COMMISSION_PLAN__c ORDER BY Name,ramki__ORDER_ID__c ]));
                    planRecords.setPageSize(size);
                noOfRecords = planRecords.getResultSize();
            }
            return planRecords;
        }
        private set;
    }
    
    //getCommissionPlan Lists
    public List<ramki__COMMISSION_PLAN__c> getCommissionPlanPagination()
    {
         return (List<ramki__COMMISSION_PLAN__c>)planRecords.getRecords();
    }  
    
    private void getPlanNames()
    {       
        for(ramki__COMMISSION_PLAN__c plan :getCommissionPlanPagination())
        {
            existingPlanNames.add(plan.Name.toUpperCase());
        }           
    }
    
    private void pageReload()
    {
     PageReference pageRef = new PageReference(ApexPages.CurrentPage().GetURL());
     pageRef.setRedirect(true);
    }
    
   /* public pageReference refresh()
     {
        planRecords = null;
        getCommissionPlanPagination();
        planRecords.setPageNumber(1);
        return null;
    }*/
    
     public Boolean hasNext {
        get {
            return planRecords.getHasNext();
        }
        set;
    }
    public Boolean hasPrevious {
        get {
            return planRecords.getHasPrevious();
        }
        set;
    }
  
    public Integer pageNumber {
        get {
            return planRecords.getPageNumber();
        }
        set;
    }
  
    public void first() {
        planRecords.first();
    }
  
    public void last() {
        planRecords.last();
    }
  
    public void previous() {
        planRecords.previous();
    }
  
    public void next() {
        planRecords.next();
    }
public void Display()
  {
     ApexPages.Message planErrorMessage = new ApexPages.Message(ApexPages.Severity.Info, 'controller');
                ApexPages.addMessage(planErrorMessage); 
  }
    
    //enter no of order id
    public void addRows()
    { 
        boolean isPlanContain=false;
        getPlanNames();
        for(String oldPlanName:existingPlanNames)
        {
            if(oldPlanName.contains(PlanName.toUpperCase()))
            {
                isPlanContain=true;
                ApexPages.Message planErrorMessage = new ApexPages.Message(ApexPages.Severity.ERROR, 'Already Exists Commission Plan');
                ApexPages.addMessage(planErrorMessage); 
                pageReload();   
              //  CommissionPlanWrapperList.clear();      
                break;
            }
        }
        if(isPlanContain==false)
        {
            CommissionPlanWrapperList=new List<CommissionPlanWrapper>();
            for (Integer ordercount=1; ordercount<=addOrderCount; ordercount++)
            {
                 CommissionPlanWrapperList.add(new CommissionPlanWrapper(ordercount,PlanName));
            }
        }
        pageReload();
    }
    
    //save new commission plan
    public PageReference save()
    {
            List<ramki__COMMISSION_PLAN__c> plans=new List<ramki__COMMISSION_PLAN__c>();
            for (CommissionPlanWrapper wrap : CommissionPlanWrapperList)
            {  
            plans.add(wrap.NewCommissionPlan);    
            }
            insert plans;
              pagereference ref = new pagereference('/apex/CommissionPlanPage');
        ref.setredirect(True);
        return ref;   
           // return new PageReference('/' + Schema.getGlobalDescribe().get('ramki__COMMISSION_PLAN__c').getDescribe().getKeyPrefix());
    }   
    
    //edit commission plan
    public PageReference editCommissionPlan() 
    {
       pagereference ref = new pagereference('/apex/EditPlan?id='+EditCommissionPlanId);
       ref.setRedirect(False);
       return ref;   
    }
    
    //edit commission plan
     public pagereference deleteCommissionPlan()
     {
       ramki__COMMISSION_PLAN__c  deleteplan=[Select id,Name from ramki__COMMISSION_PLAN__c where id=:DeleteCommissionPlanId];
        delete deleteplan;
        pagereference ref = new pagereference('/apex/CommissionPlanPage');
        ref.setredirect(True);
        return ref;   
    }
   
   /* 
    //clone Commission Plan
    public PageReference cloneCommissionPlan() 
    {
    ramki__COMMISSION_PLAN__c plan =  [SELECT Id,Name,ramki__ORDER_ID__c,ramki__LOWER_RANGE__c,ramki__UPPER_RANGE__c ,
                    ramki__COMMISSION_PERCENTAGE__c FROM ramki__COMMISSION_PLAN__c where id =:CloneCommissionPlanId];
    ramki__COMMISSION_PLAN__c cloneplan = plan.clone(false);
    insert cloneplan;
    pagereference ref = new pagereference('/apex/CommissionPlanPage');
    ref.setRedirect(True);
    return ref; 
    }
    
    */
        
    //Commission Plan Wrapper Class
    public class CommissionPlanWrapper
    {
        public ramki__COMMISSION_PLAN__c NewCommissionPlan {get; private set;}
    
        public CommissionPlanWrapper(Integer orderId,String commissionPlanName)
        { 
        NewCommissionPlan=new ramki__COMMISSION_PLAN__c(Name=commissionPlanName,ramki__ORDER_ID__c=orderId); 
        }
        
    }    
}