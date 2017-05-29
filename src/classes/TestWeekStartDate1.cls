public class TestWeekStartDate1
{

 public static datetime getStartDate(integer year,integer weeknumber)
 {
 Integer addWkDays=0;
    // Date yearStartDate= Date.newInstance(year, 1, 1);
      datetime yearStartDate= Date.newInstance(year, 1, 1);
     String dayOfWeek2=yearStartDate.format('EEEE');
     if(dayOfWeek2 ==  'Monday')
     {
     addWkDays=1;
     }
     else if(dayOfWeek2=='Tuesday')
     {
       addWkDays=2;
     }
       else if(dayOfWeek2=='Wednesday')
     {
       addWkDays=3;
     }
       else if(dayOfWeek2=='Thursday')
     {
       addWkDays=4;
     }
       else if(dayOfWeek2=='Friday')
     {
       addWkDays=5;
     }
       else if(dayOfWeek2=='Saturday')
     {
       addWkDays=6;
     }
     else
     {
     addWkDays=0;
     }
   System.debug('addWkDays: ' + addWkDays);
     
    System.debug('Day : ' + dayOfWeek2);
   // Date mydate = Date.newInstance(selectedYear,01,01); 
//Datetime dt = DateTime.newInstance(mydate, Time.newInstance(0, 0, 0, 0));
//String dayOfWeek=dt.format('d'); 
  
   datetime yearwkStartDate=yearStartDate.adddays(weeknumber*7);
  
    Date weekStart = yearwkStartDate.date().toStartofWeek();
      Date weekend =weekStart.adddays(6);
     System.debug('weekStart : ' + weekStart );
   System.debug('weekend : ' + weekend );
    return yearStartDate;
 }
 
 
}