public class SingleOrganizationResponse
{
   //get or set OrganizationCrunch 
    public OrganizationCrunch OrganizationCrunchValue {get;set;}

    //get query value
    String query= ApexPages.currentPage().getParameters().get('query');
 
    public SingleOrganizationResponse()
    {
        parseJSONSingleOrganizationResponse();
    }

    public  void parseJSONSingleOrganizationResponse()
     {
    
          try 
          {
                OrganizationCrunch testorg=new OrganizationCrunch();
                Http httpProtocol = new Http();      
                HttpRequest request = new HttpRequest();
        
                //http://api.crunchbase.com/v/2/product/AngularJS?user_key=f781f4a0a7bedbad9861dd607069fd1b
               //request.setEndPoint('http://api.crunchbase.com/v/2/organization/google?user_key=f781f4a0a7bedbad9861dd607069fd1b');
       
               if(query==null && query=='')
                {
                    request.setEndPoint('http://api.crunchbase.com/v/2/organization/google?user_key=f781f4a0a7bedbad9861dd607069fd1b');
                }
               else
                {
                     request.setEndPoint('http://api.crunchbase.com/v/2/'+query+'?user_key=f781f4a0a7bedbad9861dd607069fd1b');
                }
                request.setMethod('GET');       
                HttpResponse response = httpProtocol.send(request);
        
                 JSONParser parser = JSON.createParser(response.getBody());
                    while (parser.nextToken() != JSONToken.END_OBJECT) 
                    {
                        if (parser.getCurrentToken() == JSONToken.FIELD_NAME)
                         {
                            String text = parser.getText();
                            System.debug('text$'+text);
                            if (parser.nextToken() != JSONToken.VALUE_NULL) 
                              {
                                   if (text == 'metadata')
                                     {
                                       OrganizationCrunch.MetaData mdata=new OrganizationCrunch.MetaData();                       
                                       mdata=(OrganizationCrunch.MetaData)parser.readValueAs(OrganizationCrunch.MetaData.Class);
                                       testorg.Metadata=mdata;   
                                       OrganizationCrunchValue=testorg;                
                           
                                      } 
                                   else if (text == 'data') 
                                    {
                                          
                                          testorg.data=getDataInfo(parser);
                                          testorg.properties=testorg.data.properties;
                                          testorg.relationships=testorg.data.relationships;                      
                                          testorg.current_team = testorg.relationships.current_team;
                                          testorg.Investments =testorg.data.relationships.Investments; 
                                          testorg.Websites = testorg.relationships.Websites;
                                          testorg.Offices =testorg.data.relationships.Offices; 
                                          testorg.Headquarters = testorg.relationships.Headquarters;
                                          testorg.Past_team =testorg.data.relationships.Past_team;    
                                          testorg.products=testorg.data.relationships.products;    
                                          testorg.Categories=testorg.data.relationships.Categories;  
                                          testorg.images=testorg.data.relationships.images; 
                                          testorg.founders=testorg.data.relationships.founders; 
                                          testorg.Primary_image=testorg.data.relationships.Primary_image; 
                                          testorg.Acquisitions=testorg.data.relationships.Acquisitions; 
                                  
                                           OrganizationCrunchValue=testorg;   
                                    }                 
                                else 
                                {
                                System.debug(LoggingLevel.WARN, 'Root consuming unrecognized property: '+text);
                                }
                        }
                    }
                }
                 
          }
          catch(System.CalloutException e)
           {
             System.debug(LoggingLevel.Error, 'CalloutException : '+e);
           }   
           catch(Exception e)
           {
             System.debug('parseJSONSingleOrganizationResponse:'+e);
            // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ''+e));
           }  
             
        
    }
        
