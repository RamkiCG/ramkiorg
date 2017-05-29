trigger UpdateDescTrigger on EmailMessage(after insert,after update,before insert ,before update) 
{
    //set<id> CaseIds = new set<Id>();
    map<Id,EmailMessage> MapEmailMessage = new map<Id,EmailMessage>();
    List<Case> newList = new List<Case>();
    for(EmailMessage e:trigger.new){
        MapEmailMessage.put(e.ParentId,e);
    }
   
    list<Case> lstC = [select Id,ramki__DescriptionTest__c from Case where id in:MapEmailMessage.keyset()];
    for(Case c:lstC){
        if(MapEmailMessage != null && MapEmailMessage.get(c.Id) != null )
            c.ramki__DescriptionTest__c= MapEmailMessage.get(c.Id).HtmlBody;
            newList.add(c);
    }
    if(newList.size()>0)
    {
        update newList;
    }
}