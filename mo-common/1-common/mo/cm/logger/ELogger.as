package mo.cm.logger
{
   public class ELogger
   {
      public static const Output:int = 0x00;
      
      public static const Debug:int = 0x01;
      
      public static const Info:int = 0x02;
      
      public static const Warn:int = 0x03;
      
      public static const Error:int = 0x04;
      
      public static const Fatal:int = 0x05;
      
      //============================================================
      public static function toSimple(value:int):String{
         switch(value){
            case Debug:
               return "D";
            case Info:
               return "I";
            case Warn:
               return "W";
            case Error:
               return "E";
            case Fatal:
               return "F";
         }
         return "O";
      }
   }
}