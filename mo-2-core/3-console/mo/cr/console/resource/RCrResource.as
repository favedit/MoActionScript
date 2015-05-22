package mo.cr.console.resource
{
   import flash.display.BitmapData;

   //============================================================
   // <T>资源工具类。</T>
   //============================================================
   public class RCrResource
   {
      // SHA校验长度
      public static const ShaLength:int = 20;
      
      // 解压限制像素
      public static var LimitPixel:int = 18000;

      // 解压限制时间
      public static var LimitTimeout:int = 3;

      // 位图提供商
      public static var vendor:ICrBitmapVendor = new FCrBitmapVendor();
      
      // 空位图对象
      public static var emptyBitmapData:BitmapData = new BitmapData(1, 1, true, 0);
   }
}