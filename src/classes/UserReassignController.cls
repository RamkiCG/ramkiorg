public with sharing class UserReassignController {

    public String User { get; set; }

   private Account userFromOwnerId = new Account();
    private Account userToOwnerId = new Account();
  
    public Account UserFrom { get
    {
        return userFromOwnerId;
    } 
    set
    {
        userFromOwnerId = value;
    } 
    }

    public Account UserTo { get
    {
         return userToOwnerId;
    } 
    set
    {
        userToOwnerId = value;
    }
    }
}