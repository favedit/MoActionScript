package mo.cm.console.resource
{
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>内容对象。</T>
   //============================================================
   public class FContent extends FObject
   {
      // 请求标志
      public var requested:Boolean;
      
      // 加载标志
      public var loaded:Boolean;
      
      // 准备标志
      public var ready:Boolean;
      
      // 加载结果
      public var result:Boolean;
      
      // 地址
      public var url:String;
      
      // 显示对象
      public var display:DisplayObject;
      
      // 加载器
      public var loader:Loader;
      
      //============================================================
      // <T>构造内容对象。</T>
      //============================================================
      public function FContent(){
      }
      
      //============================================================
      // <T>请求资源。</T>
      //============================================================
      public function request():void{
         if(null == loader){
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
            display = loader;
         }
         loader.load(new URLRequest(url));
         requested = true;
      }
      
      //============================================================
      // <T>加载完成事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onComplete(e:Event):void{
         loaded = true;
         ready = true;
      }
      
      //============================================================
      // <T>加载错误事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onIoError(e:Event):void{
         loaded = true;
         ready = false;
         result = false;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != loader){
            loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
            loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
            loader.unload();
            loader = null;
         }
         super.dispose();
      }
   }
}
