package mo.cm.system
{
   import mo.cm.logger.RLogger;

   //============================================================
   // <T>错误。</T>
   //============================================================
   public class FError extends Error
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FError);
      
      //============================================================
      // <T>构造错误。</T>
      //============================================================
      public function FError(){
      }
   }
}