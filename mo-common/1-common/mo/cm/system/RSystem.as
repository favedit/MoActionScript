package mo.cm.system
{
   import flash.net.LocalConnection;
   
   import mo.cm.logger.RLogger;

   //============================================================
   // <T>系统工具类。</T>
   //============================================================
   public class RSystem
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(RSystem); 
      
      //============================================================
      // <T>清空内存。</T>
      //============================================================
      public static function gc():void{
         var ts:Number = new Date().time;
         try{
            var lc1:LocalConnection = new LocalConnection();
            var lc2:LocalConnection = new LocalConnection();
            lc1.connect("gc");
            lc1.connect("gc");
         }catch(e:Error){
         }                        
         var te:Number = new Date().time;
         _logger.debugTrack("gc", te - ts, "System garbage collection.");
      }
   }
}