trigger testcreatefolder on Lead (after insert) 
{
    List<Folder> folders =new List<Folder>();
    for(Lead l : Trigger.new)
    {
  
     
        try
        {
        Folder fold=new Folder();
        fold.AccessType='Shared';
        fold.DeveloperName=UserInfo.getUserName();
        fold.AccessType='Shared';
        fold.Name=l.name;
        fold.Type='Report';
        
        folders.add(fold);
        SObject ss;
        ss=fold;
        insert ss;
        }
        catch(Exception ex)
        {
        }        
    
       
        
    }
    
    
  
  
}