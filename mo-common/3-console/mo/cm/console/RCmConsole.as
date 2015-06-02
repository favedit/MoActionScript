package mo.cm.console
{
   import mo.cm.console.environment.FEnvironmentConsole;
   import mo.cm.console.loader.ELoader;
   import mo.cm.console.loader.FContentLoader;
   import mo.cm.console.loader.FInfoLoaderConsole;
   import mo.cm.console.loader.FLoaderEvent;
   import mo.cm.console.loader.FNetLoaderConsole;
   import mo.cm.console.loader.FUrlLoaderConsole;
   import mo.cm.console.loader.FXmlLoaderConsole;
   import mo.cm.console.loader.RLoader;
   import mo.cm.console.memory.FMemoryConsole;
   import mo.cm.console.message.FMessageConsole;
   import mo.cm.console.monitor.FMonitorConsole;
   import mo.cm.console.monitor.FMonitorGc;
   import mo.cm.console.progress.FProgressConsole;
   import mo.cm.console.resource.FResourceConsole;
   import mo.cm.console.synchronizer.FSynchronizerConsole;
   import mo.cm.console.thread.FThreadConsole;
   import mo.cm.console.track.FTrackConsole;
   import mo.cm.console.transfer.FTransferConsole;
   import mo.cm.core.common.RSingleton;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.system.REvent;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>共通单件管理器。</T>
   //============================================================
   public class RCmConsole extends RSingleton
   {
      // 环境管理器
      public static var environmentConsole:FEnvironmentConsole = new FEnvironmentConsole();
      
      // 线程管理器
      public static var threadConsole:FThreadConsole = new FThreadConsole();
      
      // 监视管理器
      public static var monitorConsole:FMonitorConsole = new FMonitorConsole();
      
      // 线程后置管理器
      public static var threadAfterConsole:FThreadConsole = new FThreadConsole();

      // 加载器控制台
      public static var loaderConsole:FNetLoaderConsole = new FNetLoaderConsole();
      
      // 设置加载器（XML内容）
      public static var configLoaderConsole:FXmlLoaderConsole = new FXmlLoaderConsole();
      
      // 内容加载器（图片内容）
      public static var infoLoaderConsole:FInfoLoaderConsole = new FInfoLoaderConsole();
      
      // 数据加载器（二进制内容）
      public static var dataLoaderConsole:FUrlLoaderConsole = new FUrlLoaderConsole();
      
      // 资源控制台
      public static var resourceConsole:FResourceConsole = new FResourceConsole();
      
      // 传输控制台
      public static var transferConsole:FTransferConsole = new FTransferConsole();
      
      // 消息控制台
      public static var messageConsole:FMessageConsole = new FMessageConsole();
      
      // 进度控制台
      public static var progressConsole:FProgressConsole = new FProgressConsole();
      
      // 跟踪控制台
      public static var trackConsole:FTrackConsole = new FTrackConsole();
      
      // 跟踪控制台
      public static var memoryConsole:FMemoryConsole = new FMemoryConsole();

      // 同步控制台
      public static var synchronizerConsole:FSynchronizerConsole = new FSynchronizerConsole();

      // 完成监听器
      public static var lsnComplete:FListeners = new FListeners();
      
      //============================================================
      // <T>初始化单件管理器。</T>
      //============================================================
      {
         name = "common.console.singleton";
      }
      
      //============================================================
      // <T>处理事件过程。</T>
      //============================================================
      public static function processEvent():void{
         REvent.process();
      }
      
      //============================================================
      // <T>处理线程过程。</T>
      //============================================================
      public static function processBefore():void{
         threadConsole.process();
      }
      
      //============================================================
      // <T>处理后续过程。</T>
      //============================================================
      public static function processAfter():void{
         monitorConsole.process();
         threadAfterConsole.process();
      }

      //============================================================
      // <T>加载需要加载的资源。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public static function loadLoadList(p:FXmlNode):void{
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var node:FXmlNode = p.node(n);
            var type:int = ELoader.parseSimple(node.get("type"));
            var loader:FContentLoader = RAllocator.create(FContentLoader);
            loader.url = node.get("path");
            loader.lsnsComplete.register(onLoadComplete);
            // 创建文件定义
            switch(type){
               case ELoader.Config:
                  configLoaderConsole.load(loader);
                  break;
               case ELoader.Data:
                  dataLoaderConsole.load(loader);
                  break;
               case ELoader.Info:
                  infoLoaderConsole.load(loader);
                  break;
            }
         }
      }
      
      //============================================================
      // <T>配置文件加载完成。</T>
      //============================================================
      public static function onLoadComplete(event:FLoaderEvent):void{
         lsnComplete.process(event);
      }
      
      //============================================================
      // <T>加载配置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public static function loadConfig(p:FXmlNode):void{
         RSingleton.loadConfig(p);
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Console")){
               switch(x.get("name")){
                  case memoryConsole.name:
                     // 加载线程控制台
                     memoryConsole.loadConfig(x);
                     break;
                  case threadConsole.name:
                     // 加载线程控制台
                     threadConsole.loadConfig(x);
                     break;
                  case monitorConsole.name:
                     // 加载监视控制台
                     monitorConsole.loadConfig(x);
                     break;
                  case loaderConsole.name:
                     // 加载加载器控制台
                     loaderConsole.loadConfig(x);
                     break;
                  case configLoaderConsole.name:
                     // 加载设置加载器控制台
                     configLoaderConsole.loadConfig(x);
                     break;
                  case infoLoaderConsole.name:
                     // 加载信息加载器控制台
                     infoLoaderConsole.loadConfig(x);
                     break;
                  case dataLoaderConsole.name:
                     // 加载数据加载器控制台
                     dataLoaderConsole.loadConfig(x);
                     break;
                  case transferConsole.name:
                     // 加载传输控制台
                     transferConsole.loadConfig(x);
                     break;
                  case resourceConsole.name:
                     // 加载资源控制台
                     resourceConsole.loadConfig(x);
                     break;
                  case messageConsole.name:
                     // 消息控制台
                     messageConsole.loadConfig(x);
                     break;
                  case progressConsole.name:
                     // 进度控制台
                     progressConsole.loadConfig(x);
                     break;
                  case trackConsole.name:
                     // 跟踪控制台
                     trackConsole.loadConfig(x);
                     break;
                  case synchronizerConsole.name:
                     // 同步控制台
                     synchronizerConsole.loadConfig(x);
                     break;
               }
            }
         }
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setup():void{
         RLoader.setup();
         monitorConsole.start(new FMonitorGc);
         memoryConsole.setup();
         loaderConsole.setup();
         transferConsole.setup();
         resourceConsole.setup();
         if(!progressConsole.setuped){
            progressConsole.setup();
         }
         if(!trackConsole.setuped){
            trackConsole.setup();
         }
         synchronizerConsole.setup();
      }
   }
}