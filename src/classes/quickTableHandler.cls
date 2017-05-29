public with sharing class quickTableHandler {
 
    public String columnFields { get; set; }
    public String soql { get; set; }
    public String columnTitles { get; set; }
 
    public List<String> columnFieldsList {
        get {
            if(columnFieldsList == null && columnFields != null) {
                columnFieldsList = columnFields.split(',');
                for(Integer x = 0; x < columnFieldsList.size(); x++) {
                    columnFieldsList[x] = columnFieldsList[x].trim();
                }
            }
            return columnFieldsList;
        }
        set;
    }
     
    public List<String> columnTitlesList {
        get {
            if(columnTitlesList == null && columnTitles != null) {
                columnTitlesList = columnTitles.split(',');
                for(Integer x = 0; x < columnTitlesList.size(); x++) {
                    columnTitlesList[x] = columnTitlesList[x].trim();
                }
            }
            return columnTitlesList;
        }
        set;
    }
 
    public List<sObject> records {
        get {
            if(records == null && soql != null) {
                records = Database.query(soql);
            }
            return records;
        }
        set;
    }
}