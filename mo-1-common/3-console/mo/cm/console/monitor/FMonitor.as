package mo.cm.console.monitor
{
   import mo.cm.console.thread.EThreadStatus;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RTracker;
   
   //============================================================
   // <T>监视处理基类。</T>
   //============================================================
   public class FMonitor extends FObject implements IMonitor
   {
      // 名称
      public var name:String;
      
      // 运行状态
      public var statusCd:int;
      
      // 可用空闲时刻
      public var idleTick:Number;
      
      // 上次时刻
      public var lastTick:Number = 0;
      
      // 间隔时刻
      public var intervalTick:Number = 1000;
      
      // 帧间隔
      public var frameTick:int;

      //============================================================
      // <T>构造线程处理基类。</T>
      //============================================================
      public function FMonitor(){
      }
      
      //============================================================
      // <T>判断是否指定状态。</T>
      //============================================================
      public function isStatus(p:int):Boolean{
         return statusCd == p;
      }
      
      //============================================================
      // <T>开始执行处理。</T>
      //============================================================
      public function start():void{
         statusCd = EThreadStatus.Processing;
      }
      
      //============================================================
      // <T>结束执行处理。</T>
      //============================================================
      public function stop():void{
         statusCd = EThreadStatus.Stop;
      }
      
      //============================================================
      // <T>结束空闲处理。</T>
      //============================================================
      public function idle():void{
         statusCd = EThreadStatus.Idle;
      }
      
      //============================================================
      // <T>执行处理。</T>
      //============================================================
      public function execute():void{
      }
      
      //============================================================
      // <T>线程处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function process():void{
         var rt:Number = RTimer.realTick;
         if(rt - lastTick >= intervalTick){
            lastTick = rt;
            // 处理逻辑
            var ts:Number = new Date().time;
            execute();
            var te:Number = new Date().time;
            frameTick = (te - ts);
            RTracker.monitorTotal++;
         }
      }
      
      //============================================================
      public override function toString():String{
         return name + " [" + frameTick + "]";
      }
   }
}


