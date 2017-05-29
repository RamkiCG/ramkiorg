public class QuickBookCustomer
{

public integer Id {get;set;}

//The name of the person or organization as displayed. must be unique name
public string DisplayName {get;set;}

//Family name or the last name of the person.
public string FamilyName {get;set;}

//Given name or first name of a person.
public string GivenName {get;set;}

//If true, this entity is currently enabled for use by QuickBooks.
public boolean IsActive {get;set;}

//Family name or the last name of the person.
public decimal Balance {get;set;}

//Mobile phone number.
public string Mobile {get;set;}


//Email
public string Email{get;set;}


}