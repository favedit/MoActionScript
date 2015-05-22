package mo.cm.system
{
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;

   //============================================================
   // <T>时间间隔检查器。</T>
   //============================================================
   public class FSpanChecker extends FObject
   {
      // 间隔时刻
      public var spanTick:Number = 0;

      // 最后时刻
      public var lastTick:Number = 0;
      
      //============================================================
      // <T>构造时间间隔检查器。</T>
      //============================================================
      public function FSpanChecker(p:Number = 1000){
         spanTick = p;
      }

      //============================================================
      // <T>检查时间间隔，并重设时间。</T>
      //
      // @return 是否处理
      //============================================================
      [Inline]
      public final function check():Boolean{
         var t:Number = RTimer.realTick;
         if(t - lastTick < spanTick){
            return false;
         }
         lastTick = t;
         return true;
      }
   }
}