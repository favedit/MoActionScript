package mo.cm.console.loader
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>加载信息。</T>
   //============================================================
   public class FLoaderInfo extends FObject
   {
      // 已经加载字节数
      public var count:int = 0;

      // 已经加载字节数
      public var totalBytes:int = 0;
      
      // 已经加载时刻
      public var totalTick:int = 0;
      
      //============================================================
      // <T>构造加载信息。</T>
      //============================================================
      public function FLoaderInfo(){
      }
      
      //============================================================
      // <T>获得每秒加载速度。</T>
      //
      // @return 速度
      //============================================================
      public function get speedBytes():int{
         var r:Number = totalBytes / totalTick;
         return r * 1000;
      }

      //============================================================
      // <T>加载处理。</T>
      //
      // @param pb:byte 字节数
      // @param pt:tick 时刻
      //============================================================
      public function load(pb:int, pt:int = 0):void{
         count += 1;
         totalBytes += pb;
         totalTick += pt;
      }

      //============================================================
      // <T>获得信息字符串。</T>
      //
      // @return  字符串
      //============================================================
      public function dump():String{
         return totalBytes + "/" + count + " " + totalTick;
      }
   }
}