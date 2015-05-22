package mo.cm.lang
{
   //============================================================
   // <T>时刻工具类。</T>
   //============================================================
   public class RTick
   {
      // 每小时毫秒数
      public static var tickHour:uint = 1000000 * 60 * 60;
      
      // 每分钟毫秒数
      public static var tickMinute:uint = 1000000 * 60;
      
      // 每秒毫秒数
      public static var tickSecond:uint = 1000000;
      
      //============================================================
      // <T>构造时刻工具类。</T>
      //============================================================
      public function RTick(){
      }
      
      //============================================================
      // <T>格式化时刻字符串。</T>
      //
      // @param p:value 时刻
      // @return 字符串
      //============================================================
      public static function format(p:int):String{
         var ms:String = RInteger.lpad((p / 10000) % 100, 2);
         var ss:String = RInteger.lpad((p / tickSecond) % 60, 2);
         var mi:String = RInteger.lpad((p / tickMinute) % 60, 2);
         var hs:String = RInteger.lpad((p / tickHour), 2);
         return hs + ":" + mi + ":" + ss + "." + ms;
      }
   }
}