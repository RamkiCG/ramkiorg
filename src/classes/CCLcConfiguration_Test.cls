@isTest
public class CCLcConfiguration_Test
{

  @istest
  public static void CCLcConfiguration()
  {
    User currentuser=[Select id from user where id=:userinfo.getuserid()];
    System.runAs(currentuser) 
    {
    CCLcConfiguration ccdata=new CCLcConfiguration();
    }
 }
}