package mo.cm.console.loader
{
   //============================================================
   // <T>加载器。</T>
   //============================================================
   public class ELoader
   {
      // 未知文件
      public static const Unknown:int = 0;
      
      // 设置加载器（XML内容）
      public static const Config:int = 1;
      
      // 内容加载器（图片内容）
      public static const Info:int = 2;
      
      // 数据加载器（二进制内容）
      public static const Data:int = 3;
      
      //============================================================
      public static function parseSimple(type:String):int{
         switch(type){
            case "x":
               return Config;
            case "b":
               return Data;
            case "i":
               return Info;
         }
         return Unknown;
      }
   }
}