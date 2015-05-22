package mo.cm.logger
{
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.RFloat;
   
   //============================================================
   // <T>效率跟踪器。</T>
   //============================================================
   public class FTracker
   {
      // 总时刻
      public var totalTick:Number = 0;
      
      // 当前时刻
      public var currentTick:Number = 0;
      
      // 开始时刻
      public var startTick:Number = 0;
      
      // 结束时刻
      public var endTick:Number = 0;
      
      // 最小时刻
      public var minTick:Number = Number.MAX_VALUE;
      
      // 最大时刻
      public var maxTick:Number = 0;
      
      //============================================================
      // <T>构造效率跟踪器。</T>
      //============================================================
      public function FTracker(){
      }
      
      //============================================================
      // <T>重置处理。</T>
      //============================================================
      public function reset():void{
         totalTick = 0;
         currentTick = 0;
         startTick = 0;
         endTick = 0;
         minTick = Number.MAX_VALUE;
         maxTick = 0;
      }
      
      //============================================================
      // <T>开始处理。</T>
      //============================================================
      public function begin():void{
         if(!RGlobal.isRelease){
            startTick = new Date().time;
         }
      }
      
      //============================================================
      // <T>结束处理。</T>
      //============================================================
      public function end():void{
         // 计算数据
         if(!RGlobal.isRelease){
            endTick = new Date().time;
            currentTick = endTick - startTick;
            totalTick += currentTick;
            // 计算范围
            if(currentTick > 0){
               if(currentTick > maxTick){
                  maxTick = currentTick;
               }
               if(currentTick < minTick){
                  minTick = currentTick;
               }
            }
         }
      }
      
      //============================================================
      // <T>格式化为字符串。</T>
      //
      // @return 字符串
      //============================================================
      public function format():String{
         return totalTick + " [" + RFloat.format(totalTick / RTimer.totalTick, 6) + "|" + RFloat.format(currentTick) + ":" + RFloat.format(maxTick) + "]";
      }
      
      //============================================================
      // <T>格式化为百分比。</T>
      //
      // @return 字符串
      //============================================================
      public function percent():String{
         return totalTick + " [" + RFloat.format(totalTick / RTracker.frame.totalTick, 6) + "|" + RFloat.format(currentTick) + ":" + RFloat.format(maxTick) + "]";
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public function toString():String{
         return totalTick + "[" + RFloat.format(currentTick) + "|" + RFloat.format(minTick) + "~" + RFloat.format(maxTick) + "]";
      }
      
      //============================================================
      // <T>清除内容。</T>
      //============================================================
      public function clear():void{
         totalTick = 0;
         currentTick = 0;
         startTick = 0;
         endTick = 0;
         maxTick = 0;
      }
   }
}