    public OrganizationCrunch.data getDataInfo(JSONParser parser)
    {
      
       OrganizationCrunch.data data1=new OrganizationCrunch.data();
       try
          {
            while (parser.nextToken() != JSONToken.END_OBJECT) 
             {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                  {
                      String text1 = parser.getText();
                      if (parser.nextToken() != JSONToken.VALUE_NULL) 
                         {
                             if (text1 == 'uuid') 
                                {
                                  data1.uuid = parser.getText();
                                } 
                             else if (text1 == 'type') 
                               {
                                   data1.type = parser.getText();
                               } 
                             else if (text1 == 'properties')
                               {
                                    data1.properties = (OrganizationCrunch.properties)parser.readValueAs(OrganizationCrunch.properties.Class);
                               } 
                             else if (text1 == 'relationships') 
                                {
                                    data1.relationships=new OrganizationCrunch.relationships();
                                    data1.relationships=getRelationShipInfo(data1,parser);
                                } 
                             else 
                               {
                                 System.debug(LoggingLevel.WARN, 'Data consuming unrecognized property: '+text1);
                                }
                           }
                  }              
             }
                           System.debug(data1);
                                         
             }
               
         catch(Exception e)
          {
            System.debug('DataInfo:'+e);
            // ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ''+e));
          }   
          return data1;            
    }    
        
   
   
