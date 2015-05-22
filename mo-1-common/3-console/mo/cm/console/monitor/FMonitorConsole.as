package mo.cm.console.monitor
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
   // <T>监视管理器。</T>
   //
   // @class
   // @history 121104 MAOCY 创建
   //============================================================
   public class FMonitorConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FMonitorConsole);
      
      // 显示跟踪
      public var track:Boolean = false;
      
      // 监视运行间隔
      public var interval:Number;
      
      // 监视运行工作
      public var intervalWork:Number;
      
      // 监视运行空闲
      public var intervalIdle:Number;
      
      // 监视运行时间
      public var intervalRate:Number = 1.0;
      
      // 监视列表
      public var monitors:Vector.<FMonitor> = new Vector.<FMonitor>();
      
      //============================================================
      // <T>构造监视管理器。</T>
      //============================================================
      public function FMonitorConsole(){
         name = "common.monitor.console";
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
      // <T>增加一个监视对象。</T>
      //
      // @param p:monitor 监视对象
      //============================================================
      public function start(p:IMonitor):void{
         var t:FMonitor = p as FMonitor;
         if(t){
            if(-1 == monitors.indexOf(t)){
               t.start();
               monitors.push(t);
            }else{
               RFatal.throwFatal("Current monitor is already exists. (monitor={1})", p);
            }
         }
      }
      
      //============================================================
      // <T>停止一个监视对象。</T>
      //
      // @param p:monitor 监视对象
      //============================================================
      public function stop(p:IMonitor):void{
         var t:FMonitor = p as FMonitor;
         if(t){
            var n:int = monitors.indexOf(p);
            if(-1 != n){
               t.stop();
               monitors.splice(n, 1);
            }else{
               RFatal.throwFatal("Current monitor is not exists. (monitor={1})", p);
            }
         }
      }
      
      //============================================================
      // <T>增加一个监视对象。</T>
      //
      // @param p:monitor 监视对象
      //============================================================
      public function push(p:IMonitor):void{
         var t:FMonitor = p as FMonitor;
         if(t){
            if(-1 == monitors.indexOf(t)){
               monitors.push(t);
            }else{
               RFatal.throwFatal("Current monitor is already exists. (monitor={1})", p);
            }
         }
      }
      
      //============================================================
      // <T>移除一个监视对象。</T>
      //
      // @param p:monitor 监视对象
      //============================================================
      public function remove(p:IMonitor):void{
         var n:int = monitors.indexOf(p);
         if(-1 != n){
            monitors.splice(n, 1);
         }
      }
      
      //============================================================
      // <T>处理一帧监视内容。<T>
      //============================================================
      public function process():void{
         var count:int = 0;
         // 计算可用时间
         interval = 1000 / RTimer.stageRate * intervalRate;
         //------------------------------------------------------------
         // 执行处理
         var realTick:Number = RTimer.realTick;
         var beginTick:Number = new Date().time;
         var endTick:Number = 0;
         var span:Number = 0;
         //------------------------------------------------------------
         // 处理所有监视对象 
         var c:int = monitors.length;
         for(var n:int = 0; n < c; n++){
            // 检查是否可以运行
            var t:FMonitor = monitors[n];
            if(EMonitorStatus.Processing == t.statusCd){
               // 计算时间间隔
               endTick = new Date().time;
               span = endTick - realTick;
               // _logger.debug("process", "Check monitor span. (span={1}, interval={2})", uint(span), uint(interval));
               if(span > interval){
                  break;
               }
               // 设置监视可以利用的空闲时间
               t.idleTick = interval - span;
               // 首次调用，强制执行
               t.process();
               count++;
               if(track){
                  _logger.debug("process", "Execute monitor process. (monitor={1}, tick={2})", t, t.frameTick);
               }
               RTracker.monitorCount++;
            }
         }
         //------------------------------------------------------------
         // 检查是否有结束的监视(只删除一个，剩余的等下次执行再删除)
         for(var i:int = 0; i < c; i++){
            if(EMonitorStatus.Stop == monitors[i].statusCd){
               monitors.splice(i, 1);
               break;
            }
         }
         //------------------------------------------------------------
         if(track && count){
            endTick = new Date().time;
            intervalIdle = interval - (beginTick - realTick);
            intervalWork = endTick - beginTick;
            RTracker.monitorTick = endTick - beginTick;
            _logger.debug("process", "Monitor process. (count={1}, tick={2}, spend={3}, interval={4}, useable={5})",
               count, uint(endTick - realTick), intervalWork, interval, intervalIdle);
         }
      }
      
      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public function runtime():String{
         var r:FString = new FString();
         var c:int = monitors.length;
         for(var n:int = 0; n < c; n++){
            if(n > 0){
               r.appendLine();
            }
            r.append(monitors[n]);
         }
         return r.toString();
      }
   }
}
