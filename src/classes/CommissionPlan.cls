//Commission Plan for CommissionCalc
public class CommissionPlan
{

    
    public CommissionPlan(ApexPages.StandardSetController controller) 
    {

    }

    //
    public CommissionPlan()
    {
        

    }
    
   
    //gets or sets new commissionPlan
    public ramki__CommissionPlan__c CommissionPlanNew {get;set;}
    
    public String PlanName {get;set;}
       
    //gets or sets the lower range
    public Decimal LowerRange {get;set;}
    
    //gets or sets the upper range
    public Decimal UpperRange {get;set;}
    
    //gets or sets Commissionpercentage
    public integer CommissionPercentage {get;set;}
    
    
    
    //gets or sets the List of range list
    public List<Range> RangeList {get;set;}
    
    
    public class Range
    {    
        Public boolean IsSelected {get;set;}
        public ramki__CommissionRange__c CommissionRange {get;set;}
    }
    
    
     public void AddPlanName()
     {
           try
            {
               if(!ErrorMessageHandler.isValueValid(PlanName))
                {
                CommissionPlanNew =new ramki__CommissionPlan__c();
                CommissionPlanNew.Name=PlanName;
                insert CommissionPlanNew;
                 RangeList =new List<Range>();      
                }
                else
                {
                ErrorMessageHandler.ShowError('Please enter the PlanName');
                }
            }
            catch(Exception ex)
            {
            ApexPages.addMessages(ex);
            }
     }
        
      // range.CommissionPlan__r=CommissionPlanNew;
       //range.CommissionPlan__c=CommissionPlanNew.Id;
     public void AddRange()
     {
       try
       {  
          // if(UpperRange<LowerRange || UpperRange==LowerRange)
           //{
             //ErrorMessageHandler.ShowError('Please enter the LowerRange');
           //}
           //else
           //{
           Range newrange=new Range();
           ramki__CommissionRange__c range=new ramki__CommissionRange__c();
       //    range.ramki__UpperRange__c=UpperRange;
       //    range.ramki__LowerRange__c=LowerRange;
       //    range.ramki__CommissionPercentage__c=CommissionPercentage;
           newrange.CommissionRange =range;
           range.CommissionPlan__r=CommissionPlanNew;
           range.CommissionPlan__c=CommissionPlanNew.Id;
           RangeList.Add(newrange);
           //}
       }
       catch(Exception ex)
        {
          ApexPages.addMessages(ex);
        }
      }
      
     public void RemoveRange()
     {
       try
       {
          for(Integer j = 0; j < RangeList.size(); j++)
          {
               if(RangeList.get(j).IsSelected == true)
               {
                RangeList.remove(j);
               }
          }
   
       }
       catch(Exception ex)
        {
          ApexPages.addMessages(ex);
        }
      }
   
         
     public void save()
     {
       List<ramki__CommissionRange__c> commissionRnageList=new List<ramki__CommissionRange__c>();
        try
        {    
            for(Range ran:RangeList)
            {
            commissionRnageList.Add(ran.CommissionRange);
            }
           // ramki__CommissionRange__c
           insert commissionRnageList;
        }
        catch(DmlException ex)
        {
            ApexPages.addMessages(ex);
        }
        
  }
    
}