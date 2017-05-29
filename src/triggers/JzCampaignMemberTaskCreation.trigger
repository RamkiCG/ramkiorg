trigger JzCampaignMemberTaskCreation on CampaignMember (before update) 
{
list<Task> AddTask = new List<Task>();

for (CampaignMember CM : Trigger.new) 
{

if (cm.Status == 'Completed') 
{
system.debug(cm + '---------AddTask---------' + CM.Campaign);
AddTask.add(new Task(
Subject = 'Test Follow up with Prospect',
WhoId = CM.ContactId,
ActivityDate = Date.Today().addDays(5),
WhatId = CM.CampaignId));

}
}
insert AddTask;
}