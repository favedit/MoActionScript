package mo.cr.message
{
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.RFloat;
   
   //============================================================
   // <T>消息统计。</T>
   //============================================================
   public class SNetMessageStatistics
   {
      // 代码
      public var code:int;
      
      // 总数
      public var count:uint;
      
      // 所有时刻
      public var totalTick:uint;
      
      // 开始时刻
      public var startTick:Number = 0;
      
      // 结束时刻
      public var endTick:Number = 0;
      
      // 结束时刻
      public var maxTick:uint = 0;
      
      //============================================================
      // <T>构造消息统计。</T>
      //============================================================
      public function SNetMessageStatistics(p:int = 0){
         code = p;
      }
      
      //============================================================
      // <T>开始处理。</T>
      //============================================================
      public function begin():void{
         startTick = RTimer.makeRealTick();
      }
      
      //============================================================
      // <T>结束处理。</T>
      //============================================================
      public function end():void{
         count++;
         endTick = RTimer.makeRealTick();
         var c:uint = endTick - startTick;
         if(c > maxTick){
            maxTick = c;
         }
         totalTick += c;
      }
      
      //============================================================
      // <T>格式化处理。</T>
      //
      // @return 格式化字符串
      //============================================================
      public function format():String{
         return "0x" + code.toString(16) + " [" + RFloat.format(totalTick / RTimer.totalTick, 6) + "| " + totalTick + "| "+ maxTick + "]";
      }
   }
}