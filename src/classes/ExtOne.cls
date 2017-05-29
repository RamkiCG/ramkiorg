public class ExtOne {

    public ExtOne(Account controller) {

    }


    /*public ExtOne(MyController controller) {

    }*/
    
    /*
   public void save()
    {
     ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Error: Invalid Input.');
            ApexPages.addMessage(myMsg);
     System.debug('save called:');
    }*/

    public ExtOne(ApexPages.StandardController acon) { }

    public String getFoo() {
        return 'foo-One';
    }
}