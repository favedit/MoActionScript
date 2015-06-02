package mo.cm.console.loader
{
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RTimer;
   import mo.cm.logger.RLogger;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>加载控制器。</T>
   //============================================================
   public class FLoaderConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FLoaderConsole);
      
      // 默认工作数
      private static const DefaultCount:int = 2;
      
      // 加载器数组
      public var loaders:Vector.<FLoader> = new Vector.<FLoader>();
      
      // 待加载数据队列
      public var loadQueue:Vector.<FContentLoader> = new Vector.<FContentLoader>();
      
      //============================================================
      // <T>构造加载控制器。</T>
      //============================================================
      public function FLoaderConsole(){
      }
      
      //============================================================
      // <T>创建加载器。</T>
      //============================================================
      public function createLoader():FLoader{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      public override function setup():void{
      }
      
      //============================================================
      public function setupDefault(p:int = DefaultCount):void{
         for(var n:int = 0; n < p; n++){
            var l:FLoader = createLoader();
            l.lsnsComplete.register(onLoadComplete, this);
            l.lsnsIoError.register(onIoError, this);
            loaders.push(l);
            _logger.debug("setupDefault", "Create loader. (loader={1}, count={2})", l, loaders.length);
         }
      }
      
      //============================================================
      // <T>获得加载器进度。</T>
      //============================================================
      public function progress():String{
         //return loader.progress();
         return "";
      }
      
      //============================================================
      // <T>以权重对加载数据进行排序。</T>
      //
      // @param prior:FContentLoader  数据内容加载器
      // @param next:FContentLoader  数据内容加载器
      //============================================================
      public function OnSortPriority(ps:FContentLoader, pt:FContentLoader):int{
         return (pt.priority - ps.priority);
      }
      
      //============================================================
      // <T>权重排序。</T>
      //
      // @return 加载内容
      //============================================================
      public function findPriorityContent():FContentLoader{
         if(loadQueue.length){
            loadQueue.sort(OnSortPriority);
            return loadQueue.shift();
         }
         return null;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置节点
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         var c:int = p.getInt("loader_count"); 
         for(var n:int = 0; n < c; n++ ){
            var l:FLoader = createLoader();
            l.registerComplete(onLoadComplete, this);
            l.registerIoError(onIoError, this);
            loaders.push(l);
         }
      }
      
      //============================================================
      // <T>加载完成事件。</T>
      //
      // @param p:FLoaderEvent  完成事件
      //============================================================
      protected function onLoadComplete(p:FLoaderEvent):void {
         // 加载完成的资源
         var l:FLoader = p.sender;
         var cl:FContentLoader = l.contentLoader;
         cl.loadContent(p);
         cl.dispose();
         // 清空信息
         l.contentLoader = null;
      }
      
      //============================================================
      // <T>加载错误事件。</T>
      //
      // @param p:FLoaderEvent  错误事件
      //============================================================
      protected function onIoError(p:FLoaderEvent):void{
         // 加载完成的资源
         var l:FLoader = p.sender;
         var cl:FContentLoader = l.contentLoader;
         cl.loadError = true;
         // 清空信息
         cl.loader = null;
         l.contentLoader = null;
      }
      
      //============================================================
      // <T>加载内容。</T>
      //
      // @param p:FContentLoader  数据内容加载器
      //============================================================
      public function load(p:FContentLoader):void{
         p.console = this;
         if(!loaders.length){
            setupDefault();
         }
         if(-1 == loadQueue.indexOf(p)){
            loadQueue.push(p);
         }
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function process():void{
         var c:int = loaders.length;
         // _logger.debug("process", "Process loader. (count={1})", c);
         var cl:FContentLoader = null;
         for(var n:int = 0; n < c; n++){
            var l:FLoader = loaders[n];
            if(!l.loading){
               // 处理未工作的加载器
               cl = findPriorityContent();
               if(cl){
                  // 加载资源
                  l.contentLoader = cl;
                  l.load(cl.url);
               }
            }else{
               // 处理工作的加载器
               if(RTimer.realTick - l.lastTick > l.timeout){
                  // 处理内容加载器
                  cl = l.contentLoader;
                  cl.timeoutCount++;
                  // 放回队列
                  if(-1 == loadQueue.indexOf(cl)){
                     loadQueue.push(cl);
                  }
                  // 超时处理
                  _logger.debug("process", "Process loader timeout. (timeout_count={1})", cl.timeoutCount);
                  l.close();
               }
            }
         }
      }
   }
}