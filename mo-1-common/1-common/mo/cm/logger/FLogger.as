package mo.cm.logger
{   
   import mo.cm.core.device.EProcess;
   import mo.cm.core.device.RGlobal;
   import mo.cm.lang.FObject;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>日志对象。</T>
   //============================================================
   public class FLogger extends FObject implements ILogger
   { 
      // 类对象
      public var clazz:Class;
      
      // 类名称
      public var className:String;
      
      //============================================================
      // <T>构造日志对象。</T>
      //
      // @param p:class 类对象
      //============================================================
      public function FLogger(p:Object){
         clazz = p as Class;
         className = "" + clazz;
         className = className.substring(7, className.length - 1);
      }
      
      //============================================================
      // <T>调试日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function debug(pm:String, ps:String, ...rest):void{
         if(RLogger.debugAble){
            if(EProcess.Release != RGlobal.processCd){
               RLogger.output(ELogger.Debug, className, pm, 0, ps, rest);
            }
         }
      }
      
      //============================================================
      // <T>调试日志跟踪输出。</T>
      //
      // @param pm:method 函数名称
      // @param pt:tick 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function debugTrack(pm:String, pt:int, ps:String, ...rest):void{
         if(RLogger.debugAble){
            if(EProcess.Release != RGlobal.processCd){
               RLogger.output(ELogger.Debug, className, pm, pt, ps, rest);
            }
         }
      }
      
      //============================================================
      // <T>信息日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function info(pm:String, ps:String, ...rest):void{
         if(EProcess.Release != RGlobal.processCd){
            RLogger.output(ELogger.Info, className, pm, 0, ps, rest);
         }
      }
      
      //============================================================
      // <T>警告日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function warn(pm:String, ps:String, ...rest):void{
         if(EProcess.Release != RGlobal.processCd){
            RLogger.output(ELogger.Warn, className, pm, 0, ps, rest);
         }
      }
      
      //============================================================
      // <T>错误日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function error(pm:String, ps:String, ...rest):void{
         if(EProcess.Release != RGlobal.processCd){
            RLogger.output(ELogger.Error, className, pm, 0, ps, rest);
         }
      }
      
      //============================================================
      // <T>例外日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public function fatal(pm:String, ps:String, ...rest):void{
         if(EProcess.Release != RGlobal.processCd){
            RLogger.output(ELogger.Fatal, className, pm, 0, ps, rest);
         }
      }
   }
}