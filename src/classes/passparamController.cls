Public with sharing class passparamController
 {
  Public Opportunity myInput {get;set;}
  Public Opportunity myoutput{get;set;}
  Public String UserName {get;set;}
  Public void MyMethode()
  {
   User name= [select Name from User where Id=:+myInput.ownerid limit 1];
   UserName = name.name;
  }
}