public class SendMailCampaignExtensions
{

   public class CampaignMemberHelper
   {
   
    public CampaignMember CampaignMember {get;set;}
    
    public boolean IsSendMail {get;set;}
    
   }
    
   public Campaign Campaign {get;set;}
   
   public string Subject {get;set;}
   
   public string Description {get;set;}
   
   public string tempProducts {get;set;}
   
    public List<ramki__CampaignProduct__c> CampaignProducts {get;set;}

    public List<CampaignMemberHelper> CampaignMemberHelpers {get;set;}

    public SendMailCampaignExtensions(ApexPages.StandardController controller)
    {
     
     Campaign = (Campaign)controller.getRecord();
     system.debug('Campaign$'+Campaign);
     List<CampaignMember> CampaignMembers =new List<CampaignMember>();
     CampaignMembers =[SELECT CampaignId,ContactId,LeadId,Name,Status,contact.email,ramki__Subject__c,ramki__Products__c,ramki__Description__c FROM CampaignMember where CampaignId=:Campaign.id and ContactId != null]; 
       system.debug('CampaignMembers$'+CampaignMembers );
     CampaignProducts=[select id,ramki__Campaign__c,ramki__Product__c,ramki__Product__r.Name from ramki__CampaignProduct__c where ramki__Campaign__c =:Campaign.id];
     for(ramki__CampaignProduct__c campProd : CampaignProducts)
     {
     tempProducts+=campProd.ramki__Product__r.Name+', \r\n';
     
     }
     tempProducts=tempProducts.replace('null','');
     tempProducts=tempProducts.removeEnd(',');
     if(CampaignMembers.size()>0)
     {
          CampaignMemberHelpers=new List<CampaignMemberHelper>();
          for(CampaignMember campmember : CampaignMembers)
          {
            CampaignMemberHelper camphelp=new CampaignMemberHelper();
            camphelp.IsSendMail=true;
            camphelp.CampaignMember =campmember;
            CampaignMemberHelpers.add(camphelp);
          }
     
     }
    
    }
    
    public PageReference SendMail()
    {
       try
       {
        if(!string.IsBlank(Subject) && !string.IsBlank(Description))
        {
   
           List<CampaignMember> UpdateCampaignMembers =new List<CampaignMember>();
           List<Messaging.SingleEmailMessage> mailList=new List<Messaging.SingleEmailMessage>();
           List<Opportunity> Opportunitys=new List<Opportunity>();
           if(CampaignMemberHelpers.size()>0)
           {
           
               EmailTemplate vfEmailTemplate=[select id,name from EmailTemplate where Name =:'CampaignProductEmailTemplate' limit 1];
               system.debug('vfEmailTemplate$'+vfEmailTemplate);
               for(CampaignMemberHelper camphelp: CampaignMemberHelpers)
                  {
                   
                
                   if(camphelp.IsSendMail ==true)
                   {
                     camphelp.CampaignMember.ramki__Description__c=Description;
                     camphelp.CampaignMember.ramki__Subject__c=Subject;
                      camphelp.CampaignMember.ramki__Products__c=tempProducts;
                     Messaging.SingleEmailMessage mail =   new Messaging.SingleEmailMessage();
                     
                     // Who you are sending the email to
                     mail.setTargetObjectId(camphelp.CampaignMember.ContactId);

                       // The email template ID used for the email
                     mail.setTemplateId(vfEmailTemplate.id);
                     //mail.setSubject(subject);
                     mail.setWhatId(camphelp.CampaignMember.Id);    
                     mail.setBccSender(false);
                     mail.setUseSignature(false);
                     mail.setReplyTo('aa00372768@techmahindra.com');
                     mail.setSenderDisplayName('Mars Help');
                     mail.setSaveAsActivity(false);
                     
                     mailList.add(mail);
                     Opportunity opp=new Opportunity();
                     opp.name='testopp'+camphelp.CampaignMember.Name;
                     opp.StageName='Prospecting';
                     opp.CloseDate=date.today()+2;
                     opp.ramki__Contact__c=camphelp.CampaignMember.ContactId;
                     opp.Campaign=Campaign;                     
                     Opportunitys.add(opp);
                     UpdateCampaignMembers.add(camphelp.CampaignMember);
                    }
                   }
                   if(mailList.size()>0)
                   {
                        upsert UpdateCampaignMembers;
                        Messaging.sendEmail(mailList);
                        insert Opportunitys;
                   }
        }

      }
      else
      {
       if(Subject == '' || Subject == null)
       {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter subject'));
       
       }
      if(Description == '' || Description == null)
      {
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.error,'Please enter description'));
      
       }
       return null;
      }
      Subject = '';
      Description = '';
      ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Confirm,'Mails are sent successfully'));
     PageReference newPage= new PageReference('/' + Campaign.id);
     return newPage.setRedirect(true);
     }
     catch(Exception ex)
     {
        // ApexPages.addMessages(ex);
          system.debug('ex$'+ex+' getStackTraceString$' +ex.getStackTraceString()+' getLineNumber$' +ex.getLineNumber()+' getMessage$' +ex.getMessage());
          return null;
     }
   }
   
   
}