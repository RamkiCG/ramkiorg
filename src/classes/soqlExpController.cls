Public with sharing class soqlExpController
{
 Public List<Opportunity> optyList {get;set;}
 Public List<Lead> leaList{get;set;}
 Public List<contact> conList{get;set;}
 Public List<account> accList{get;set;}
   Public soqlExpController(){
   }
 
  Public void soslDemo_method(){
   optyList = New List<Opportunity>();
   leaList = New List<Lead>();
   conList = New List<contact>();
   accList = New List<account>();
   List<List <sObject>> searchList = [FIND 'test' IN ALL FIELDS RETURNING  Account (Id,Name,type),Contact(name,email),Opportunity(name,StageName),Lead(company,name,status) ];
   accList = ((List<Account>)searchList[0]);
   conList  = ((List<contact>)searchList[1]);
   optyList = ((List<Opportunity>)searchList[2]);
   leaList  = ((List<Lead>)searchList[3]);
  }
}