global with sharing class UserCollectionController
{


 public  User c   { get;set; }
 
 
global class GeoHelper
{
global String Id {get;set;}

global string ObjType {get;set;}

global string Street {get;set;}

global string City {get;set;}

global string State{get;set;}

global string PostalCode{get;set;}

global string Country {get;set;}

global string Name {get;set;}

global Decimal Latitude {get;set;}

global Decimal Longitude {get;set;}


}

global List<GeoHelper> GeoHelperList {get;set;}

global string uservalue {get;set;}
global user usertest {get;set;}

global List<Lead> LeadList {get;set;}

global List<SelectOption>  userlist {get;set;}

global Map<Id,User> UsersMap {get;set;}

global UserCollectionController()
{
 c = new User(); 
   UsersMap = new Map<Id, User>([Select Id, Name From User]);
   userlist=new List<SelectOption>();
   for(User usr: Usersmap.values())
   {
       userlist.add(new SelectOption(usr.id, usr.Name));
   }
 
}

    @RemoteAction
    global static List<GeoHelper> getGeoMemberList() 
    {
    
        List<GeoHelper> GeoHelperList=new List<GeoHelper>();
        List<Lead> LeadList=[Select Id, Name, Longitude, Latitude,Street, City,State,Country, PostalCode from Lead where Longitude != null and Latitude != null];
        if(LeadList.size()>0)
        {
            for(Lead le:LeadList)
            {
            GeoHelper geo=new GeoHelper();
            geo.Id=le.Id;
            geo.Longitude=le.Longitude;
            geo.Latitude=le.Latitude;
            geo.Street=le.Street;
            geo.City=le.City;
            geo.State=le.State;
            geo.Country=le.Country;
            geo.PostalCode =le.PostalCode;
            GeoHelperList.add(geo);
            }
        
        }

 return GeoHelperList;
    }

/*
public void getLeadCollection()
{
LeadList=new List<Lead>();
LeadList=[Select Id, Name, Longitude, Latitude,Street, City,State,Country, PostalCode  from Lead where CreatedBy.Id=:uservalue];

}
*/

 // where UserRoleId IN :allSubRoleIds]);


}