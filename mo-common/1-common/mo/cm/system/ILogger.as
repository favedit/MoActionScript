package mo.cm.system 
{
   //============================================================
   // <T>日志接口。</T>
   //============================================================
   public interface ILogger
   {
      //============================================================
      // <T>调试日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      function debug(pm:String, ps:String, ...rest):void;
      
      //============================================================
      // <T>调试日志跟踪输出。</T>
      //
      // @param pm:method 函数名称
      // @param pt:tick 执行间隔
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      function debugTrack(pm:String, pt:int, ps:String, ...rest):void;

      //============================================================
      // <T>信息日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      function info(pm:String, ps:String, ...rest):void;
      
      //============================================================
      // <T>警告日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      function warn(pm:String, ps:String, ...rest):void;
      
      //============================================================
      // <T>错误日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      function error(pm:String, ps:String, ...rest):void;
      
      //============================================================
      // <T>例外日志输出。</T>
      //
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      function fatal(pm:String, ps:String, ...rest):void;
   }
}