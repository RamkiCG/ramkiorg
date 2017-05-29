global with sharing class AngularDemoController {

    global AngularDemoController (){
        
    }
 
    
    global void fetchdata()
    {
    getAccount();
        getContacts();
    }
    
    global static String getAccount() {
        return JSON.serialize([select name, billingstreet,
            billingcity, billingstate, billingpostalcode
            from account limit 1]);
    }

    global static String getContacts() {
        return JSON.serialize([select id, name, email
            from contact limit 50]);
    }
 
}