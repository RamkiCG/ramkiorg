trigger testquote on Quote (after insert,after update)
{
//List<Quote> newQuotes=trigger.new;
//System.debug('newQuotes'+newQuotes);
List<Quote> UpdateQuotes=new List<Quote>();
List<Opportunity> UpdateOpportunity=new List<Opportunity>();
for(Quote tempQuote : trigger.new)
{
    if(tempQuote.OpportunityId != null)
    {
        if(tempQuote.Status =='Approved')
        {
           // tempQuote.Opportunity.Account=new Account(Name=tempQuote.Opportunity.Id);
            //insert tempQuote.Opportunity.Account;
           
             System.debug('tempQuote.Opportunity'+ tempQuote.Opportunity);
             tempQuote.Opportunity.Amount=100;
            //UpdateQuotes.add(tempQuote);
            //UpdateOpportunity.Add(tempQuote.Opportunity);
             
        }
    }
System.debug('UpdateQuotes'+UpdateQuotes);
}
//update UpdateQuotes;
//update UpdateOpportunity;
}