public virtual class MyClass
{
    public static String MyClassValue1='hhh\n';
    public String MyClassValue2 = 'f ';
    String MyClassValue3;
    
    {
    MyClassValue1='MyClassValue111\n';
     System.debug(''+MyClassValue1);
    MyClassValue1='MyClassValue1111111111111\n';
    }
    public MyClass() 
    {
    //System.out.print(""+hhh);
    System.debug('MyClass con\n');
    }  
    public void MyClass1()
    {
        
    System.debug(''+MyClassValue1);
     System.debug('MyClass1 mtd\n');
    }
}