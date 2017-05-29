trigger calculatecommissionpayout on Opportunity (after insert,after update) 
{
    for(Opportunity opportunity :trigger.new)
    {
        if(opportunity.StageName=='Closed Won' )
        {
        CommissionPayoutController commissionPayoutController =new CommissionPayoutController(opportunity);
        }
    }

}