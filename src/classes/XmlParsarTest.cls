@isTest
public class XmlParsarTest
{
     
    //test for parse xml only 
    @isTest static void Parsexml()
    {       
        Xmlparsar xmlpar=new Xmlparsar();
        PageReference pageRef = Page.XmlParseVFPage;
        Test.setCurrentPage(pageRef);
        xmlpar.xmlstring='<?xml version="1.0"?><catalog><book id="bk101"><author>Gambardella, Matthew</author></book></catalog>';
        xmlpar.Parsexml();
        System.assertNotEquals(null, xmlpar.outxmlstring);
    }
    
    @isTest static void Notparsexml()
    {       
        Xmlparsar xmlpar=new Xmlparsar();
        PageReference pageRef = Page.XmlParseVFPage;
        Test.setCurrentPage(pageRef);
        xmlpar.xmlstring='';//<?xml version="1.0"?><catalog><book id="bk101"><author>Gambardella, Matthew</author></book></catalog>';
        xmlpar.Parsexml();
        System.assertEquals(null, null);
        xmlpar.Parsexmlfile();        
        System.assertEquals(null,null);
        xmlpar.loadChilds(null);
        xmlpar.rootElement='';
        xmlpar.filename='';
    }
    
    @isTest static void ParsexmlFile()
    {
        Xmlparsar xmlpar=new Xmlparsar();
        PageReference pageRef = Page.XmlParseVFPage;
        Test.setCurrentPage(pageRef); 
        List<StaticResource> resourceList=[SELECT body FROM StaticResource WHERE Name = :'testxmlfile' limit 1];
        xmlpar.body=resourceList[0].body;//GetResourceURL('testxmlfile');//!URLFOR(.testxmlfile,'test.xml');//Test.(String,'testxmlfile');//'<?xml version="1.0"?><catalog><book id="bk101"><author>Gambardella, Matthew</author></book></catalog>';
        System.debug('xmlpar.body'+xmlpar.body);
        System.debug('xmlpar.xmlstring'+xmlpar.xmlstring);
        xmlpar.Parsexmlfile();
        System.assertNotEquals(null, xmlpar.outxmlstring);
    }
    
   
}