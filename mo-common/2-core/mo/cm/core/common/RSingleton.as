package mo.cm.core.common
{
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;

   //============================================================
   // <T>单件管理器。</T>
   //============================================================
   public class RSingleton
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(RSingleton);
      
      // 名称
      public static var name:String;
      
      //============================================================
      // <T>构造处理。</T>
      //============================================================
      public static function construct():void{
         _logger.debug("construct", "Construct singleton. (name={1})", name);
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public static function loadConfig(p:FXmlNode):void{
         _logger.debug("loadConfig", "Config singleton. (name={1})", name);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setup():void{
         _logger.debug("setup", "Setup singleton. (name={1})", name);
      }
   }
}