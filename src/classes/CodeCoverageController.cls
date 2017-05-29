/* Controller class for Code_Coverage page */
public with sharing class CodeCoverageController{
	
	final static String endpoint = URL.getSalesforceBaseUrl().toExternalForm()+'/services/data/v30.0/tooling';
	final static String APEXCODECOVERAGE_FIELD = 'ApexTestClassId, TestMethodName, ApexClassorTriggerId, NumLinesCovered, NumLinesUncovered, Coverage';
	final static String APEXCLASS_FIELD = 'Name, Body, LengthWithoutComments, Status';
	final static String APEXTRIGGER_FIELD = 'Name, Body, LengthWithoutComments, Status';
	
	
	// get the response result from Tooling Api
 	public static String getCodeUnits(){
 		
 		try{
 			String responseJson = getToolApiResponseJsonResult();
	 		// if it got error then show to ui
	 		if(responseJson.contains('SFDCError:')){
	 			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,responseJson));
	 		}
	 		// parse the json result 
	 		else{
				Map<ID,List<ToolingApiResult.cls_records>> responseResultsByClassId = new Map<ID,List<ToolingApiResult.cls_records>>(); 
	 			ToolingApiResult result = ToolingApiResult.parse(responseJson);
 				for(ToolingApiResult.cls_records record : result.records){
 					List<ToolingApiResult.cls_records> records = responseResultsByClassId.get(record.ApexClassOrTriggerId);
 					if(records == null){
 						records = new List<ToolingApiResult.cls_records>();
 						responseResultsByClassId.put(record.ApexClassOrTriggerId,records);
 					}
 					records.add(record);
 				}
 				
 				// store the value in wrapper so that can be used in angular js for showing data
				List<ToolingApiWrapper> wrappers = new List<ToolingApiWrapper>();
				
 				// query to get records from ApexClass
 				String query = 'Select '+APEXCLASS_FIELD+' from ApexClass';
 				List<ApexClass> apexClasses = Database.query(query);
 					
 				// query to get records from ApexTrigger
 				query = 'Select '+APEXTRIGGER_FIELD+' from ApexTrigger';
 				List<ApexTrigger> apexTriggers = Database.query(query);
 					
 				// initiallizing the wrapper class for ApexClass
 				for(ApexClass apex : apexClasses){
 					ToolingApiWrapper wrapper = new ToolingApiWrapper();
 					wrapper.apexclass = apex;
 					List<ToolingApiResult.cls_records> records = responseResultsByClassId.get(apex.id);
 					wrapper.coveredLines = new Set<Integer>();
 					wrapper.uncoveredLines = new Set<Integer>();
 					if(records != null && !records.isEmpty()){
 						// for covered lines
 						for(ToolingApiResult.cls_records rec : records){
	 						ToolingApiResult.cls_Coverage cov = rec.Coverage;
			        		for(Integer line : cov.coveredLines){
			        			wrapper.coveredLines.add(line);
			        		}
 						}
 						// for uncovered lines
 						for(ToolingApiResult.cls_records rec : records){
	 						ToolingApiResult.cls_Coverage cov = rec.Coverage;
			        		for(Integer line : cov.uncoveredLines){
			        			// if line contains in the convered line then not add to uncovered line
			        			if(!wrapper.coveredLines.contains(line)){
			        				wrapper.uncoveredLines.add(line);
			        			}
			                }
 						}
 						
 						// add the coverage code percentage
 						wrapper.codeCoverage = (wrapper.coveredLines.size() * 100) /(wrapper.coveredLines.size() + wrapper.uncoveredLines.size()); 
 					}
	                wrappers.add(wrapper);
	        	}
 				// initiallizing the wrapper class for ApexTrigger
 				for(ApexTrigger trigg : apexTriggers){
 					ToolingApiWrapper wrapper = new ToolingApiWrapper();
 					wrapper.apextrigger = trigg;  
 					List<ToolingApiResult.cls_records> records = responseResultsByClassId.get(trigg.id);
 					wrapper.coveredLines = new Set<Integer>();
 					wrapper.uncoveredLines = new Set<Integer>();
 					if(records != null && !records.isEmpty()){  
 						for(ToolingApiResult.cls_records rec : records){
	 						ToolingApiResult.cls_Coverage cov = rec.Coverage;
			        		for(Integer lines : cov.coveredLines){
			        			wrapper.coveredLines.add(lines);
			        		}
 						}
 						// for uncovered lines
 						for(ToolingApiResult.cls_records rec : records){
	 						ToolingApiResult.cls_Coverage cov = rec.Coverage;
			        		for(Integer line : cov.uncoveredLines){
			        			// if line contains in the convered line then not add to uncovered line
			        			if(!wrapper.coveredLines.contains(line)){
			        				wrapper.uncoveredLines.add(line);
			        			}
			                }
 						}
 						
 						// add the coverage code percentage
 						wrapper.codeCoverage = (wrapper.coveredLines.size() * 100) /(wrapper.coveredLines.size() + wrapper.uncoveredLines.size()); 
 					}
 					wrappers.add(wrapper);
 				}
 					
 				if(!wrappers.isEmpty()){
 					return  JSON.serialize(wrappers);
 				}
 			}  
 		}
 		catch(Exception e){
 			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR,e.getMessage()));
 		}
 		return '';
 	}

	/* Calling tooling api webservice and gettting the result */
	
	 // used receive response by sending a http request
    private static String getResponse(HttpRequest req){
        try
        {
            Http httpreq = new Http();
            HttpResponse res = httpreq.send(req);
            String reqresponse = res.getBody();
            return reqresponse;
        }
        catch (Exception e){return
        'SFDCError:' +e.getMessage();}
    }
 
    // create a http request with required endpoint and request method
    private static HttpRequest createHttpRequest(String epoint, String method){
        HttpRequest req = new  HttpRequest();
        epoint += '';
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionID());
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(epoint);
        req.setMethod(method);
        return req;
    }
    
    private static String getToolApiResponseJsonResult(){
		String query = 'Select '+APEXCODECOVERAGE_FIELD+' from ApexCodeCoverage';
		HttpRequest req = createHttpRequest(endpoint+'/query?q='+EncodingUtil.urlEncode(query, 'UTF-8'),'GET');
		String responseJson = getResponse(req); 
		return responseJson;
    }
    
    
    /* Wrapper Class for helping to show value in visualforce page */
    public class ToolingApiWrapper{
    	public ApexClass apexclass { get; set; }
    	public ApexTrigger apextrigger { get; set; }
    	public Set<Integer> coveredLines { get; set; }
    	public Set<Integer> unCoveredLines { get; set; }
    	public Integer codeCoverage {get;set;}
    	public ToolingApiWrapper(){
    		codeCoverage = 0;
    	}
    }
}