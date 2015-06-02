package mo.cm.logger
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.RDate;
   import mo.cm.lang.RInteger;
   import mo.cm.lang.RString;
   import mo.cm.system.RProcess;
   
   //============================================================
   // <T>日志输出器。</T>
   //============================================================
   public class FLoggerWriter extends FObject
   {
      // 事件
      public var event:FLoggerEvent = new FLoggerEvent;
      
      //============================================================
      // <T>构造日志输出器。</T>
      //============================================================
      public function FLoggerWriter(){
      }
      
      //============================================================
      // <T>格式化日志内容。</T>
      //
      // @param pl:level 级别
      // @param pc:class 类名称
      // @param pm:method 函数名称
      // @param pt:tick 时刻
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function format(pl:int, pc:String, pm:String, pt:int, ps:String, pp:Array):String{
         var r:String = RDate.format(RDate.now(), "YYMMDD-HH24MISS.MS|");
         r += RProcess.processId + "." + ELogger.toSimple(pl);
         var instance:String = pc + '.' + pm;
         if(pt > 0){
            r += " [ " + RString.rpad(instance, 42) + RInteger.lpad(pt, 4) + " ] ";
         }else{
            r += " [ " + RString.rpad(instance, 46) + " ] ";
         }
         // 替换埋入参数
         var c:int = pp.length;
         for(var n:int = 0; n < c; n++) {
            ps = ps.replace("{" + (n + 1) + "}", pp[n]);
         }
         return r + ps;
      }
      
      //============================================================
      // <T>格式化内容输出。</T>
      //
      // @param pl:level 级别
      // @param pc:class 类名称
      // @param pm:method 函数名称
      // @param pt:tick 时刻
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function output(pl:int, pc:String, pm:String, pt:int, ps:String, pp:Array):void{
         var m:String = format(pl, pc, pm, pt, ps, pp);
         // 分发事件
         event.levelCd = pl;
         event.message = m;
         if(RLogger.lsnsWrite){
            RLogger.lsnsWrite.process(event);
         }
         // 输出跟踪
         trace(m);
      }
   }
}