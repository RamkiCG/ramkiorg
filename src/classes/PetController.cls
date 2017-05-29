global with sharing class PetController 
{
   
    
    Map<String, Lead> LeadMap =new Map<String,Lead>();    
    List<Account> acc_new_list=new List<Account>();
    List<contact> contactList=new List<contact>();
  
    List<contact> UpdateContactList=new List<Contact>();
    List<Account> AccountList=new List<Account>();
      Set<Id> ContactIds=new Set<Id>();
      List<contact> deleteContactList=new List<Contact>();
     LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
     
  
     
    global PetController() 
    {
        System.debug('this.newLead$'+this.Lead); 
        System.debug('contactList$'+contactList);
    }


    global Lead Lead
    {
     get 
      {
          if (Lead== null)
            Lead= new Lead();
          return Lead;
        }
        set;
     }

    global Static Attachment attachment 
    {
      get 
      {
          if (attachment == null)
            attachment = new Attachment();
          return attachment;
        }
      set;
      }

   

   
    global void newSave()
    {   
        try
        { 
                insert lead; 
                if (lead.isConverted == false) //to prevent recursion 
                {         
                    Database.LeadConvert lc = new Database.LeadConvert(); 
                    lc.setLeadId(lead.Id);       
                    lc.setConvertedStatus(convertStatus.MasterLabel);
                    lc.setDoNotCreateOpportunity(true);                           
                    LeadMap.put(lead.Email.toLowerCase(),lead);
                    System.debug('LeadMap$'+LeadMap);
                    System.debug('lead$'+lead);
                    Database.LeadConvertResult lcr = Database.convertLead(lc);  
                      ContactIds.add(lcr.getContactId());
                }
                
                   contactList= [SELECT Id,Name,Email,FirstName,LastName,Account.id,Account.Name FROM Contact WHERE Email IN :LeadMap.KeySet()];
                    System.debug('contactList$'+contactList);
                    if(contactList.size()>0)
                    {
                        for(Contact con : ContactList)
                        {
                           System.debug('con$'+con);
                           System.debug('leadmapget$'+LeadMap.get(con.Email.toLowerCase()));
                           Contact newContact=new Contact();
                           newContact=con;
                           newContact.Account.Name=LeadMap.get(newContact.Email.toLowerCase()).Company;
                           newContact.FirstName=LeadMap.get(newContact.Email.toLowerCase()).FirstName;
                           newContact.LastName=LeadMap.get(newContact.Email.toLowerCase()).LastName;
                           UpdateContactList.add(newContact);
                        
                           
                        }
                      update UpdateContactList;
                      deleteContactList=[SELECT Id,Name,Email FROM Contact WHERE Email IN :LeadMap.KeySet() and  ID IN : ContactIds];
                       if(contactList.size()>0)
                        { 
                        delete deleteContactList;
                        }
                    }
                
                insertDogInfo();
                
                
                
                
                 
           }
           catch(Exception ex)
           {
           System.debug(''+ex);           
           }
        Lead= new Lead();
     }
    
    global void insertDogInfo()
    {
    
     for(Contact con :[SELECT Id,Name,Email FROM Contact WHERE Email =:Lead.Email limit 1])
    {
    ramki__Pets__c pet=new ramki__Pets__c();
    pet.Name=LeadMap.get(con.Email.toLowerCase()).ramki__Pets_Name__c;
    System.debug('LeadMap.get(con.Email.toLowerCase()).ramki__DogPhoto__c'+LeadMap.get(con.Email.toLowerCase()).ramki__DogPhoto__c);
    pet.ramki__DogPhoto__c=LeadMap.get(con.Email.toLowerCase()).ramki__DogPhoto__c;
    
    System.debug('pet.ramki__DogPhoto__c'+pet.ramki__DogPhoto__c);
    pet.ramki__DogColor__c=LeadMap.get(con.Email.toLowerCase()).ramki__DogColor__c;
    pet.ramki__DogBreed__c=LeadMap.get(con.Email.toLowerCase()).ramki__DogBreed__c;
    pet.ramki__DogWeight__c=LeadMap.get(con.Email.toLowerCase()).ramki__DogWeight__c;
    pet.ramki__DogSex__c=LeadMap.get(con.Email.toLowerCase()).ramki__DogSex__c;    
    pet.ramki__Dog_Spayed_Neutered__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_Spayed_Neutered__c;    
    pet.ramki__Dog_Date_of_Birth__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_Date_of_Birth__c;    
    pet.ramki__Brand_of_Dog_Food__c=LeadMap.get(con.Email.toLowerCase()).ramki__Brand_of_Dog_Food__c;    
    pet.ramki__Dog_Check_Feeding_Habits__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_Check_Feeding_Habits__c;    
    pet.ramki__Dog_Age_when_adopted__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_Age_when_adopted__c;    
    pet.ramki__Dog_How_and_Where_Adopted__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_How_and_Where_Adopted__c;    
    pet.ramki__Is_your_dog_a_check_all_that_apply__c=LeadMap.get(con.Email.toLowerCase()).ramki__Is_your_dog_a_check_all_that_apply__c;
    pet.ramki__Dog_Fence_Height__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_Fence_Height__c;
    pet.ramki__Dog_Fence_Type__c=LeadMap.get(con.Email.toLowerCase()).ramki__Dog_Fence_Type__c;    
    pet.ramki__Is_your_dog_sound_or_sight_sensitive__c=LeadMap.get(con.Email.toLowerCase()).ramki__Is_your_dog_sound_or_sight_sensitive__c;
    pet.ramki__Please_explain_sound_sensitivity__c=LeadMap.get(con.Email.toLowerCase()).ramki__Please_explain_sound_sensitivity__c;
    pet.ramki__How_do_you_socialize_your_dog__c=LeadMap.get(con.Email.toLowerCase()).ramki__How_do_you_socialize_your_dog__c;   
    pet.ramki__Does_your_dog_show_signs_of_aggression__c=LeadMap.get(con.Email.toLowerCase()).ramki__Does_your_dog_show_signs_of_aggression__c;
    pet.ramki__Please_explain_aggression__c=LeadMap.get(con.Email.toLowerCase()).ramki__Please_explain_aggression__c;  
    pet.ramki__Has_your_dog_ever_bitten_anyone__c=LeadMap.get(con.Email.toLowerCase()).ramki__Has_your_dog_ever_bitten_anyone__c;
    pet.ramki__Did_he_she_break_skin__c=LeadMap.get(con.Email.toLowerCase()).ramki__Did_he_she_break_skin__c;
    pet.ramki__Please_Explain_Bite__c=LeadMap.get(con.Email.toLowerCase()).ramki__Please_Explain_Bite__c;    
    pet.ramki__Favorite_Games_w_Family_Owner__c=LeadMap.get(con.Email.toLowerCase()).ramki__Favorite_Games_w_Family_Owner__c;
    pet.ramki__Where_does_your_dog_sleep_at_night__c=LeadMap.get(con.Email.toLowerCase()).ramki__Where_does_your_dog_sleep_at_night__c;  
    pet.ramki__How_does_dog_react_to_crate__c=LeadMap.get(con.Email.toLowerCase()).ramki__How_does_dog_react_to_crate__c;
    pet.ramki__Can_your_dogs_board_in_the_same_room_tog__c=LeadMap.get(con.Email.toLowerCase()).ramki__Can_your_dogs_board_in_the_same_room_tog__c;
    pet.ramki__Comment__c=LeadMap.get(con.Email.toLowerCase()).ramki__Comment__c;    
    pet.ramki__On_a_scale_of_1_5_how_easy_is_it_to_gro__c=LeadMap.get(con.Email.toLowerCase()).ramki__On_a_scale_of_1_5_how_easy_is_it_to_gro__c;
    pet.ramki__Has_your_dog_ever_needed_to_be_muzzled_f__c=LeadMap.get(con.Email.toLowerCase()).ramki__Has_your_dog_ever_needed_to_be_muzzled_f__c;
    pet.ramki__Vet_Clinic_Name__c=LeadMap.get(con.Email.toLowerCase()).ramki__Vet_Clinic_Name__c;
    pet.ramki__Vet_Phone__c=LeadMap.get(con.Email.toLowerCase()).ramki__Vet_Phone__c;
    pet.ramki__Allergies__c=LeadMap.get(con.Email.toLowerCase()).ramki__Allergies__c;    
    pet.ramki__Allergies_Text__c=LeadMap.get(con.Email.toLowerCase()).ramki__Allergies_Text__c;
    pet.ramki__Is_your_dog_currently_on_flea_preventati__c=LeadMap.get(con.Email.toLowerCase()).ramki__Is_your_dog_currently_on_flea_preventati__c;
    pet.ramki__Flea_Preventative_Type_or_Brand__c=LeadMap.get(con.Email.toLowerCase()).ramki__Flea_Preventative_Type_or_Brand__c;
    pet.ramki__Is_your_dog_currently_on_heartworm_preve__c=LeadMap.get(con.Email.toLowerCase()).ramki__Is_your_dog_currently_on_heartworm_preve__c;    
    pet.ramki__Brand_of_heartworm_preventative__c=LeadMap.get(con.Email.toLowerCase()).ramki__Brand_of_heartworm_preventative__c;
    pet.ramki__Is_your_dog_taking_any_medications__c=LeadMap.get(con.Email.toLowerCase()).ramki__Is_your_dog_taking_any_medications__c;
    pet.ramki__Has_your_dog_ever_had_seizures__c=LeadMap.get(con.Email.toLowerCase()).ramki__Has_your_dog_ever_had_seizures__c;
    pet.ramki__First_Seizure_Date__c=LeadMap.get(con.Email.toLowerCase()).ramki__First_Seizure_Date__c;    
    pet.ramki__Last_Seizure_Date__c=LeadMap.get(con.Email.toLowerCase()).ramki__Last_Seizure_Date__c;
  
    pet.ramki__On_Seizure_Meds__c=LeadMap.get(con.Email.toLowerCase()).ramki__On_Seizure_Meds__c;
    pet.ramki__Please_list_behavior_problems_your_dog_e__c=LeadMap.get(con.Email.toLowerCase()).ramki__Please_list_behavior_problems_your_dog_e__c;    
    pet.ramki__Goals_Enter_any_goals_for_your_dog_that__c=LeadMap.get(con.Email.toLowerCase()).ramki__Goals_Enter_any_goals_for_your_dog_that__c;
    pet.ramki__Special_Instructions__c=LeadMap.get(con.Email.toLowerCase()).ramki__Special_Instructions__c;
   
  
   
    pet.ramki__Contact__c=con.id;
    insert pet;
   
    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId =pet.id;  
    insert attachment;
    
    pet.ramki__StoreImageUrl__c='https://ramki-dev-ed--c.ap1.content.force.com/servlet/servlet.FileDownload?file='+attachment.id;
  
    update pet;
   
    }
    
    }
    
    

}