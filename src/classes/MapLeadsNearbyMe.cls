global with sharing class MapLeadsNearbyMe {

public Lead leads{get; set;}

@RemoteAction
   global static List<Lead> getNearby(String lat, String lon) {

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
        return(database.Query(queryString));
    }
}