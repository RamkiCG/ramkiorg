global with sharing class GeoMapUserHelper
{

public Lead leads{get; set;}

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

    @RemoteAction
    global static List<GeoHelper> getGeoMemberList(String lat, String lon) 
    {
    System.debug(LoggingLevel.Info,'Test Lat'+lat+'lon'+lon);
        if(lat == null || lon == null || lat.equals('') || lon.equals('')) 
        {
            lat = '51.096214';
            lon = '3.683153';
        }
        List<GeoHelper> GeoHelperList=new List<GeoHelper>();
        List<Lead> LeadList=[Select Id, Name, Longitude, Latitude,Street, City,State,Country, PostalCode from Lead where CreatedBy.Id=:UserInfo.getUserId()and Longitude != null and Latitude != null];
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


   @RemoteAction
   global static List<Lead> getNearby(String lat, String lon)
    {
        
        
         System.debug(LoggingLevel.Info,'Test Lat'+lat+'lon'+lon);
        if(lat == null || lon == null || lat.equals('') || lon.equals('')) 
        {
            lat = '51.096214';
            lon = '3.683153';
        }
            //Latitude,Longitude
              //  String queryString =
        //    'SELECT Id, Name, Longitude, Latitude, ' +
          //      'Street, City,State,Country, PostalCode ' +
          //  'FROM Lead '+
            
            //System.debug(LoggingLevel.Info,+database.Query(queryString));
     //   return(database.Query(queryString));
        
      return [select Id, Name, Longitude, Latitude,Street, City,State,Country, PostalCode from Lead where City='Chennai' and Longitude != null and Latitude != null];
    }
    
    
  /*
    @RemoteAction
   global static List<Wrapper> getNearby(String lat, String lon) 
    {
   
         wrapper wp=new wrapper();
        if(lat == null || lon == null || lat.equals('') || lon.equals('')) {
            lat = '51.096214';
            lon = '3.683153';
        }

        String queryString =
            'SELECT Id, Name, Location__Longitude__s, Location__Latitude__s, ' +
                'Street, City,State,Country, PostalCode ' +
            'FROM Lead ' +
            'WHERE DISTANCE(Location__c, GEOLOCATION('+lat+','+lon+'), \'km\') < 60 ' +
            'ORDER BY DISTANCE(Location__c, GEOLOCATION('+lat+','+lon+'), \'km\') ' +
            'LIMIT 25';

          String queryString2 =
            'SELECT Id, Name, Location__Longitude__s, Location__Latitude__s, ' +
                'Street, City,State,Country, PostalCode ' +
            'FROM Contact ' +
            'WHERE DISTANCE(Location__c, GEOLOCATION('+lat+','+lon+'), \'km\') < 60 ' +
            'ORDER BY DISTANCE(Location__c, GEOLOCATION('+lat+','+lon+'), \'km\') ' +
            'LIMIT 25';
    
    return wp;
}
*/

}