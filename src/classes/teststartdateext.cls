public class teststartdateext
{

    public teststartdateext(ApexPages.StandardController controller)
    { System.debug('startdate#'+startdate);
     System.debug('Enddate#'+Enddate);
      
    }

    public Opportunity StageVal {get;set;}

    public boolean isRefersh {get;set;}

    public date startdate {get;set;}
    public date enddate {get;set;}
    public datetime test {get;set;}
    public date test1 {get;set;}
    public Integer numberDaysDue  {get;set;}
    {
      startdate=System.today().adddays(-60);
       enddate=System.today();
       }
    public PageReference calculatedate()
    {
    numberDaysDue=enddate.daysBetween(Startdate);
     System.debug('numberDaysDue#'+numberDaysDue);
    System.debug('StageVal#'+StageVal);
     //test = System.now().adddays(-numberDaysDue);
     test1=enddate.adddays(-numberDaysDue);
     return null;

    }
    private void pageReload()
    {
     PageReference pageRef = new PageReference(ApexPages.CurrentPage().GetURL());
     pageRef.setRedirect(true);
    }
    public PageReference mysearch()
    {
        isRefersh=true;
       
        pageReload();
        System.debug('startdate#'+startdate);
     System.debug('Enddate#'+Enddate);
        return null;
    }

}