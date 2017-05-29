public class MyTestApex
{
public mytestapex()
{
    
}
    sObject mysobject;   
    public string  InsertSubject()
    {
    student_Subjects__c sub=new student_Subjects__c();
    sub.Subject_Name__c='Test';
    mysobject=sub;
    insert mysobject;
    return  sub.Subject_Name__c;
    }
    
}