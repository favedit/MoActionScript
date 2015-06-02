package mo.cm.system
{
   import mo.cm.lang.RString;
   
   //============================================================
   // <T>类对象管理器。</T>
   //============================================================
   public class RClass
   {
      //============================================================
      // <T>生成对象类名。</T>
      //
      // @param p:object 对象
      // @return 类名
      //============================================================
      public static function makeClassName(p:Object):String{
         var n:String = p.constructor.toString();
         n = RString.mid(n, "[", "]");
         if(0 == n.indexOf("class ")){
            n = n.substr(6);
         }
         return n;
      }
   }
}