package mo.cm.system
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   import mo.cm.console.loader.FLoaderEvent;
   import mo.cm.core.device.RGlobal;
   import mo.cm.lang.FObject;
   import mo.cm.lang.FObjects;

   public class FGroupLoader extends FObject
   {
      protected var loaderEvent:FLoaderEvent;
      
      public var loader:Loader = new Loader();
      
      public var events:FObjects = new FObjects();

      public var lsnsLoaded:FListeners = new FListeners();

      public var lsnsComplete:FListeners = new FListeners();
      
      //============================================================
      public function FGroupLoader(){
      }
      
      //============================================================
      protected function onComplete(event:Event):void{
         // 加载成功一个资源
         loaderEvent.event = event;
         lsnsLoaded.process(loaderEvent);
         // 继续加载其他资源
         doLoad();
      }
      
      //============================================================
      protected function doLoad():void{
         if(!events.isEmpty()){
            loaderEvent = events.pop() as FLoaderEvent;
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            loader.load(new URLRequest(loaderEvent.url));
         }else{
            lsnsComplete.process(new FEvent());
         }
      }
      
      //============================================================
      public function push(event:FLoaderEvent):void{
         events.push(event);
      }
      
      //============================================================
      public function load():void{
         doLoad();
      }
   }
}