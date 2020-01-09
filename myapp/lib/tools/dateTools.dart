class DateTools {

  static String ConvertDateToString(int millisecondsSinceEpoch){
    String time = DateTime .fromMillisecondsSinceEpoch(millisecondsSinceEpoch).toString();
    return time.substring(0,time.lastIndexOf('.'));
  }

  static String ConvertDateToMonthDay(int millisecondsSinceEpoch){
    String time = DateTime .fromMillisecondsSinceEpoch(millisecondsSinceEpoch).toString();
    return time.substring(time.indexOf('-')+1,time.lastIndexOf('-')+3);
  }

  static String ConvertDateToYearMonthDay(int millisecondsSinceEpoch){
    String time = DateTime .fromMillisecondsSinceEpoch(millisecondsSinceEpoch).toString();
    return time.substring(0,time.lastIndexOf('-')+3);
  }
}