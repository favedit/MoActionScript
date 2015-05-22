package mo.cm.console.memory
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>内存控制台。</T>
   //============================================================
   public class FMemoryConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FMemoryConsole);
      
      // 内存监视线程
      public var thread:FMemoryInterval = new FMemoryInterval();
      
      //============================================================
      // <T>构造资源控制台。</T>
      //============================================================
      public function FMemoryConsole(){
         name = "common.memory.console";
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         super.setup();
         RCmConsole.threadConsole.start(thread);
      }
   }
}