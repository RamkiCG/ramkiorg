public class opportunityStageController {
     //This is the opportunityID that will be sent back when the Stage drop-down list is changed
     public string opportunityID{get;set;}
     //This is the list of opportunities to be displayed in the table.  This will be loaded in the constructor
     public list<opportunity> oppList{get;set;}
 
   public opportunityStageController(){
            //Constructor
           //Populate oppList as needed.  Can use a query string parameter to pass in an Account ID
           oppList = [Select ID, Name, StageName From Opportunity Limit 10];
   }
 
   public List<selectoption> getOppStages() {
        List<selectoption> options = new List<selectoption>();
         
        //This is some generic code to retrieve the current stage names using
        //  Dynamic Apex in case the Stage Names change in the future
        Schema.DescribeFieldResult F = Opportunity.StageName.getDescribe();
    List<schema.picklistentry> typeList = F.getPicklistValues();
             
    for (Schema.PicklistEntry TypeItem : typeList){
          options.add(new SelectOption(TypeItem.getValue(),TypeItem.getLabel()));
        }
         
        return options; 
    }
 
   public pageReference updateOpportunity()
   {
      //Update your opportunity as needed
      list<opportunity> myOppList = new list<opportunity>();
      myOppList = [Select ID, Name, StageName From Opportunity Where ID = :opportunityID];
      //Make changes to opportunity as desired
      if(myOppList.isEmpty() == false)
      {
           update myOppList[0];
      }
      return null;
 
   }  
}