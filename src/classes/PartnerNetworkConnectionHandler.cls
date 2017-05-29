public without sharing class PartnerNetworkConnectionHandler 
{
    
   /* Creates a PartnerNetworkRecordConnection to share SObjects between Salesforce instances. */
   
   //Params:
   
   //@SobjectInfoList- SObject List
   //@ConnectionName - Like as- Spark Aggregator  we are get connection from S2S_Connection__c Custom setting
   //@RelatedRecords = 'Attachment,CaseComment,Provisioning_Task__c,CaseOrderLineItem__c,Apttus_Config2__OrderLineItem__c' Object API Names
   //@SendClosedTasks = false or true
   //@SendOpenTasks = false or true
   //@SendEmails = false or true
   //@ParentRecordFieldAPIName= 'AccountId' -Field API Name
                   
  public static void autoforwardSObjects(List<Sobject> SobjectInfoList,string ConnectionId,string RelatedRecords,string ParentRecordFieldAPIName,Boolean SendClosedTasks,Boolean SendOpenTasks ,Boolean SendEmails) 
  {
            Savepoint sp = Database.setSavepoint();
            try
            {
                List<PartnerNetworkRecordConnection> PartnerNetworkInsertList = new List<PartnerNetworkRecordConnection>();
                
            
               system.debug('connectionId'+ConnectionId);
              if(SobjectInfoList.size() > 0 && ConnectionId != null) 
              {
                  for(SObject Obj : SobjectInfoList) 
                  {
                    System.debug('Sobj$'+Obj);
                    PartnerNetworkRecordConnection newConnection =new PartnerNetworkRecordConnection();               
                    newConnection.ConnectionId =ConnectionId;
                    newConnection.LocalRecordId =Obj.Id;
                    newConnection.SendClosedTasks =SendClosedTasks;
                    newConnection.SendOpenTasks =SendOpenTasks;
                    newConnection.SendEmails =SendEmails;
                    if(!string.IsBlank(RelatedRecords) && RelatedRecords != null)
                    {
                    newConnection.RelatedRecords =RelatedRecords;
                    }
                    if(!string.IsBlank(ParentRecordFieldAPIName) && ParentRecordFieldAPIName != null)
                    {
                        Id ParentId=(ID)Obj.get(ParentRecordFieldAPIName);
                        if(ParentId != null)
                        {
                        newConnection.ParentRecordId =ParentId;
                        } 
                    }
                    PartnerNetworkInsertList.Add(newConnection);                            
                  }

                  if(PartnerNetworkInsertList.size() > 0) 
                  {
                    if(!Test.isRunningTest()) 
                    {
                           try 
                           {
                              
                             Database.UpsertResult[] srList = database.upsert( PartnerNetworkInsertList,false); 
                              for (Database.UpsertResult sr : srList) 
                              {
                                    if (sr.isSuccess())
                                    {
                                        // Operation was successful, so get the ID of the record that was processed
                                        System.debug('Successfully Shared ID: ' + sr.getId());
                                    }
                                    else 
                                    {
                                            // Operation failed, so get all errors                
                                            for(Database.Error err : sr.getErrors()) 
                                            {
                                                System.debug('The following error has occurred.');                    
                                                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                                System.debug('Incorrect partner network status: ' + err.getFields());
                                            }
                                    }
                              
                                } 
                            }
                            catch( DMLException Ex )
                            { 
                                /*for ( Integer i = 0; i < Ex.getNumDml(); i++ )
                                  if( Ex.getDmlStatusCode( i ) == 'INVALID_PARTNER_NETWORK_STATUS' )
                                    for(PartnerNetworkRecordConnection connectionItem: PartnerNetworkInsertList)
                                     if(ex.getDmlId(i) == connectionItem.Id)
                                          for(SObject obj : SobjectInfoList)
                                            if( connectionItem.LocalRecordId == obj.Id ) 
                                             System.debug('Local Id$ : '+obj.Id+ 'Incorrect partner network status');*/
                                            // obj.addError( 'Incorrect partner network status.' );
                                System.debug('CaseCreationTriggerHelper$ : PartnerNetworkConnectionHandler MethodName$ :autoforwardSObjects'+' LineNumber$ :'+ex.getLineNumber() + 'StackTraceString$ :'+ex.getStackTraceString() + 'Message$ :'+ex.getMessage());
                            }
                    }
                }
              }
            }   
           catch(Exception ex)
           {
                System.debug('CaseCreationTriggerHelper$ : PartnerNetworkConnectionHandler MethodName$ :autoforwardSObjects LineNumber$ :'+ex.getLineNumber() + 'StackTraceString$ :'+ex.getStackTraceString() + 'Message$ :'+ex.getMessage());
                Database.rollback(sp);
           }                
       
}
}