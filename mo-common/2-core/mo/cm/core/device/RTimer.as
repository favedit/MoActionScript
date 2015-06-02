package mo.cm.core.device
{
   import flash.display.Sprite;
   import flash.display.Stage;
   
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>游戏时间。</T>
   //============================================================
   public class RTimer
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(RTimer);
      
      // 修正时刻
      public static var paused:Boolean; 

      // 修正时刻
      public static var fixTick:Number = 0; 

      // 暂停时刻
      public static var pauseTick:Number = 0; 
      
      // 开始时间
      public static var startDate:Date;
      
      // 开始时刻
      public static var startTick:Number = 0; 

      // 真正时刻
      public static var realTick:Number = 0; 
      
      // 假设时刻
      public static var pendingTick:Number = 0; 

      // 当前时间
      public static var currentDate:Date; 
      
      // 当前时刻 (根据暂停会做修正)
      public static var currentTick:Number = 0;

      // 当前播放比率
      public static var currentPlayRate:Number = 1;

      // 当前播放时刻
      public static var currentPlayTick:Number = 0;

      // 最后时间
      public static var lastDate:Date; 
      
      // 最后时刻
      public static var lastTick:Number = 0;
      
      // 总共时间间隔
      public static var totalTick:Number = 0;
      
      // 桢时刻
      public static var frameTick:Number = 0;
      
      // 桢间隔集合
      public static var frameTicks:Vector.<Number> = new Vector.<Number>(8); 
      
      // 桢间隔
      public static var frameTime:Number = 0;
      
      // 桢总数
      public static var frameCount:int;
      
      // 平均间隔
      public static var averageTick:Number = 0;

      // 平均秒间隔
      public static var averageTime:Number = 0;

      // 系统间隔
      public static var stageTick:Number = 0;
      
      // 系统频率
      public static var stageRate:Number = 24;

      // 时钟重置
      public static var stageReset:Boolean = false;

      // 倍率标志
      public static var rateFlag:Boolean;
      
      // 倍率最后时刻
      public static var rateLastTick:Number = 0;
      
      // 倍率时刻
      public static var rateTick:Number = 0;
      
      // 倍率间隔
      public static var rateSpan:Number = 0;
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setup(p:Sprite):void{
         setupStage(p.stage);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setupStage(p:Stage):void{
         var d:Date = new Date();
         startDate = d;
         startTick = d.time;
         realTick = d.time;
         currentDate = d;
         currentTick = d.time; 
         lastDate = d; 
         lastTick = lastDate.time; 
         totalTick = 0;
         frameTick = 0; 
         frameTime = 0; 
         frameCount = 0;
         averageTick = 0;
         averageTime = 0;
         var c:int = frameTicks.length
         for(var n:int = 0; n < c; n++){
            frameTicks[n] = 0;
         }
         if(p){
            stageRate = p.frameRate;
         }else{
            stageRate = RGlobal.frameRate;
         }
      }
      
      //============================================================
      // <T>暂停时间。</T>
      //============================================================
      public static function pause():void{
         paused = true;
         pauseTick = new Date().time;
      }
      
      //============================================================
      // <T>继续时间。</T>
      //============================================================
      public static function resume():void{
         paused = false;
         var t:Number = new Date().time;
         fixTick += t - pauseTick;
      }
      
      //============================================================
      // <T>获得当前时刻。</T>
      //
      // @return 时刻
      //============================================================
      public static function getTick():Number{
         return new Date().time;
      }
      
      //============================================================
      // <T>获得真实当前时刻。</T>
      //
      // @return 时刻
      //============================================================
      public static function makeRealTick():Number{
         return new Date().time - pendingTick;
      }
      
      //============================================================
      // <T>获得每秒帧率。</T>
      //
      // @return 帧率
      //============================================================
      public static function get frameRate():int{
         var t:Number = new Date().time - startTick;
         return (1000 * frameCount / t);
      }

      //============================================================
      // <T>开始倍速计时器。</T>
      //
      // @param p:rate 比率
      //============================================================
      public static function startRate(p:Number):void{
         if(p < 1){
            p = 1;
         }
         if(1 == p){
            endRate();
         }else{
            p -= 1;
            // 设置数值
            rateLastTick = new Date().time;
            rateTick = rateLastTick;
            currentPlayRate = p;
            rateFlag = true;
         }
      }
      
      //============================================================
      // <T>结束倍速计时器。</T>
      //============================================================
      public static function endRate():void{
         if(0 != rateLastTick){
            rateSpan += (new Date().time - rateLastTick) * currentPlayRate;
            currentPlayRate = 1;
         }
         rateLastTick = 0;
         rateFlag = false;
      }

      //============================================================
      // <T>充值速计时器。</T>
      //============================================================
      public static function resetRate():void{
         rateSpan = 0;
         rateFlag = false;
      }
      
      //============================================================
      // <T>更新时间。</T>
      //============================================================
      public static function update():void{
         // 设置间隔
         var s:Stage =  RScreen.stage;
         if(null != s){
            stageTick = 1 / s.frameRate;
         }
         // 更新最后时间
         lastDate = currentDate;
         lastTick = lastDate.getTime();
         // 计算当前时间
         currentDate = new Date();
         rateTick = currentDate.time;
         var rt:Number = currentDate.time - pendingTick;
         if(rt < realTick){
            // 时间向前认为时钟异常，修正时钟
            RGlobal.socketAuto = false;
            stageReset = true;
            if(realTick > 0){
               pendingTick += (rt - realTick);
            }else{
               pendingTick = 0;
            }
         }
         realTick = rt - pendingTick;
         var ft:Number = fixTick;
         if(paused){
            ft += realTick - pauseTick;
         }
         currentTick = realTick - ft;
         // 计算播放值
         if(rateFlag){
            currentPlayTick = currentTick + rateSpan + (rateTick - rateLastTick) * currentPlayRate;
         }else{
            currentPlayTick = currentTick + rateSpan;
         }
         // 计算差值
         totalTick = currentTick - startTick;
         frameTick = currentTick - lastTick;
         frameTime = frameTick / 1000;
         frameCount++;
         // 计算平均帧数
         var total:Number = 0;
         var c:int = frameTicks.length
         for(var n:int = 1; n < c; n++){
            total += frameTicks[n];
            frameTicks[n - 1] = frameTicks[n];
         }
         total += frameTick;
         frameTicks[c - 1] = frameTick;
         // averageTick = total / c;
         averageTick = frameTick;
         averageTime = averageTick / 1000;
         // _logger.debug("update", "Update ticker. (current={1}({2} - {3}), last_tick={4}({5} - {6}), frame_tick={7})",
         //    currentDate, currentTick, currentDate.time, lastDate, lastTick, lastDate.time, frameTick);
      }
   }
}