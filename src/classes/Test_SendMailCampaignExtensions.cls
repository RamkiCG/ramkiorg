@IsTest
public class Test_SendMailCampaignExtensions
{
  
   @IsTest
   public static void TestMtdSendMail()
   {
        Campaign camp = new Campaign();
        camp.Name = 'TestCampaign';
        insert camp;
        
       // Account acc = new Account();
       // acc.Name ='TestAccount';
       // insert acc;
        
        Contact cont= new Contact();
        cont.LastName = 'LastName';
       // cont.AccountId = acc.Id;
        insert cont;
        
        CampaignMember cm = new CampaignMember(); 
        cm.CampaignId = camp.Id;
        cm.ContactId = cont.Id;
        cm.Status = 'Sent';
        insert cm;
        
       // SendMailCampaignExtensions sendMail=new SendMailCampaignExtensions();
       
        
   
   }


}