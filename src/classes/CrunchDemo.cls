global class CrunchDemo
{


public static string Url {get;set;}


public static List<String> getOrgList()
{
List<String> OrgList=new List<String>();
OrgList.add('organization/tapjoy');
OrgList.add('organization/braintree-payment-solutions');
OrgList.add('organization/paysimple');
OrgList.add('organization/aver-informatics');
OrgList.add('organization/outright');
OrgList.add('organization/aplos-software');
OrgList.add('organization/clearbooks');
OrgList.add('organization/satago-net');
OrgList.add('organization/mobitto');
OrgList.add('organization/aol');
OrgList.add('organization/adchemy');
OrgList.add('organization/adteractive');
OrgList.add('organization/app-net');
OrgList.add('organization/boost-communications');
OrgList.add('organization/celltick-technologies');
OrgList.add('organization/clearstream-tv');
OrgList.add('organization/fishbowl');
OrgList.add('organization/freakout');
return OrgList;
}


 public static PageReference  CrunchValue() 
 {
        PageReference pr = new PageReference('/apex/TestOrgCrunch');
        pr.getParameters().put('query',''+Url);
        pr.setRedirect(true);
        return pr;
 }




}