package mo.cm.console.resource
{
   //============================================================
   // <T>资源类型信息。</T>
   //============================================================
   public class SResourceTypeInfo
   {
      // 可用个数
      public var readyCount:int;
      
      // 总数
      public var count:int;

      // 字节总数
      public var totalBytes:int;

      // 内存总数
      public var memoryBytes:int;

      // 实际总数
      public var memoryRealBytes:int;

      // 压缩总数
      public var compressBytes:int;

      //============================================================
      // <T>构造资源类型信息。</T>
      //============================================================
      public function SResourceTypeInfo(){
      }
   
      //============================================================
      // <T>重置数据。</T>
      //============================================================
      public function reset():void{
         readyCount = 0;
         count = 0;
         totalBytes = 0;
         memoryBytes = 0;
         compressBytes = 0;
      }
   }
}