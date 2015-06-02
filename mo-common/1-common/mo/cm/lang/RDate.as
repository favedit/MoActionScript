package mo.cm.lang
{   
   //============================================================
   // <T>日期时间工具类。</T>
   //============================================================
   public class RDate
   {
      // 每小时毫秒数
      public var tickHour:uint = 1000 * 60 * 60;
      
      // 每分钟毫秒数
      public var tickMinute:uint = 1000 * 60;
      
      // 每秒毫秒数
      public var tickSecond:uint = 1000;
      
      //============================================================
      // <T>构造日期时间工具类。</T>
      //============================================================
      public function RDate(){
      }
      
      //============================================================
      // <T>获得当前时间</T>
      //
      // @return 当前时间
      //============================================================
      public static function now():Date {
         return new Date();
      }
      
      //============================================================
      // <T>格式化时间成指定格式。</T>
      //
      // @param date 时间
      // @param foramt 格式
      // @return 格式化后字符串
      //============================================================
      public static function format(date:Date, format:String):String {
         format = format.replace("YYYY", RInteger.lpad(date.fullYear, 4));
         format = format.replace("YY", RInteger.lpad(date.fullYear % 100, 2));
         format = format.replace("MM", RInteger.lpad(date.month + 1, 2));
         format = format.replace("DD", RInteger.lpad(date.date, 2));
         format = format.replace("HH24", RInteger.lpad(date.hours, 2));
         format = format.replace("MI", RInteger.lpad(date.minutes, 2));
         format = format.replace("SS", RInteger.lpad(date.seconds, 2));
         format = format.replace("MS", RInteger.lpad(date.milliseconds, 3));
         return format;
      }
      
      //============================================================
      // <T>格式化时间成指定格式。</T>
      //
      // @param date 时间
      // @param foramt 格式
      // @return 格式化后字符串
      //============================================================
      public static function getTime(time:Number, format:String):String {
         var date:Date = new Date();
         date.setTime(time);
         return RDate.format(date, format);
      }
      
      //============================================================
      // <T>格式化时间成指定格式。</T>
      //
      // @param date 时间
      // @param foramt 格式
      // @return 格式化后字符串
      //============================================================
      public static function parse(time:Number, format:String="HH:MI:SS", isLocal:Boolean=false):String {
         var hour:uint = time/(1000 * 60 * 60);
         time -= hour * 1000 * 60 * 60;
         var minute:uint = time/(1000 * 60);
         time -= minute * 1000 * 60;
         var second:uint = time/1000;
         switch(format){
            case "HH":
               if(!isLocal){
                  return hour + "";
               }else{
                  return hour + "小时";
               }
            case "HH:MI":
               if(!isLocal){
                  return RString.lpad(hour.toString(), 2, "0") + ":" + RString.lpad(minute.toString(), 2, "0");
               }else{
                  return hour + "小时" + minute + "分";
               }
            case "HH:MI:SS":
               if(!isLocal){
                  return RString.lpad(hour.toString(), 2, "0") + ":" + RString.lpad(minute.toString(), 2, "0") + ":" + RString.lpad(second.toString(), 2, "0");
               }else{
                  return hour + "小时" + minute + "分钟"+second+"秒";
               }
            case "DD:HH:MI:SS":
               var day:uint = hour/24;
               hour %= 24;
               if(!isLocal){
                  return RString.lpad(day.toString(), 2, "0") + ":" + RString.lpad(hour.toString(), 2, "0") + ":" + RString.lpad(minute.toString(), 2, "0") + ":" + RString.lpad(second.toString(), 2, "0");
               }else{
                  return day + "天" + hour + "时" + minute + "分"+second+"秒";
               }
            case "MI:SS":
               minute = time/(60);
               time -= minute * 60;
               if(!isLocal){
                  return RString.lpad(minute.toString(), 2, "0") + ":" + RString.lpad(time.toString(), 2, "0");
               }else{
                  return hour + "分钟" + minute + "秒";
               }
         }
         return null;
      }
   }  
}