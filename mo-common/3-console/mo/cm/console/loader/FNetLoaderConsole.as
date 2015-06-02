package mo.cm.console.loader
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.lang.FLooper;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>加载控制器。</T>
   //============================================================
   public class FNetLoaderConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FNetLoaderConsole);
      
      // 加载器数组
      public var loaders:Vector.<FNetLoader> = new Vector.<FNetLoader>();
      
      // 待加载数据队列
      public var contents:FLooper = new FLooper();
      
      // 加载超时时长
      public var loaderCount:int = 12;

      // 加载超时时长
      public var loadTimeout:Number = 180000;

      // 线程处理
      public var thread:FNetLoaderThread = new FNetLoaderThread();
      
      //============================================================
      // <T>构造加载控制器。</T>
      //============================================================
      public function FNetLoaderConsole(){
         name = "common.net.loader.console";
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置节点
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         loadTimeout = p.getInt("timeout", loadTimeout);
         loaderCount = p.getInt("loader_count", loaderCount);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         super.setup();
         // 创建加载器 
         for(var n:int = 0; n < loaderCount; n++ ){
            var l:FNetLoader = new FNetStreamLoader();
            l.console = this;
            l.setup();
            loaders.push(l);
         }
         // 启动线程
         thread.console = this;
         RCmConsole.threadConsole.start(thread);
      }
      
      //============================================================
      // <T>以权重对加载数据进行排序。</T>
      //
      // @param prior:FContentLoader  数据内容加载器
      // @param next:FContentLoader  数据内容加载器
      //============================================================
      public function sortPriority(p:FNetContent):int{
         return p.priority;
      }
      
      //============================================================
      // <T>加载内容。</T>
      //
      // @param p:FContentLoader  数据内容加载器
      //============================================================
      public function load(p:FNetContent):void{
         contents.pushUnique(p);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function process():Boolean{
         // _logger.debug("process", "Process loader. (count={1})", c);
         var c:int = loaders.length;
         for(var n:int = 0; n < c; n++){
            var l:FNetLoader = loaders[n];
            if(!l.loading){
               // 处理未工作的加载器
               var nc:FNetContent = contents.nextSort(sortPriority);
               if(nc){
                  // 检查内容是否还有效
                  if(nc.valid){
                     l.load(nc);
                  }
                  contents.remove();
               }
            }else{
               l.process();
            }
         }
         return true;
      }
   }
}