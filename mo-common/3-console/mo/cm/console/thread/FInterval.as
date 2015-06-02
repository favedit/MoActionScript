package mo.cm.console.thread
{
   import mo.cm.core.device.RTimer;
   
   //============================================================
   // <T>间隔处理过程。</T>
   //
   //============================================================
   public class FInterval extends FThread 
   {
      // 上次时刻
      protected var _lastTick:Number = 0;
      
      // 间隔时刻
      public var intervalTick:Number = 1000;
      
      //============================================================
      // <T>构造间隔处理过程。</T>
      //============================================================
      public function FInterval(){
         name = "common.interval";
      }
      
      //============================================================
      // <T>线程处理。</T>
      //
      // @return 处理结果
      //============================================================
      public override function processFirst():Boolean{
         var tick:Number = RTimer.realTick;
         if(tick - _lastTick >= intervalTick){
            _lastTick = tick;
            // 处理逻辑
            result = super.processFirst();
         }else{
            result = true;
         }
         return result;
      }
   }
}