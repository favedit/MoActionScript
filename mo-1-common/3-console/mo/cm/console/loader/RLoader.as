package mo.cm.console.loader
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>资源加载器</T>
   //============================================================
   public class RLoader
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(RLoader);

      // 设置加载器（XML内容）
      public static var thread:FLoaderThread = new FLoaderThread();
      
      // 加载信息
      public static var info:FLoaderInfo = new FLoaderInfo();

      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setup():void{
         RCmConsole.threadConsole.start(thread);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setupDefault():void{
         RCmConsole.configLoaderConsole.setupDefault(1);
         RCmConsole.infoLoaderConsole.setupDefault(1);
         RCmConsole.dataLoaderConsole.setupDefault(4);
      }
      
      //============================================================
      // <T>获得指定类型的控制台。</T>
      //============================================================
      public static function console(p:int):FLoaderConsole{
         switch(p){
            case ELoader.Config:
               return RCmConsole.configLoaderConsole;
            case ELoader.Info:
               return RCmConsole.infoLoaderConsole;
            case ELoader.Data:
               return RCmConsole.dataLoaderConsole;
         }
         RFatal.throwFatal("Unknown console type. (type_cd={1})", p);
         return null;
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function process():void{
         RCmConsole.configLoaderConsole.process();
         RCmConsole.infoLoaderConsole.process();
         RCmConsole.dataLoaderConsole.process();
      }
      
      //============================================================
      public static function makeInfo():String{
         var info:String = "";
//         if(configLoader.loadingContent){
//            var xcount:int = configLoader.loadingQueue.count + 1;
//            info += "\n   [读取配置] [剩余：" + RString.lpad(xcount.toString(), 2, "0") + "] " + configLoader.loadingContent.source + " " + configLoader.progress();
//         }
//         if(infoLoader.loadingContent){
//            var icount:int = infoLoader.loadingQueue.count + 1;
//            info += "\n   [读取内容] [剩余：" + RString.lpad(icount.toString(), 2, "0") + "] " + infoLoader.loadingContent.source + " " + infoLoader.progress();
//         }
//         if(dataLoader1.loadingContent){
//            var ucount1:int = dataLoader1.loadingQueue.count + 1;
//            info += "\n   [读取数据] [剩余：" + RString.lpad(ucount1.toString(), 2, "0") + "] " + dataLoader1.loadingContent.source + " " + dataLoader1.progress();
//         }
//         if(dataLoader2.loadingContent){
//            var ucount2:int = dataLoader2.loadingQueue.count + 1;
//            info += "\n   [读取数据] [剩余：" + RString.lpad(ucount2.toString(), 2, "0") + "] " + dataLoader2.loadingContent.source + " " + dataLoader2.progress();
//         }
         return info; 
      }
   }
}