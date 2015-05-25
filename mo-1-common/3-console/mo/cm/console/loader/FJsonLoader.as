package mo.cm.console.loader
{
   import flash.events.Event;
   import flash.net.URLLoaderDataFormat;
   
   import mo.cm.core.device.RTimer;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>二进制数据加载器。</T>
   //============================================================
   public class FJsonLoader extends FUrlLoader
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FJsonLoader);
      
      //============================================================
      // <T>构造二进制数据加载器。</T>
      //============================================================
      public function FJsonLoader(){
		  format = URLLoaderDataFormat.TEXT;
      }
      
      //============================================================
      // <T>内容加载完成事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public override function onContentComplete(e:Event):void{
         _logger.debug("onContentComplete", "Load content complete. (size={1}, url={2})", loader.bytesLoaded, uri);
         isOpen = false;
         loading = false;
		 // 解析数据
		 var source:String = loader.data;
		 var content:Object = JSON.parse(source);
         // 加载计时
         endTick = RTimer.getTick();
         loadTick = endTick - beginTick;
         RLoader.info.load(loader.bytesLoaded, loadTick);
		 // 加载事件
         var event:FLoaderEvent = new FLoaderEvent();
		 event.loader = this;
         event.sender = this;
         event.data = source;
		 event.content = content;
         if(onComplete(event)){
            if(null != lsnsComplete){
               lsnsComplete.process(event);
            }
         }
         // 释放资源
		 source = null;
		 this.loader.data = null;
         loader.close();
         event.dispose();
         event = null;
      }
   }
}