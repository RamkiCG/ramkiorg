public with sharing class RemoteObjectContactOverride
{
     
    @RemoteAction
    public static Map<String, Object> create(String type, Map<String, Object> fields) 
    {
        System.debug(LoggingLevel.INFO, 'Before calling create on: ' + type);
        
        // Invoke the standard create action
        // For when you want mostly-normal behavior, with a little something different
        Map<String, Object> result = RemoteObjectController.create(type, fields);

        System.debug(LoggingLevel.INFO, 'After calling create on: ' + type);
        System.debug(LoggingLevel.INFO, 'Result: ' + result);
        
        // Here's the little something different, adding extra data to the result
        Map<String, Object> customResult = new Map<String, Object> {'custom' => 'my custom data' };
        customResult.putAll(result);
        
        return customResult;
    }
}