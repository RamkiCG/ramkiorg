global with sharing class CountryStateCityRemoter 
{

     global static String Country { get; set; }
     global static String State{ get; set; }
     global static String City{ get; set; }
     
     global static List<String> CountryList { get; set; }
     global static List<String> StateList { get; set; }
     global static List<String> CityList { get; set; }
     
     global static List<Account> AccountList {get;set;}
      
    global static Account account { get; set; }
    global CountryStateCityRemoter() { } // empty constructor
    
    @RemoteAction
    global static List<String> getCountries() 
    {
        AggregateResult[] groupedResults =[SELECT BillingCountry FROM Account where BillingCountry!=null GROUP BY BillingCountry]; //[SELECT BillingCountry FROM Account].BillingCountry;
        for (AggregateResult ar : groupedResults)  
        {
        //SELECT Name, BillingStreet, BillingCity, BillingState, BillingPostalCode,BillingCountry, BillingLatitude, BillingLongitude FROM Account
         CountryList.Add(String.valueof(ar.get('BillingCountry')));       
        }
        return CountryList;
    }
    
    /*
    @RemoteAction
    global static List<String> getStates(String Countryvalue) 
    {
        StateList=new List<String>();
        StateList = [SELECT BillingState FROM Account WHERE BillingCountry= :Countryvalue];
        return StateList;
    }
    
    @RemoteAction
    global static List<String> getCites(String Countryvalue,string statevalue) 
    {
        CityList =new List<String>();
        CityList = [SELECT BillingCity FROM Account WHERE BillingCountry= :Countryvalue And BillingState=:statevalue];
        return CityList;
    }
    
    @RemoteAction
    global static List<SObject> getAccounts(String Countryvalue,string statevalue,string Cityvalue) 
    {
       return [SELECT Name, BillingStreet, BillingCity, BillingState, BillingPostalCode,BillingCountry, BillingLatitude, BillingLongitude FROM Account WHERE BillingCountry= :Countryvalue And BillingState=:statevalue And BillingCity =:Cityvalue];
       
    }*/
}