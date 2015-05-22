package mo.cr.console
{
   import mo.cm.core.common.RSingleton;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.effect.FCrEffectConsole;
   import mo.cr.console.focus.FCrFocusConsole;
   import mo.cr.console.media.FCrMediaConsole;
   import mo.cr.console.message.FCrMessageConsole;
   import mo.cr.console.physical.FCrPhysicalConsole;
   import mo.cr.console.process.FCrProcessConsole;
   import mo.cr.console.queue.FCrQueueConsole;
   import mo.cr.console.resource.FCrResourceConsole;
   import mo.cr.console.sound.FCrSoundConsole;
   import mo.cr.console.worker.FCrWorkerConsole;
   
   //============================================================
   // <T>核心单件管理器。</T>
   //============================================================
   public class RCrConsole extends RSingleton
   {
      // 进程管理器
      public static var processConsole:FCrProcessConsole = new FCrProcessConsole();
      
      // 队列管理器
      public static var queueConsole:FCrQueueConsole = new FCrQueueConsole();
      
      // 工作管理器
      public static var workerConsole:FCrWorkerConsole = new FCrWorkerConsole();

      // 资源管理器
      public static var resourceConsole:FCrResourceConsole = new FCrResourceConsole();
      
      // 焦点管理器
      public static var focusConsole:FCrFocusConsole = new FCrFocusConsole();
      
      // 消息管理器
      public static var messageConsole:FCrMessageConsole = new FCrMessageConsole();
      
      // 物理管理器
      public static var physicalConsole:FCrPhysicalConsole = new FCrPhysicalConsole();
      
      // 效果管理器
      public static var effectConsole:FCrEffectConsole = new FCrEffectConsole();
      
      // 资源音乐控制台
      public static var mediaConsole:FCrMediaConsole = RAllocator.create(FCrMediaConsole);
      
      // 资源音效控制台
      public static var soundConsole:FCrSoundConsole = RAllocator.create(FCrSoundConsole);
      
      //============================================================
      // <T>初始化单件管理器。</T>
      //============================================================
      {
         name = "core.console.singleton";
      }
      
      //============================================================
      // <T>构造处理。</T>
      //============================================================
      public static function construct():void{
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
                  // 加载进程管理器设置
                  case processConsole.name:
                     processConsole.loadConfig(x);
                     break;
                  // 加载队列管理器设置
                  case queueConsole.name:
                     queueConsole.loadConfig(x);
                     break;
                  // 工作队列管理器设置
                  case workerConsole.name:
                     workerConsole.loadConfig(x);
                     break;
                  // 加载资源管理器设置
                  case resourceConsole.name:
                     resourceConsole.loadConfig(x);
                     resourceConsole.setup();
                     break;
                  // 加载焦点管理器设置
                  case focusConsole.name:
                     focusConsole.loadConfig(x);
                     break;
                  // 加载消息管理器设置
                  case messageConsole.name:
                     messageConsole.loadConfig(x);
                     break;
                  // 加载物理管理器设置
                  case physicalConsole.name:
                     physicalConsole.loadConfig(x);
                     break;
                  // 加载效果管理器设置
                  case effectConsole.name:
                     effectConsole.loadConfig(x);
                     break;
                  // 加载音乐管理器设置
                  case mediaConsole.name:
                     mediaConsole.loadConfig(x);
                     break;
                  // 加载音效管理器设置
                  case soundConsole.name:
                     soundConsole.loadConfig(x);
                     break;
               }
            }
         }
      }

      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setup():void{
      }
   }
}