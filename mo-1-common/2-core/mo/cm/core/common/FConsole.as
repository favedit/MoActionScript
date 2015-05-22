package mo.cm.core.common
{
   import mo.cm.core.device.RFatal;
   import mo.cm.lang.FObject;
   import mo.cm.lang.RString;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>控制台。</T>
   //============================================================
   public class FConsole extends FObject
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FConsole);
      
      // 设置处理
      public var setuped:Boolean;
      
      // 名称
      public var name:String;
      
      //============================================================
      // <T>构造控制台。</T>
      //============================================================
      public function FConsole(){
      }
      
      //============================================================
      // <T>内部检查。</T>
      //============================================================
      protected function innerCheck():void{
         if(RString.isEmpty(name)){
            RFatal.throwFatal("Console name is empty.");
         }
      }

      //============================================================
      // <T>构造控制台处理。</T>
      //============================================================
      public override function construct():void{
         super.construct();
         innerCheck();
         _logger.debug("construct", "Construct console. (name={1})", name);
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         innerCheck();
         _logger.debug("loadConfig", "Load console config. (name={1})", name);
      }
      
      //============================================================
      // <T>设置控制台处理。</T>
      //============================================================
      public function setup():void{
         innerCheck();
         setuped = true; 
         _logger.debug("setup", "Setup console. (name={1})", name);
      }
   }
}