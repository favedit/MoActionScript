package mo.cr.console.queue
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   
   //============================================================
   // <T>队列管理器。</T>
   //============================================================
   public class FCrQueueConsole extends FConsole
   {
      public var threadProcess:FCrQueueProcessThread = new FCrQueueProcessThread();

      public var threadPop:FCrQueuePopThread = new FCrQueuePopThread();
      
      //============================================================
      // <T>构造队列管理器。</T>
      //============================================================
      public function FCrQueueConsole(){
         name = "core.queue.console";
      }
      
      //============================================================
      // <T>初始化信息。</T>
      //============================================================
      public function initialize():void{
         RCmConsole.threadConsole.start(threadProcess);
         RCmConsole.threadConsole.start(threadPop);
      }
      
      //============================================================
      // <T>加入队列。</T>
      //============================================================
      public function push(p:FCrQueue):void{
//         var r:Object = RCrLibrary.native.queueConsole.push(p);
//         if(r){
//            RFatal.throwFatal("Push queue failure.");
//         }
      }
   }
}