/* Description:
   * ============
   * Class for the VF Component GenericPaginationComponent * 
   * Author:
   * ========
   * www.srinusfdc.com  
   */
 public class GenericPaginationComponentContrl {
   
  //Stores the records which are supplied to the 'Records' attribute.
  public Sobject[] sObjLst {get;set;}
   
  /*
   1. Implementing the pagination with ApexPages.StandardSetController.
   2. We can utilize the built in methods available for the ApexPages.StandardSetController to build the pagination.
   3. Following are the built in mehods we can utilize -
    a. first()
    b. previous()
    c. next()
    d. last()
    e. getHasPrevious() - returns boolean value.
    f. getHasNext() - returns boolean value.
    g. setPageSize(IntegerValue)
  */
  public ApexPages.StandardSetController con {
   get {
    //initializing con with the records.
    if(con == null)
     con = new ApexPages.StandardSetController(sObjLst);
     
    //Setting the pagination size
    con.setPageSize(5);
     
    return con;
   }
   set;
  }
   
  //Method which returns subset of records from the sObjLst.
  public List<sobject> getSobjRecords() {        
   //Type Casing the records and returning to display on the page.
   return (List<sobject>)con.getRecords();
  }
 }