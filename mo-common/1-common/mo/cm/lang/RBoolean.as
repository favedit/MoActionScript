package mo.cm.lang
{
   //============================================================
   // <T>布尔工具。</T>
   //============================================================
   public class RBoolean
   {
      //============================================================
      // <T>判断字符串是否为真。</T>
      //
      // @param value 字符串
      // @return 是否为真
      //============================================================
      public static function isTrue(p:String):Boolean{
         p = p.toLowerCase();
         return ("1" == p || "y" == p || "t" == p || "true" == p);
      }
   }
}