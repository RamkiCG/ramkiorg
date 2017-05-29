public with sharing class CCLcConfiguration {
    
    public static String sObjectName = 'Account';
    public static Set<String> sObjectRecordInfo = new Set<String>{'Name, Email'};
    public static List<String> objList = new List<String>{'Event','Contact'};
    public static Set<String> objFieldList = new Set<String>{'Name','Email'};
    public static Set<String> objEventFieldList = new Set<String>{'Subject'};
    
    //For Lookup
    public static Set<String> sObjectLookupFieldsSet = new Set<String>{'Id','Name'};
    public static Map<String,String> sObjectLookupFieldsMap = new Map<String,String>{'Id'=>'Name'}; 

    public static Set<String> objEventFieldSet = new Set<String>{'Subject'};
    
    public static Map<String,set<String>> fieldsToBeDisplayed = new Map<String,set<String>>{objList[0]=>objEventFieldSet,objList[1]=>objFieldList};
    public static String bgColor = '#1797C0 '; //   #1797C0 E78F08 
    public static String cellInactiveColor = '#EDEDED';
    public static String cellActiveColor = '#FFFFFF';
    public static String cellTodayColor = '#CFEFF8  ';//CFEFF8  FDF6D4 
    public static String busyModeColor = '#6777CC';
    public static String outOfOfficeColor = '#B64B32';
    public static String dayDetailColor = '#CFE5EC'; //CFE5EC FFF0A5 
    public static Boolean standardEvents = false;
    
    public CCLcConfiguration () {}
    
}