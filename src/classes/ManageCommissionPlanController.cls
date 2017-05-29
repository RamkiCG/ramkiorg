public class ManageCommissionPlanController 
{
public List<AccountWrapper> wrappers {get; set;}
public static Integer toDelIdent {get; set;}
public static Integer addCount {get; set;}
private Integer nextIdent=0;


public ManageCommissionPlanController()
{
wrappers=new List<AccountWrapper>();
for (Integer idx=0; idx<5; idx++)
{
wrappers.add(new AccountWrapper(nextIdent++));
}
}

public void delWrapper()
{
Integer toDelPos=-1;
for (Integer idx=0; idx<wrappers.size(); idx++)
{
if (wrappers[idx].ident==toDelIdent)
{
toDelPos=idx;
}
}

if (-1!=toDelPos)
{
wrappers.remove(toDelPos);
}
}

public void addRows()
{
 
for (Integer idx=0; idx<addCount; idx++)
{
wrappers.add(new AccountWrapper(nextIdent++));
}
}

public PageReference save()
{
List<ramki__COMMISSION_PLAN__c> accs=new List<ramki__COMMISSION_PLAN__c>();
for (AccountWrapper wrap : wrappers)
{
    if(wrap.isCheck==true)
    {
accs.add(wrap.acc);
    }
}

insert accs;

return new PageReference('/' + Schema.getGlobalDescribe().get('Account').getDescribe().getKeyPrefix() + '/o');
}

public class AccountWrapper
{
public ramki__COMMISSION_PLAN__c acc {get; private set;}
public Integer ident {get; private set;}
public boolean isCheck {get;set;}


public AccountWrapper(Integer inIdent)
{
 
ident=inIdent;
acc=new ramki__COMMISSION_PLAN__c(Name='Bulk Acc ' + ident);
 
}
    
}
}