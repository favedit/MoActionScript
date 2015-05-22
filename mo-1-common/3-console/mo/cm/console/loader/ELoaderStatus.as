package mo.cm.console.loader
{
   //============================================================
   // <T>加载状态。</T>
   //============================================================
   public class ELoaderStatus
   {
      // 未知
      public static const Unknown:int = 0;
      
      // 加载
      public static const Load:int = 1;

      // 打开
      public static const Open:int = 2;

      // 完成
      public static const Complete:int = 3;
      
      // 流错误
      public static const IoError:int = 4;
      
      // 权限错误
      public static const SecurityError:int = 5;
      
      //============================================================
      // <T>获得状态字符串。</T>
      //
      // @param p:statusCd 状态
      // @return 字符串
      //============================================================
      public static function toString(p:int):String{
         switch(p){
            case Load:
               return "load";
            case Open:
               return "open";
            case Complete:
               return "complete";
            case IoError:
               return "error.io";
            case SecurityError:
               return "error.security";
         }
         return "unknown";
      }
   }
}