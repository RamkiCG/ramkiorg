public class CommissionPayoutController
{

private Opportunity  opportunity{get;set;}
private ramki__Custom_User__c customUser {get;set;}


public CommissionPayoutController(Opportunity  opportunity)
{
    opportunity=opportunity;
    System.debug('opportunity'+opportunity);
    System.debug('ramki__Custom_User__c'+opportunity.ramki__Custom_User__c);
   // var customUser=opportunity.ramki__Custom_User__c;

}

}