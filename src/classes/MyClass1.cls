public class MyClass1 extends MyClass
{
    static
    {
  //  MyClassValue1='MyClassValue1\n';
    //System.debug(''+MyClassValue1);
    }
    
     String MyClass1value;
    
    {
    MyClass1value='MyClass1value\n';
     System.debug(''+MyClass1value);
    MyClass1value='MyClass1value1111111111\n';
    }
    
    public MyClass1() 
    {
    System.debug('MyClass1 con \n');
    MyClassValue2='f1';
    }
    
    
   public void go()
    {
       System.debug(this.MyClassValue2+ MyClassValue2);
    }
}