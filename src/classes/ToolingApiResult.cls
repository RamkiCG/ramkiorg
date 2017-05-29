/* Tooling api response is converted to this class which help in further processing */

public class ToolingApiResult {
	
	public Integer size;	
	public Integer totalSize;	
	public boolean done;
	public cls_queryLocator queryLocator;
	public String entityTypeName;	//ApexCodeCoverage
	public cls_records[] records;
	class cls_queryLocator {
	}
	public class cls_records {
		public cls_attributes attributes;
		public String ApexTestClassId;	
		public String TestMethodName;	
		public String ApexClassOrTriggerId;	
		public Integer NumLinesCovered;	
		public Integer NumLinesUncovered;	
		public cls_Coverage Coverage;
	}
	public class cls_attributes {
		public String type;	
		public String url;	
	}
	public class cls_Coverage {
		public Integer[] coveredLines;
        public Integer[] uncoveredLines;
	}
	
	public static ToolingApiResult parse(String json){
		ToolingApiResult result = (ToolingApiResult) System.JSON.deserialize(json, ToolingApiResult.class);
		return result;
	}
	static testMethod void testParse() {  
		String json=		'{'+
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
		ToolingApiResult obj = parse(json);
		System.assert(obj != null);
	}
}