@isTest
                        
global class MockHttpResponseGenerator implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        String json = '{'+
		'  "size" : 4,'+
		'  "totalSize" : 4,'+
		'  "done" : true,'+
		'  "queryLocator" : null,'+
		'  "entityTypeName" : "ApexCodeCoverage",'+
		'  "records" : [ {'+
		'    "attributes" : {'+
		'      "type" : "ApexCodeCoverage",'+
		'      "url" : "/services/data/v29.0/tooling/sobjects/ApexCodeCoverage/71490000004cBftAAE"'+
		'    },'+
		'    "ApexTestClassId" : "01p90000005PKV6AAO",'+
		'    "TestMethodName" : "testException",'+
		'    "ApexClassOrTriggerId" : "01p90000005PKV5AAO",'+
		'    "NumLinesCovered" : 1,'+
		'    "NumLinesUncovered" : 0,'+
		'    "Coverage" : {'+
		'      "coveredLines" : [ 3 ],'+
		'      "uncoveredLines" : [ ]'+
		'    }'+
		'  }, {'+
		'    "attributes" : {'+
		'      "type" : "ApexCodeCoverage",'+
		'      "url" : "/services/data/v29.0/tooling/sobjects/ApexCodeCoverage/71490000004cBfsAAE"'+
		'    },'+
		'    "ApexTestClassId" : "01p90000005PKV6AAO",'+
		'    "TestMethodName" : "testException",'+
		'    "ApexClassOrTriggerId" : "01p90000005PKV7AAO",'+
		'    "NumLinesCovered" : 7,'+
		'    "NumLinesUncovered" : 25,'+
		'    "Coverage" : {'+
		'      "coveredLines" : [ 5, 6, 8, 11, 12, 39, 40 ],'+
		'      "uncoveredLines" : [ 2, 13, 17, 18, 19, 22, 23, 24, 25, 26, 27, 30, 31, 32, 33, 34, 35, 36, 42, 46, 48, 49, 50, 51, 52 ]'+
		'    }'+
		'  }, {'+
		'    "attributes" : {'+
		'      "type" : "ApexCodeCoverage",'+
		'      "url" : "/services/data/v29.0/tooling/sobjects/ApexCodeCoverage/71490000004cBfuAAE"'+
		'    },'+
		'    "ApexTestClassId" : "01p90000005PKV6AAO",'+
		'    "TestMethodName" : "testException",'+
		'    "ApexClassOrTriggerId" : "01p90000005PKVDAA4",'+
		'    "NumLinesCovered" : 8,'+
		'    "NumLinesUncovered" : 5,'+
		'    "Coverage" : {'+
		'      "coveredLines" : [ 2, 3, 4, 6, 7, 8, 9, 19 ],'+
		'      "uncoveredLines" : [ 12, 13, 14, 15, 16 ]'+
		'    }'+
		'  }, {'+
		'    "attributes" : {'+
		'      "type" : "ApexCodeCoverage",'+
		'      "url" : "/services/data/v29.0/tooling/sobjects/ApexCodeCoverage/71490000004cBfvAAE"'+
		'    },'+
		'    "ApexTestClassId" : "01p90000005PKV6AAO",'+
		'    "TestMethodName" : "testCodeCoverage",'+
		'    "ApexClassOrTriggerId" : "01p90000005PKV5AAO",'+
		'    "NumLinesCovered" : 1,'+
		'    "NumLinesUncovered" : 0,'+
		'    "Coverage" : {'+
		'      "coveredLines" : [ 3 ],'+
		'      "uncoveredLines" : [ ]'+
		'    }'+
		'  } ]'+
		'}';
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(json);
        res.setStatusCode(200);
        return res;
    }
}