public with sharing class OpprCloseDateCalculationHandler {

	public static void execute(boolean isInsert, boolean isUpdate, List<Opportunity> newList, Map<ID, Opportunity> newMap, List<Opportunity> oldList, Map<ID, Opportunity> oldMap)
	{
		for(Opportunity opp: newList)
		{
			if(isInsert)
			{
				if(opp.stageName!='closed won'||opp.stageName!='closed lost'||opp.stageName!='Closed no decision')
				{
					opp.closedate = system.today()+90;
				}
			}
			if(isupdate)
			{
				if(opp.stageName!='closed won'||opp.stageName!='closed lost'||opp.stageName!='Closed no decision')
				{
					opp.closedate = opp.createddate.date()+90;
				}
			}
		}
	}
}