    public OrganizationCrunch.relationships getRelationShipInfo(OrganizationCrunch.data data1,JSONParser parser)
    {
  
    
              while (parser.nextToken() != JSONToken.END_OBJECT) 
              {
                if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'past_team') 
                        {
                         data1.relationships.Past_team=  (OrganizationCrunch.Past_team)parser.readValueAs(OrganizationCrunch.Past_team.Class);
                           // past_team = new Past_team(parser);
                        }
                     
                     
                        else if (text == 'board_members_and_advisors')
                        {
                         data1.relationships.board_members_and_advisors=new OrganizationCrunch.board_members_and_advisors();
                         data1.relationships.board_members_and_advisors= (OrganizationCrunch.board_members_and_advisors)parser.readValueAs(OrganizationCrunch.board_members_and_advisors.Class);
                     
                            //board_members_and_advisors = new Board_members_and_advisors(parser);
                        }
                       
                        else if (text == 'sub_organizations')
                        {
                        data1.relationships.sub_organizations=new OrganizationCrunch.sub_organizations();
                        data1.relationships.sub_organizations= (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                            //sub_organizations = new Sub_organizations(parser);
                        } 
                        
                        else if (text == 'current_team') 
                        {
                        data1.relationships.current_team=new OrganizationCrunch.board_members_and_advisors();
                        
                         data1.relationships.current_team=  (OrganizationCrunch.board_members_and_advisors)parser.readValueAs(OrganizationCrunch.board_members_and_advisors.Class);
                     
                           // current_team = new Board_members_and_advisors(parser);
                        } 
                       
                        else if (text == 'acquisitions')
                        {
                        
                         data1.relationships.acquisitions=  new OrganizationCrunch.Acquisitions();
                         data1.relationships.acquisitions=(OrganizationCrunch.Acquisitions)parser.readValueAs(OrganizationCrunch.Acquisitions.Class);
                     
                        // acquisitions = new Acquisitions(parser);
                        }
                         
                        else if (text == 'competitors')
                        {
                        
                        data1.relationships.competitors=  new OrganizationCrunch.Sub_organizations();
                        data1.relationships.competitors=  (OrganizationCrunch.Sub_organizations)parser.readValueAs(OrganizationCrunch.Sub_organizations.Class);
                     
                           // competitors = new Sub_organizations(parser);
                        } 
                        
                        else if (text == 'offices') 
                        {
                          data1.relationships.Offices=  new OrganizationCrunch.Offices();
                      
                         data1.relationships.Offices=  (OrganizationCrunch.Offices)parser.readValueAs(OrganizationCrunch.Offices.Class);
                     
                           // offices = new Offices(parser);
                        }
                        
                        else if (text == 'headquarters') 
                        {
                        
                         data1.relationships.headquarters=  new OrganizationCrunch.headquarters();
                      
                         data1.relationships.headquarters=  (OrganizationCrunch.headquarters)parser.readValueAs(OrganizationCrunch.headquarters.Class);
                     
                           // headquarters = new Headquarters(parser);
                        } 
                        else if (text == 'funding_rounds') 
                        {
                         data1.relationships.funding_rounds=  new OrganizationCrunch.Sub_organizations();
                      
                         data1.relationships.funding_rounds=  (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                           // funding_rounds = new Sub_organizations(parser);
                        } 
                        else if (text == 'categories') 
                        {
                         data1.relationships.Categories=  new OrganizationCrunch.Categories();
                      
                         data1.relationships.Categories=  (OrganizationCrunch.Categories)parser.readValueAs(OrganizationCrunch.Categories.Class);
                     
                          //  categories = new Categories(parser);
                        } 
                        else if (text == 'members') 
                        {
                         data1.relationships.members=  new OrganizationCrunch.Sub_organizations();
                      
                         data1.relationships.members=  (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                          //  members = new Sub_organizations(parser);
                        }
                        else if (text == 'customers')
                        {
                         data1.relationships.customers=  new OrganizationCrunch.Sub_organizations();
                      
                         data1.relationships.customers=  (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                           // customers = new Sub_organizations(parser);
                        } 
                       
                        else if (text == 'investments') 
                        {
                         data1.relationships.Investments=  new OrganizationCrunch.Investments();
                      
                         data1.relationships.Investments=  (OrganizationCrunch.Investments)parser.readValueAs(OrganizationCrunch.Investments.Class);
                     
                            //investments = new Investments(parser);
                        } 
                        
                     
                        else if (text == 'founders') 
                        {
                         data1.relationships.founders=  new OrganizationCrunch.sub_organizations();
                      
                         data1.relationships.founders=  (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                            //founders = new Sub_organizations(parser);
                        } 
                           
                        else if (text == 'ipo') 
                        {
                         data1.relationships.ipo=  new OrganizationCrunch.Sub_organizations();
                      
                         data1.relationships.ipo=  (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                           // ipo = new Sub_organizations(parser);
                        }
                       
                        else if (text == 'products') 
                        {
                         data1.relationships.products =  new OrganizationCrunch.Sub_organizations();
                         data1.relationships.products =  (OrganizationCrunch.sub_organizations)parser.readValueAs(OrganizationCrunch.sub_organizations.Class);
                     
                           // products = new Sub_organizations(parser);
                        } 
                        
                        else if (text == 'primary_image') 
                        {
                         data1.relationships.primary_image =  new OrganizationCrunch.primary_image ();
                         data1.relationships.primary_image =  (OrganizationCrunch.primary_image )parser.readValueAs(OrganizationCrunch.primary_image.Class);
                     
                         //   primary_image = new Primary_image(parser);
                        } 
                        else if (text == 'images') 
                        {
                         data1.relationships.images =  new OrganizationCrunch.primary_image();
                         data1.relationships.images =  (OrganizationCrunch.primary_image)parser.readValueAs(OrganizationCrunch.primary_image.Class);
                  
                          //  images = new Primary_image(parser);
                        } 
                        else if (text == 'websites') 
                        {
                         data1.relationships.websites =  new OrganizationCrunch.websites();
                         data1.relationships.websites=  (OrganizationCrunch.websites)parser.readValueAs(OrganizationCrunch.websites.Class);
                  //       websites = new Websites(parser);
                        } 
                        else if (text == 'news') 
                        {
                         data1.relationships.News=  new OrganizationCrunch.News();
                         data1.relationships.News=  (OrganizationCrunch.News)parser.readValueAs(OrganizationCrunch.News.Class);
            
                          //  news = new News(parser);
                        } 
                        else 
                        {
                            System.debug(LoggingLevel.WARN, 'Relationships consuming unrecognized property: '+text);                            
                        }
                    }
                }
            }
            
         return  data1.relationships;
        }
    }