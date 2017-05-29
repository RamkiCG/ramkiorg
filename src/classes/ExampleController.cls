public class ExampleController 
{
 DateTime t1;
transient DateTime t2;

public string getT4()
{
t1=system.now();
t2=system.now();
return ''+t2;
}

}