package mo.cm.lang
{
   //============================================================
   // <T>对象工具类。</T>
   //============================================================
   public class RObject
   {
      // 哈希序列
      public static var code:int = 0;
      
      //============================================================
      // <T>获得下个序列。</T>
      //============================================================
      public static function next():int{
         return ++code;
      }
      
      //============================================================
      // <T>获得对象字符串。</T>
      //
      // @param p:object 对象
      // @return 字符串
      //============================================================
      public static function toString(p:FObject):String{
         if(null != p){
            var v:Object = p; 
            var n:String = v.constructor.toString();
            n = RString.mid(n, "[", "]");
            if(0 == n.indexOf("class ")){
               n = n.substr(6);
            }
            return n + "@" + p.hashCode;
         }
         return "@null";
      }
   }
}