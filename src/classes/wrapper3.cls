public with sharing class wrapper3 
{

public List<conWrapper> lstwrap{get; set;}

public wrapper3(){
 
  lstwrap = new List<conWrapper>();
 
  List<Contact> lst = [Select id, name, phone, email from Contact order by name];
 
  for(Contact c: lst){
   lstwrap.add(new conWrapper(false,c));
  }

}


public pagereference deleteSelected(){
  List<Contact> lstToDel = new List<Contact>();
  for(conwrapper cw: lstwrap){
  
   if(cw.isCheck == true){
    lstTodel.add(cw.con);
   }
 
  }
 
  if(lstTodel.size()>0)
  delete lstTodel;
  else{
   ApexPages.Message msg = new ApexPages.Message(ApexPAges.Severity.Fatal,'Please select a contact to delete');
   apexPages.AddMessage(msg);
   return null;
  }
 
 
  pagereference ref = new PageReference(ApexPages.CurrentPage().GetURL());
  ref.setRedirect(true);
  return ref;

}

}