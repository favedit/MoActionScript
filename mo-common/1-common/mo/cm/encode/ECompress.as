package mo.cm.encode
{
   //============================================================
   // <T>压缩定义。</T>
   //============================================================
   public class ECompress
   {
      // 不压缩
      public static var None:int = 0;

      // 不压缩代码
      public static const NoneCode:String = "none";

      // Deflate压缩
      public static var Deflate:int = 1;
      
      // Deflate压缩代码
      public static const DeflateCode:String = "deflate";

      // Lzma压缩
      public static var Lzma:int = 2;
      
      // Lzma压缩代码
      public static const LzmaCode:String = "lzma";
   }
}