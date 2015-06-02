package mo.cm.console.loader
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RTimer;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>网络数据流加载器。</T>
   //============================================================
   public class FNetStreamLoader extends FNetLoader
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FNetStreamLoader);
      
      // 加载器
      public var loader:URLStream;
      
      //============================================================
      // <T>构造网络数据流加载器。</T>
      //============================================================
      public function FNetStreamLoader(){
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         loader = new URLStream()
         loader.endian = Endian.LITTLE_ENDIAN;
         loader.addEventListener(Event.OPEN, onOpen);
         loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
         loader.addEventListener(ProgressEvent.PROGRESS, onProgress);
         loader.addEventListener(Event.COMPLETE, onComplete);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
         loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
      }
      
      //============================================================
      // <T>打开事件处理。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onOpen(e:Event):void{
         statusCd = ELoaderStatus.Open;
      }
      
      //============================================================
      // <T>状态事件处理。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onStatus(e:HTTPStatusEvent):void{
         //_logger.debug("onStatus", "Status changed. (url={1}, status={2})", uri, e.status);
      }
      
      //============================================================
      // <T>加载事件处理。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onProgress(e:ProgressEvent):void{
         bytesLoaded = e.bytesLoaded;
         bytesTotal = e.bytesTotal;
         lastTick = RTimer.realTick;
         // 加载数据
         if(content.valid){
            content.loadProgress(this);
            // 加载进度事件
            if(lsnsProgress){
               lsnsProgress.process();
            }
         }else{
            _logger.debug("onProgress", "Loading content cancel. (loader={1}, url={2})", this, content.url);
            loader.close();
            loading = false;
            content = null;
         }
      }
      
      //============================================================
      // <T>内容加载完成事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onComplete(e:Event):void{
         _logger.debug("onComplete", "Load content complete. (loader={1}, url={2})", this, content.url);
         loading = false;
         statusCd = ELoaderStatus.Complete;
         // 加载数据
         if(content.valid){
            content.loadComplete(this);
            // 加载计时
            endTick = RTimer.getTick();
            loadTick = endTick - beginTick;
            RLoader.info.load(bytesTotal, loadTick);
            // 加载事件
            if(lsnsComplete){
               var le:FLoaderEvent = new FLoaderEvent();
               le.loader = this;
               lsnsComplete.process(le);
               le.dispose();
            }
         }else{
            _logger.debug("onComplete", "Loading content cancel. (loader={1}, url={2})", this, content.url);
         }
         loader.close();
         loading = false;
         content = null;
      }
      
      //============================================================
      // <T>权限错误事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onSecurityError(e:Event):void{
         _logger.debug("onSecurityError", "Raise io error. (loader={1}, url={2}, message={3})", this, content.url, e);
         loading = false;
         statusCd = ELoaderStatus.SecurityError;
         loader.close();
      }
      
      //============================================================
      // <T>流错误事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onIoError(e:IOErrorEvent):void{
         _logger.debug("onIoError", "Raise io error. (loader={1}, url={2}, message={3})", this, content.url, e.text);
         loading = false;
         statusCd = ELoaderStatus.IoError;
         loader.close();
      }
      
      //============================================================
      // <T>加载网络内容。</T>
      //
      // @param p:content 网络内容
      //============================================================
      public override function load(p:FNetContent):void{
         super.load(p);
         // 计算网络地址
         loading = true;
         statusCd = ELoaderStatus.Load;
         bytesLoaded = 0;
         bytesTotal = 0;
         beginTick = RTimer.getTick();
         lastTick = beginTick;
         // 加载数据
         loader.load(new URLRequest(content.url));
         _logger.debug("load", "Load url resource. (url={1})", content.url);
      }
      
      //============================================================
      // <T>读取网络数据。</T>
      //
      // @param p:data 数据
      //============================================================
      public override function readBytes(p:ByteArray):int{
         var l:int = loader.bytesAvailable;
         if(l){
            loader.readBytes(p, p.position, l);
         }
         return l;
      }
      
      //============================================================
      // <T>重置处理。</T>
      //============================================================
      public override function reset():void{
         super.reset();
         if(loader){
            loader.close();
            loader = null;
         }
         setup();
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         if(loader){
            loader.close();
            loader = null;
         }
      }
   }
}