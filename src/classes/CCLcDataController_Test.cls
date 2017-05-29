@isTest
public class CCLcDataController_Test
{

  @istest
  public static void CCLcDataController()
  {
    User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
    CCLcDataController ccdata=new CCLcDataController();
    Set<String> feildSet=new Set<String>();
    feildSet.Add('id');
       feildSet.Add('name');
    CCLcDataController.getRecord('Account',feildSet,null,'20');
     CCLcDataController.upsertRecord(currentuser);
    }
 }
 
 
 
 
}