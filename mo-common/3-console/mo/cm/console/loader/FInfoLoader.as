package mo.cm.console.loader
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   import mo.cm.core.device.RGlobal;
   import mo.cm.lang.RString;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>信息数据加载器。</T>
   //============================================================
   public class FInfoLoader extends FLoader
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FInfoLoader); 
      
      // 打开标志
      public var isOpen:Boolean;
      
      // 加载器
      public var loader:Loader = new Loader();
      
      //============================================================
      // <T>构造信息数据加载器。</T>
      //============================================================
      public function FInfoLoader(){
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
      }
      
      //============================================================
      public function onContentComplete(event:Event):void{
         _logger.debug("onContentComplete", "Load content complete. (size={1}, url={2})",
            loader.contentLoaderInfo.bytesTotal, url);
         isOpen = false;
      }
      
      //============================================================
      // <T>权限错误事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onSecurityError(e:Event):void{
         _logger.debug("onSecurityError", "Raise io error. (url={1}, message={2})", uri, e);
         isOpen = false;
      }
      
      //============================================================
      public function onIoError(event:Event):void{
         _logger.debug("onIoError", "Raise io error. (url={1}, message={2})", url, event);
      }
      
      //============================================================
      public function onComplete(event:Event):void{
         onContentComplete(event);
         var le:FLoaderEvent = new FLoaderEvent();
         le.loader = this;
         le.sender = this;
         le.content = loader.content;
         lsnsComplete.process(le);
         le.dispose();
      }
      
      //============================================================
      public function get content():*{
         return loader.content;
      }
      
      //============================================================
      public function get contentType():String{
         return loader.contentLoaderInfo.contentType;
      }
      
      //============================================================
      // <T>加载指定地址的数据内容。</T>
      //
      // @param ps:source 来源地址
      // @param pp:params 参数几何
      //============================================================
      public override function load(ps:String, pp:String = null):void{
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
         tryCount = 0;
         loading = true;
         // 加载数据
         loader.load(new URLRequest(url));
      }
      
      //============================================================
      public function loadBytes(bytes:ByteArray):void{
         loader.loadBytes(bytes);
      }
      
      //============================================================
      public override function progress():Number{
         return 0;
      }
      
      //============================================================
      // <T>释放加载器对象。</T>
      //============================================================
      public override function dispose():void{
         // 释放内容
         try{
            //(_loader.content as dis).dispose();
         }catch(e : *){
         }
         // 卸载停止
         try{
            loader.unloadAndStop();
         }catch(e : *){
         }
         // 设置为不可见
         loader.visible = false;
      }
   }
}