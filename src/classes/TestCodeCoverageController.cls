/* Test class for CodeCoverageController class */
@isTest
private class TestCodeCoverageController {
	
	 static testMethod void testGetCodeUnits() {
	 	 // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        Test.startTest();
        
	 	// calling the getCodeUnits function
	 	String jsonResponse = CodeCoverageController.getCodeUnits();
	 	System.assert(jsonResponse.length() > 0);
	 	
	 	// for the coverage of ToolingApiResult
	 	ToolingApiResult result = new ToolingApiResult();
	 	ToolingApiResult.cls_Coverage coverage = new ToolingApiResult.cls_Coverage();
	 	ToolingApiResult.cls_attributes attributes = new ToolingApiResult.cls_attributes();
	 	ToolingApiResult.cls_records records = new ToolingApiResult.cls_records();
	 	
	 	Test.stopTest();
	 }
}