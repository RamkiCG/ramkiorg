trigger childcount on Account (after insert,after update) 
{
Account[] Accounts=trigger.new;

Account myparentaccount;
for(Account account : Accounts)
{
if(account.Parentid != null)
{
myparentaccount=[select id,Child_Count__c from Account where id =:account.Parentid];

myparentaccount.Child_Count__c=[select count() from Account where parentid =:myparentaccount.id];

update myparentaccount;
}
//account.Child_Count__c=[select count() from account where Parent.Name=:'metasts'];
}

//update myparentaccount;


}