package mo.cm.logger 
{
   import mo.cm.core.device.EProcess;
   import mo.cm.core.device.RGlobal;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>日志输出管理器。</T>
   //============================================================
   public class RLogger
   {
      // 是否可深层调试
      public static var deepDebugAble:Boolean = false;

      // 是否可调试
      public static var debugAble:Boolean = false;

      // 输出标志
      public static var outputed:Boolean = false;
      
      // 输出器
      public static var writer:FLoggerWriter = new FLoggerWriter();
      
      // 输出监听器
      public static var lsnsWrite:FListeners;

      //============================================================
      // <T>注册一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public static function registerWrite(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(!lsnsWrite){
            lsnsWrite = new FListeners();
         }
         return lsnsWrite.register(pm, po, pc);
      }
      
      //============================================================
      // <T>根据对象查找日志输出器。</T>
      //
      // @param p:instance 类对象
      // @return 日志输出器
      //============================================================
      public static function find(p:Object):ILogger{
         return new FLogger(p);
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
      public static function output(pl:int, pc:String, pm:String, pt:int, ps:String, pp:Array):void{
         // 跟踪结果
         if(EProcess.Release != RGlobal.processCd){
            writer.output(pl, pc, pm, pt, ps, pp);
            outputed = true;
         }
      }
   }	
}