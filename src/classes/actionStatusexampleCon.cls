public class actionStatusexampleCon 
 {
    Integer count = 0;
                        
    public PageReference incrementCounter() 
    {
           try
            {
            count++;
            return null;
            }
            catch(Exception ex)
            {
            throw ex;
            }
    }
                        
    public Integer getCount() {
        return count;
    }
}