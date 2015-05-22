package mo.cm.console.loader
{
   import mo.cm.console.thread.FThread;
   
   //============================================================
   // <T>加载器处理线程。</T>
   //============================================================
   public class FNetLoaderThread extends FThread
   {
      public var console:FNetLoaderConsole;
      
      //============================================================
      // <T>构造加载器处理线程。</T>
      //============================================================
      public function FNetLoaderThread(){
         name = "core.net.loader.thread";
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return true:处理已经完毕
      //         false:处理未完成，如果还有空闲时间，继续执行
      //============================================================
      public override function execute():Boolean{
         return console.process();
      }
   }
}