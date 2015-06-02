package mo.cm.system
{   
   import mo.cm.logger.RLogger;

   //============================================================
   // <T>致命错误。</T>
   //============================================================
   public class FFatalError extends FError
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FFatalError);
      
      //============================================================
      // <T>构造致命错误。</T>
      //
      // @param pm:message 消息
      // @param pp:params 参数
      //============================================================
      public function FFatalError(pm:String, ...pp){
         _logger.fatal("FFatalError", pm, pp);
      }      
   }
}