package mo.cr.console.worker
{
   import mo.cm.core.common.FConsole;
   import mo.cm.lang.FSet;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>工作控制台。</T>
   //============================================================
   public class FCrWorkerConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrWorkerConsole);

      // 工作器集合
      public var workersSet:FSet = new FSet(); 
      
      //============================================================
      // <T>构造工作控制台。</T>
      //============================================================
      public function FCrWorkerConsole(){
         name = "core.worker.console";
      }
      
      //============================================================
      // <T>注册一个工作器。</T>
      //
      // @param p:worker 工作器
      //============================================================
      public function registerWorker(p:FCrWorker):void{
         var t:int = p.typeCd;
         // 获得工作器集合
         var ws:Vector.<FCrWorker> = workersSet.get(t);
         if(null == ws){
            ws = new Vector.<FCrWorker>();
            workersSet.set(t, ws);
         }
         // 推入工作器
         if(-1 == ws.indexOf(p)){
            ws.push(p);
         }
      }

      //============================================================
      // <T>收集一个工作器。</T>
      //
      // @param p:type 类型
      // @return 工作器
      //============================================================
      public function allocWorker(p:int):FCrWorker{
         var ws:Vector.<FCrWorker> = workersSet.get(p);
         if(null != ws){
            var c:int = ws.length;
            for(var n:int = 0; n < c; n ++){
               var w:FCrWorker = ws[n];
               if(!w.busy){
                  return w;
               }
            }
         }
         return null;
      }
   }
}