package mo.cm.console.resource
{
   //============================================================
   // <T>资源类型定义。</T>
   //============================================================
   public class EResourceTimeout
   {
      // 资源组
      public static const None:int = 0;
      
      // 内容(SWF)
      public static const Short:int = 1;
      
      // 图片类型
      public static const Middle:int = 2;
      
      // 图片类型
      public static const Long:int = 3;
      
      //============================================================
      public static function parse(value:int):int{
         switch(value){
            case None:
               return 0;
            case Short:
               return 5000;
            case Middle:
               return 10000;
            case Long:
               return 20000;
         }
         return 0;
      }
   }
}