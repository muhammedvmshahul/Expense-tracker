// convert DateTime object to a String yyyymmdd
String convertDateTimeToString(DateTime datetime) {
// year in the format yyyy
String year = datetime.year.toString();
// month in the format mm
String month = datetime.month.toString();
    if(month.length == 1){
      month = '0$month';
    }
// day int the format dd
String day = datetime.day.toString();
    if(day.length == 1){
      day = '0$day';
    }
// final format yyyymmdd
String yyyymmdd = year + month + day;

return yyyymmdd;

}