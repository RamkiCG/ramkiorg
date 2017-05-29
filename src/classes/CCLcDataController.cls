public with sharing class CCLcDataController {
    
    public CCLcDataController(){ }
    
    public static List<sObject> getRecord(String objName,set<String> fields,String whereCond,String recLimit){
        system.debug('getRecord +++'+objName+'fields++'+fields+'whereCond++'+whereCond+'recLimit++'+recLimit);
        String query = 'SELECT ';
        Integer listCount = fields.size();
        Integer i = 1;
        for(string field: fields){
            if(i == listCount){
                query += field + ' ';
            }else{
                query += field + ',';
            }
            i++;
        }
        
        query +=' FROM ' + objName;
        
        if(whereCond <> null && whereCond <> ''){
            query += ' WHERE '+whereCond;
        }
        if(recLimit <> null && recLimit <> ''){
            query += ' LIMIT '+recLimit;
        }
        
        System.debug('Query'+query);
        return Database.query(query);
    }
    
    public static Database.upsertResult upsertRecord(sObject recDetail){
        Database.upsertResult databaseSaveResult;
        if(recDetail <> null){
            System.debug('Upsert Record'+recDetail);
            /*try {
               upsert recDetail;
            } catch (DmlException e) {
                System.debug('Exception: '+e.getMessage());                                 
            }*/
            databaseSaveResult = Database.upsert(recDetail,false);          
        }
        return databaseSaveResult;
    }

}