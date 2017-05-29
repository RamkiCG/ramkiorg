public with sharing class OppRevChartController
 {
    List<OpportunityStage> lstOppStages = [Select SortOrder,MasterLabel,IsActive From OpportunityStage Where IsActive=true Order by SortOrder];
    public List<String> lstStages {
        get {
            List<String> lstStages = new List<String>();
            for (OpportunityStage stg : lstOppStages) {
                lstStages.add(stg.MasterLabel);
            } 
            return lstStages;   
        }
    }                                   

    public String stagenameslist {
        get {           
            return String.join(lstStages, ',');
        }
    }
    
    public String listOfFieldNames {
        get {
            String str = '';
            for (Integer i=0; i<lstStages.size(); i++) {
                if (str != '') str += ',' + 'data' + (i);
                else str += 'data' + (i);
            }
            return str;
        }
    }

    public List<OppData> getOppData() {
        
        String month;
        OppData opp;
                
        AggregateResult[] oppResults = [Select CALENDAR_MONTH(CreatedDate) n, StageName stg, sum(Amount) num From Opportunity Where  CreatedDate=THIS_YEAR group by CALENDAR_MONTH(CreatedDate), StageName order by CALENDAR_MONTH(CreatedDate)];
        
        List<OppData> lstoppdata = new List<OppData>(); // create a list for OppData object, which we will use for Opp Revenue stacked bar graph
                
        for (AggregateResult ar : oppResults) {
            
            if (month != String.valueof(ar.get('n'))) {
                // get ready to start new OppData
                if (opp != null)    lstoppdata.add(opp);
                month = String.valueof(ar.get('n'));
                opp = new OppData(month, lstStages);    
            }
                
            opp.addNumForStage(Integer.valueOf(ar.get('num')), String.valueof(ar.get('stg')));  
        }
        if (opp != null) lstoppdata.add(opp);

        return lstoppdata;
    }
    
    // OppData object
    public class OppData {
        // fields of OppData object
        public String  name  {get; set;} // name of the month
        public Integer data0 {get; set;} // data for sum of amount in each stage
        public Integer data1 {get; set;}
        public Integer data2 {get; set;}
        public Integer data3 {get; set;}
        public Integer data4 {get; set;}
        public Integer data5 {get; set;}
        public Integer data6 {get; set;}
        public Integer data7 {get; set;}
        public Integer data8 {get; set;}
        public Integer data9 {get; set;}
        public Integer data10 {get; set;}
        public Integer data11 {get; set;}
        public Integer data12 {get; set;}
        public Integer data13 {get; set;}
        public Integer data14 {get; set;}
        public Integer data15 {get; set;}
        public Integer data16 {get; set;}
        public Integer data17 {get; set;}
        public Integer data18 {get; set;}
        public Integer data19 {get; set;}
        public Integer data20 {get; set;}
        public List<String>  lstStgs {get; set;} // a list of all opportunity stages
        
        public OppData (String name, List<String> lstStgs) {
            if (name=='1') this.name = 'Jan'; // translate Opportunity CreatedDate Month from Number to String
            else if (name=='2') this.name = 'Feb';
            else if (name=='3') this.name = 'Mar';
            else if (name=='4') this.name = 'Apr';
            else if (name=='5') this.name = 'May';
            else if (name=='6') this.name = 'Jun';
            else if (name=='7') this.name = 'Jul';
            else if (name=='8') this.name = 'Aug';
            else if (name=='9') this.name = 'Sep';
            else if (name=='10') this.name = 'Oct';
            else if (name=='11') this.name = 'Nov';
            else if (name=='12') this.name = 'Dec';
            this.lstStgs = lstStgs;
            this.data0=0;
            this.data1=0;
            this.data2=0;
            this.data3=0;
            this.data4=0;
            this.data5=0;
            this.data6=0;
            this.data7=0;
            this.data8=0;
            this.data9=0;
            this.data10=0;
            this.data11=0;
            this.data12=0;
            this.data13=0;
            this.data14=0;
            this.data15=0;
            this.data16=0;
            this.data17=0;
            this.data18=0;
            this.data19=0;
            this.data20=0;
        }
        
        public void addNumForStage (Integer num, String stg) {
            for (Integer i=0; i<lstStgs.size(); i++) {
                // assign SUM(Amount) or num from the aggregated results to the data fields
                // based on the order of the Stage name on the lstStgs
                if (lstStgs[i] == stg) {
                    System.debug('===== found status');
                    if (i==0) data0 = num;
                    else if (i==1) data1 = num;
                    else if (i==2) data2 = num;
                    else if (i==3) data3 = num;
                    else if (i==4) data4 = num;
                    else if (i==5) data5 = num;
                    else if (i==6) data6 = num;
                    else if (i==7) data7 = num;
                    else if (i==8) data8 = num;
                    else if (i==9) data9 = num;
                    else if (i==10) data10 = num;
                    else if (i==11) data11 = num;
                    else if (i==12) data12 = num;
                    else if (i==13) data13 = num;
                    else if (i==14) data14 = num;
                    else if (i==15) data15 = num;
                    else if (i==16) data16 = num;
                    else if (i==17) data17 = num;
                    else if (i==18) data18 = num;
                    else if (i==19) data19 = num;
                    else if (i==20) data20 = num;
                    return;
                }
            }
        }
        
    }
}