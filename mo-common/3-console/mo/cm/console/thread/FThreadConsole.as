package mo.cm.console.thread
{
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FString;
   import mo.cm.logger.RLogger;
   import mo.cm.logger.RTracker;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>线程管理器。</T>
   // <P>线程为运行一次，管理器会计算时间花费</P>
   // <P>线程运行一次，管理器会计算时间花费</P>
   // <P>如果返回处理中，如果负荷满足，管理器会在一个函数中重新调用，</P>
   //
   // @class
   // @history 110814 MAOCY 创建
   //============================================================
   public class FThreadConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FThreadConsole);
      
      // 线程时刻限制
      public static var limitTick:int = 6;
      
      // 显示跟踪
      public var track:Boolean = false;
      
      // 线程运行间隔
      public var interval:Number;
      
      // 线程运行工作
      public var intervalWork:Number;
      
      // 线程运行空闲
      public var intervalIdle:Number;
      
      // 线程运行时间
      public var intervalRate:Number = 0.6;
      
      // 线程列表
      public var threads:Vector.<FThread> = new Vector.<FThread>();
      
      //============================================================
      // <T>构造线程管理器。</T>
      //============================================================
      public function FThreadConsole(){
         name = "common.thread.console";
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         if(p.contains("interval_rate")){
            intervalRate = p.getNumber("interval_rate");
         }
      }
      
      //============================================================
      // <T>增加一个线程对象。</T>
      //
      // @param p:thread 线程对象
      //============================================================
      public function start(p:IThread):void{
         var t:FThread = p as FThread;
         if(t){
            if(-1 == threads.indexOf(t)){
               t.start();
               threads.push(t);
            }else if(EThreadStatus.Processing != t.statusCd){
               t.start();
            }else{
               RFatal.throwFatal("Current thread is already exists. (thread={1})", p);
            }
         }
      }
      
      //============================================================
      // <T>停止一个线程对象。</T>
      //
      // @param p:thread 线程对象
      //============================================================
      public function stop(p:IThread):void{
         var t:FThread = p as FThread;
         if(t){
            if(EThreadStatus.Stop != t.statusCd){
               var n:int = threads.indexOf(p);
               if(-1 != n){
                  t.stop();
               }else{
                  RFatal.throwFatal("Current thread is not exists. (thread={1})", p);
               }
            }
         }
      }
      
      //============================================================
      // <T>增加一个线程对象。</T>
      //
      // @param p:thread 线程对象
      //============================================================
      public function push(p:IThread):void{
         var t:FThread = p as FThread;
         if(t){
            if(-1 == threads.indexOf(t)){
               threads.push(t);
            }else{
               RFatal.throwFatal("Current thread is already exists. (thread={1})", p);
            }
         }
      }
      
      //============================================================
      // <T>移除一个线程对象。</T>
      //
      // @param p:thread 线程对象
      //============================================================
      public function remove(p:IThread):void{
         var n:int = threads.indexOf(p);
         if(-1 != n){
            threads.splice(n, 1);
         }
      }
      
      //============================================================
      // <T>处理一帧线程内容。<T>
      //============================================================
      public function process():void{
         var count:int = 0;
         // 计算可用时间
         interval = 1000 / RTimer.stageRate * intervalRate;
         //------------------------------------------------------------
         // 执行处理
         var first:Boolean = true;
         var firstCheck:Boolean = false;
         var realTick:Number = RTimer.realTick;
         var beginTick:Number = RTimer.makeRealTick();
         var endTick:Number = 0;
         var tc:int = threads.length;
         while(true){
            endTick = 0;
            var process:Boolean = false;
            var span:Number = 0;
            //------------------------------------------------------------
            // 处理所有线程对象 
            for(var n:int = 0; n < tc; n++){
               // 检查是否可以运行
               var t:FThread = threads[n];
               if(EThreadStatus.Processing == t.statusCd){
                  // 计算时间间隔
                  endTick = RTimer.makeRealTick();
                  span = endTick - realTick;
                  // _logger.debug("process", "Check thread span. (span={1}, interval={2})", uint(span), uint(interval));
                  if(firstCheck && (span > interval)){
                     process = false;
                     break;
                  }
                  // 设置线程可以利用的空闲时间
                  t.idleTick = interval - span;
                  if(first){
                     // 首次调用，强制执行
                     t.countCurrent = 0;
                     if(RLogger.debugAble){
                        var startTick:Number = RTimer.makeRealTick();
                     }
                     t.processFirst();
                     process = true;
                     count++;
                     if(RLogger.debugAble){
                        var stopTick:Number = RTimer.makeRealTick();
                        var tick:uint = uint(stopTick - startTick);
                        if(track){
                           //_logger.debug("process", "Execute thread process. (thread={1}, result={2}, tick={3})", t, t.result, tick);
                        }
                     }
                     RTracker.threadCount++;
                  }else if(!t.result){
                     // 计算时间间隔
                     endTick = RTimer.makeRealTick();
                     span = endTick - realTick;
                     // _logger.debug("process", "Check thread span. (span={1}, interval={2})", uint(span), uint(interval));
                     if(span > interval){
                        process = false;
                        break;
                     }
                     // 再次调用，根据结果调用
                     if(RLogger.debugAble){
                        startTick = RTimer.makeRealTick();
                     }
                     t.process();
                     process = true;
                     count++;
                     if(RLogger.debugAble){
                        stopTick = RTimer.makeRealTick();
                        tick = uint(stopTick - startTick);
                        if(track && tick){
                           //_logger.debug("process", "Execute thread process. (thread={1}, result={2}, tick={3})", t, t.result, tick);
                        }
                     }
                  }
                  // 单次处理计数，超过最大限制禁止执行
                  if(t.countCurrent >= t.countMax){
                     t.result = true;
                  }
               }
            }
            //------------------------------------------------------------
            // 检查是否有结束的线程(只删除一个，剩余的等下次执行再删除)
            for(var i:int = 0; i < tc; i++){
               t = threads[i];
               if(EThreadStatus.Stop == t.statusCd){
                  threads.splice(i, 1);
                  _logger.debug("process", "Remove thread. (thread={1})", t);
                  break;
               }
            }
            //------------------------------------------------------------
            // 开始循环结束
            if(!process){
               break;
            }
            first = false;
         }
         //------------------------------------------------------------
         // 输出调试信息
         if(RLogger.debugAble && track){
            endTick = RTimer.makeRealTick();
            intervalIdle = interval - (beginTick - realTick);
            intervalWork = endTick - beginTick;
            RTracker.threadTick = endTick - beginTick;
            //------------------------------------------------------------
            var lc:int = 0;
            for(n = 0; n < tc; n++){
               t = threads[n];
               var ft:Number = t.currentFrameTotal;
               lc += t.countCurrent;
               if(t.testBusy()){
                  _logger.debug("process", "Process thread busy. (thread={1})", t);
               }
            }
            //------------------------------------------------------------
            if(track && count){
               _logger.debug("process", "Thread process. (thread_count={1}, execute_count={2}, valid_tick={3}, useable_tick={4}, spend_tick={5}, span={6})",
                     tc, lc, int(interval), int(endTick - realTick), int(endTick - beginTick), int(intervalIdle));
            }
         }
      }
      
      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public function runtime():String{
         var r:FString = new FString();
         var c:int = threads.length;
         for(var n:int = 0; n < c; n++){
            if(n > 0){
               r.appendLine();
            }
            r.append(threads[n]);
         }
         return r.toString();
      }
   }
}