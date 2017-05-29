global class FieldsValidator implements Database.Batchable<Sobject> {
    global Database.queryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('select name, fields_info__c, fields_count__c from ObjectsExistingFieldsInfo__c');
    }
    global void execute(Database.BatchableContext bc, List<SObject> sobjLst) {
        String[] types = new String[]{'Account','Contact'};
        String emailBody = '';
        // Make the describe call
        Schema.DescribeSobjectResult[] results = Schema.describeSObjects(types);
        Map<String,List<Field>> objFieldsDesMap = new Map<String,List<Field>>();
        // For each returned result, get some info
        for(Schema.DescribeSobjectResult res : results) {
            Map<String, Schema.SObjectField> objectFields = res.fields.getMap();
            for(Schema.SObjectField fDes : objectFields.values()) {
                if(fDes.getDescribe().isCustom()) {
                    system.debug(fDes.getDescribe().getName()+'@@@'+fDes.getDescribe().getType());
                    String fieldAPIName = String.valueOf(fDes.getDescribe().getName());
                    String fieldDataType = String.valueOf(fDes.getDescribe().getType());
                    if(objFieldsDesMap.containsKey(res.getName())) {
                        objFieldsDesMap.get(res.getName()).add(new Field(fieldAPIName,fieldDataType));
                    }
                    else {
                        objFieldsDesMap.put(res.getName(),new List<Field>{new Field(fieldAPIName,fieldDataType)});
                    }
                }       
            }
        }
        Map<String, ObjectsExistingFieldsInfo__c> objectInfoMap = new Map<String, ObjectsExistingFieldsInfo__c>();
        for(ObjectsExistingFieldsInfo__c objInfo : [select Field_API_Name__c , Fields_Count__c, Fields_Info__c from 
        ObjectsExistingFieldsInfo__c where Field_API_Name__c in: types]) {
            objectInfoMap.put(objInfo.Field_API_Name__c,objInfo);
        }
        for(String type : types) {
            if(objectInfoMap.get(type).fields_count__c == null) {
                objectInfoMap.get(type).fields_count__c = objFieldsDesMap.get(type).size();
                objectInfoMap.get(type).fields_info__c = JSON.serialize(objFieldsDesMap.get(type));
            }
            else {
                System.debug('entering to else condition...');
                System.debug('entering to for loop..');
                List<Field> exstingFields = new List<Field>();
                List<Field> newFields = new List<Field>();
                Map<String,Field> bkupexstingFields = new Map<String,Field>();
                Map<String,Field> bkupnewFields = new Map<String,Field>();
                exstingFields = (List<Field>)JSON.deserialize(objectInfoMap.get(type).fields_info__c, List<Field>.class);
                System.debug('exstingFields: '+exstingFields);
                newFields.addAll(objFieldsDesMap.get(type));
                System.debug('objFieldsDesMap: '+objFieldsDesMap);
                System.debug('newFields: '+newFields);
                for(Field f : exstingFields) {
                    bkupexstingFields.put(f.apiName,f);
                }
                for(Field f : newFields) {
                    bkupnewFields.put(f.apiName,f);
                }
                for(Field f : exstingFields) {
                    bkupnewFields.remove(f.apiName);
                }
                for(Field f : newFields) {
                    bkupexstingFields.remove(f.apiName);
                }
                System.debug(bkupnewFields+'@@@'+bkupexstingFields);
                emailBody += type + ' : ';
                //for new fields
                for(Field f :bkupnewFields.values()) {
                    emailBody += f.apiName + ' with datatype '+f.dataType+' is newly created.'; 
                }
                objectInfoMap.get(type).fields_count__c = objFieldsDesMap.get(type).size();
                objectInfoMap.get(type).fields_info__c = JSON.serialize(objFieldsDesMap.get(type));
            }
        }
        /*** Sending Email ***/
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new List<String>{'softramki@gmail.com'});
        mail.setSubject('Fields Update');
        mail.setPlainTextBody(emailBody);
        update objectInfoMap.values();
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
    global void finish(Database.BatchableContext bc) {
    } 
    public class Field {
        String apiName, dataType;
        public Field(String apiName, String dataType) {
            this.apiName = apiName;
            this.dataType = dataType;
        }
    }
}