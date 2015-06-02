package mo.cm.console.loader
{
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.RString;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>二进制数据加载器。</T>
   //============================================================
   public class FUrlLoader extends FLoader
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FUrlLoader);
      
      // 打开标志
      public var isOpen:Boolean;
      
      // 数据格式
      public var format:String = URLLoaderDataFormat.BINARY;
      
      // 加载器
      public var loader:URLLoader = new URLLoader();
      
      //加载进度
      public var loadProgess:Number = 0;
      
      //============================================================
      // <T>构造二进制数据加载器。</T>
      //============================================================
      public function FUrlLoader(){
         loader.addEventListener(Event.OPEN, onOpen);
         loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
         loader.addEventListener(ProgressEvent.PROGRESS, onProgess);
         loader.addEventListener(Event.COMPLETE, onContentComplete);
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
         loader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
      }
      
      //============================================================
      // <T>打开事件处理。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onOpen(e:Event):void{
         isOpen = true;
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
      public function onProgess(e:ProgressEvent):void{
         bytesLoaded = e.bytesLoaded;
         bytesTotal = e.bytesTotal;
         loadProgess = bytesLoaded / bytesTotal;
         lastTick = RTimer.realTick;
      }
      
      //============================================================
      // <T>内容加载完成事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onContentComplete(e:Event):void{
         _logger.debug("onContentComplete", "Load content complete. (size={1}, url={2})", loader.bytesLoaded, uri);
         isOpen = false;
         loading = false;
		 var data:* = null;
		 if(format == URLLoaderDataFormat.BINARY){
			 var bytes:ByteArray = loader.data;
			 bytes.endian = Endian.LITTLE_ENDIAN;
			 data = bytes;
		 }else{
			 data = loader.data;
		 }
         // 加载计时
         endTick = RTimer.getTick();
         loadTick = endTick - beginTick;
         RLoader.info.load(loader.bytesLoaded, loadTick);
         // 加载事件
         var event:FLoaderEvent = new FLoaderEvent();
		 event.loader = this;
         event.sender = this;
         event.data = data;
         if(onComplete(event)){
            if(null != lsnsComplete){
               lsnsComplete.process(event);
            }
         }
         // 释放资源
		 if(format == URLLoaderDataFormat.BINARY){
			 bytes = data as ByteArray;
			 data.clear();
		 }
         data = null;
         loader.data = null;
         loader.close();
         event.dispose();
         event = null;
      }
      
      //============================================================
      // <T>权限错误事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onSecurityError(e:Event):void{
         _logger.debug("onSecurityError", "Raise io error. (url={1}, message={2})", uri, e);
         loader.close();
         isOpen = false;
      }
      
      //============================================================
      // <T>流错误事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onIoError(e:IOErrorEvent):void{
         _logger.debug("onIoError", "Raise io error. (url={1}, message={2})", uri, e.text);
         isOpen = false;
         if(tryCount++ < RETRY_MAXCOUNT){
            loader.close();
            loader.load(new URLRequest(url));
         }else{
            loading = false;
            var le:FLoaderEvent = new FLoaderEvent();
            le.sender = this;
            if(null != lsnsIoError){
               lsnsIoError.process(le);
            }
            le.dispose();
            if(RGlobal.loggerFatal){
               _logger.fatal("onIoError", "Raise io error. (url={1})", uri);
            }else{
               throw new Error("Raise io error. (url=" + uri +")");
            }
         }
      }
      
      //============================================================
      // <T>完成事件处理。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onComplete(e:FLoaderEvent):Boolean{
         return true;
      }
      
      //============================================================
      // <T>加载指定地址的数据内容。</T>
      //
      // @param ps:source 来源地址
      // @param pp:params 参数几何
      //============================================================
      public override function load(ps:String, pp:String = null):void{
         // 检查是否已经打开
         if(loading || isOpen){
            RFatal.throwFatal("Current loader is already opened.");
         }
         // 计算网络地址
         if(RGlobal.modeFile){
            uri = ps;
         }else{
            if(null != pp){
               uri = ps + "?" + pp;
            }else{
               uri = ps;
            }
         }
         if(RString.startsWith(uri, "/")){
            url = RGlobal.sourceFullPath + uri; 
         }else{
            url = uri;
         }
         // 初始化参数
         loading = true;
         bytesLoaded = 0;
         bytesTotal = 0;
         tryCount = 0;
         beginTick = RTimer.getTick();
         lastTick = beginTick;
         // 加载数据
         loader.dataFormat = format;
         loader.load(new URLRequest(url));
         //_logger.debug("loadUrl", "Load url resource. (url={1})", url);
      }
      
      //============================================================
      // <T>关闭处理。</T>
      //============================================================
      public override function close():void{
         super.close();
         loader.close();
         isOpen = false;
      }
   }
}