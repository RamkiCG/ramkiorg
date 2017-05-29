@isTest
public class testJzCampaignMemberTaskCreation
{

    static testMethod void testCampmember()
    {
    
    Lead testLead=new Lead();
    testLead.Lastname='testLead';
    testLead.Company='ramkisoft';
    insert testlead;
    
    Campaign ca1 = new Campaign(Name = 'Testcampaign',IsActive = TRUE);
    insert ca1;
    
    CampaignMember m1 = new CampaignMember();
    m1.LeadId = testLead.Id; 
    m1.CampaignId = ca1.Id;
    insert m1;
    
    //CampaignMemberStatus cms1 = new CampaignMemberStatus(CampaignId=m1.Id, HasResponded=true, Label='Planned', SortOrder=1);
    //insert cms1;
    
    //cms1.CampaignId=m1.Id;
   // cms1.HasResponded=true; 
    //cms1.Label='Completed';
    //cms1.SortOrder=3;
    
   //update cms1;
    
   

    m1.Status = 'Completed';
    update m1;
    
    }

}