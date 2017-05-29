Public class RunningRevenue
{

Public List<OpportunitySplit> OppSplit{get;set;}
Public Opportunity Opp{get;set;}
public ApexPages.StandardController stdCtrl;


public RunningRevenue(ApexPages.StandardController std) {
stdCtrl=std;
}

Public void PassOwnerId()
{
Opportunity opprec=(Opportunity) stdCtrl.getRecord();
system.debug('>>>>>>>>>>>>>>>>>>>>>'+opprec.OwnerId);

OppSplit=[select SplitOwnerId,SplitOwner.Name,SplitAmount,Opportunity.Name,Opportunity.CloseDate from
      OpportunitySplit where SplitOwnerId=:opprec.OwnerId];

}

Public void PassOppId()
{

Opportunity opprec1=(Opportunity) stdCtrl.getRecord();
system.debug('>>>>>>>>>>>>>>>>>>>>>'+opprec1.Id);

OppSplit=[select SplitOwner.Name,SplitAmount,Opportunity.Name,Opportunity.CloseDate from
      OpportunitySplit where Opportunity.Id=:opprec1.OwnerId];

}


}