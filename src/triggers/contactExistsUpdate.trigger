trigger contactExistsUpdate on Contact(after insert, after update)
 {

    Map<String, Contact> contactMap =new Map<String, Contact>();
    List<Contact> UpdateContact=new List<Contact>();
    for (Contact contact : System.Trigger.new)
    {
        
         if ((contact.Email !=null) &&   (System.Trigger.isInsert || (contact.Email !=  System.Trigger.oldMap.get(contact.Id).Email)))
         {
        
            // Make sure another new lead isn't also a duplicate
    
            if (contactMap.containsKey(contact.Email))
            {
                //contact.Email.addError('Another new Contact has the '
                 //                   +'same email address.');
            }
            else
            {
                contactMap.put(contact.Email, contact);
            }
        }
    }
    
    // Using a single database query, find all the leads in
 
    // the database that have the same email address as any
    
    // of the leads being inserted or updated.
    
    for (Contact contact : [SELECT Email FROM Contact WHERE Email IN :contactMap.KeySet()])
    {
        Contact newContact = contactMap.get(contact.Email);
        UpdateContact.add(newContact );
    }
    update UpdateContact;
}