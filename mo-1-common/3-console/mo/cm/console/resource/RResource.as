package mo.cm.console.resource
{
   //============================================================
   // <T>资源管理。</T>
   //============================================================
   public class RResource
   {
      // SHA长度
      public static const SHA_LENGTH:int = 20;
      
      // 索引图片总数
      public static var PictureIndexCount:int = 0;
      
      // 分块索引图片总数
      public static var PictureBlockIndexCount:int = 0;
      
      // JPG图片总数
      public static var PictureJpgCount:int = 0;
      
      // 资源路径设置
      public static var sourcePath:String = "/rs";
      
      // 资源校验
      public static var optionVerify:Boolean = false;
      
      // 资源组设置
      public static var optionGroup:Boolean = false;
      
      // 资源块设置
      public static var optionBlock:Boolean = false;
      
      // 传输设置
      public static var optionTransfer:Boolean = false;
      
      // 资源释放
      public static var optionTimeout:Boolean = true;
      
      // 资源压缩
      public static var optionCompress:Boolean = false;
      
      // 资源持久化
      public static var optionPersistence:Boolean = false;
      
      // 资源格式
      public static var optionLzma:Boolean = false;
      
      // 压缩超时
      public static var compressTimeout:Number = 5000;
      
      // 处理像素限制
      public static var processPixelLimit:int = 1024 * 1024;
      
      // 处理像素当前
      public static var processPixelCurrent:int = 0;
      
      //============================================================
      // <T>处理重置。</T>
      //============================================================
      public static function processReset():void{
         processPixelCurrent = processPixelLimit;
      }
      
      //============================================================
      // <T>处理测试。</T>
      //============================================================
      public static function processTest():Boolean{
         return (processPixelCurrent > 0);
      }
      
      //============================================================
      // <T>处理像素。</T>
      //============================================================
      public static function processPixel(p:int):void{
         processPixelCurrent -= p;
      }
   }
}