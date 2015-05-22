package mo.cr.console.process
{
   import mo.cm.console.loader.FUrlLoader;
   import mo.cm.system.FListeners;

   //============================================================
   // <T>进程加载器。</T>
   //============================================================
   public class FProcessLoader extends FUrlLoader
   {
      // 代码
      public var code:String;

      // 总数
      public var count:int;
      
      // 完成监听列表
      public var lsnsReady:FListeners;

      //============================================================
      // <T>构造进程加载器。</T>
      //============================================================
      public function FProcessLoader(){
         lsnsReady = new FListeners(this);
      }
   }
}