public  class Xmlparsar
 {
    //xml string 
    public String xmlstring{get;set;}
    
    //display xml string
    public String outxmlstring{get;set;}
    
    //rootelement
    public String rootElement{get;set;}
    
    //
    public String filename{get;set;}
    
    public blob body{get;set;}
       
    //constructor
    public Xmlparsar()
    {
     
    }
    
     
 //Parsing xml what you entered in the left text area
    public pagereference Parsexml()
    { 
     try
     {
           DOM.Document xmlDOC = new DOM.Document(); 
           xmlDOC.load(xmlstring); 
           DOM.XMLNode rootElement = xmlDOC.getRootElement();
           outxmlstring=String.valueof(xmlDOC.getRootElement().getName());
            loadChilds(rootElement);  
          // for(DOM.XMLNode xmlnodeobj:xmlDOC.getRootElement().getChildElements())
           //.())
          // {         
              
           //   loadChilds(xmlnodeobj);  
                     
          // }       
       }
       catch(Exception ex)
       {
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
       ApexPages.addMessage(myMsg);
       }
       return null;
    }
    
    //loading the child elements
    public void loadChilds(DOM.XMLNode xmlnode)
    {
     try
     {
            for(Dom.XMLNode child : xmlnode.getChildElements()) 
            {
              if(child.getText()!= null)
              {
              outxmlstring+='\n'+child.getName()+': '+child.getText(); 
            
              }
              loadChilds(child);        
            }
        }
       catch(Exception ex)
       {
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
       ApexPages.addMessage(myMsg);
       }
    }
    
    
//This is for parsing xml file what you selected
  public pagereference Parsexmlfile()
  {
  try
  {
       DOM.Document xmlDOC = new DOM.Document(); 
       xmlstring=body.tostring();          
       xmlDOC.load(xmlstring); 
       DOM.XMLNode rootElement = xmlDOC.getRootElement();
        outxmlstring=String.valueof(xmlDOC.getRootElement().getName());
         loadChilds(rootElement);
      //gives you root element Name
     //  for(DOM.XMLNode xmlnodeobj:xmlDOC.getRootElement().getChildElements())
     //  {         
                   
     //     loadChilds(xmlnodeobj);  
     //  }  
       }
       catch(Exception ex)
       {
       ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,ex.getmessage());
       ApexPages.addMessage(myMsg);
       }     
      return null;
    }
}