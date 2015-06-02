package mo.cm.console.loader
{
   import mo.cm.lang.FObject;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   
   //============================================================
   // <T>数据内容加载器。</T>
   //============================================================
   public class FContentLoader extends FObject
   {
      // 加载控制台
      public var console:FLoaderConsole;
      
      // 是否加载完成
      public var ready:Boolean;
      
      // 是否加载失败
      public var loadError:Boolean;
      
      // 是否被请求
      public var required:Boolean;
      
      // 超时次数
      public var timeoutCount:int = 0;

      // 网络地址
      public var url:String;
      
      // 优先权重 (值越大越先被加载)
      public var priority:int;
      
      // 加载器
      public var loader:FLoader;
      
      // 完成监听器
      public var lsnsComplete:FListeners;
      
      //============================================================
      // <T>构造数据内容加载器。</T>
      //============================================================
      public function FContentLoader(){
      }
      
      //============================================================
      // <T>注册一个完成监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerComplete(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null != lsnsComplete){
            lsnsComplete = new FListeners(this);
         }
         return lsnsComplete.register(pm, po, pc);
      }
      
      //============================================================
      // <T>获得加载源信息。</T>
      //
      // @return 加载源信息
      //============================================================
      public function get source():String{
         var f:int = url.indexOf("/");
         if(-1 == f){
            f = url.indexOf("\\");
         }
         if(-1 != f){
            return url.substr(f);
         }
         return "";
      }
      
      //============================================================
      // <T>请求加载资源。</T>
      //============================================================
      public function require():void{
         if(!required){
            console.load(this);
            required = true;
         }
      }
      
      //============================================================
      // <T>获取加载进度。</T>
      //============================================================
      public function get processRate():Number{
         if(loader){
            return loader.progress();
         }
         return 0;
      }

      //============================================================
      // <T>加载完成事件。</T>
      //
      // @param p:event 加载事件
      //============================================================
      public function onLoadContent(p:FLoaderEvent):void{
      }
      
      //============================================================
      // <T>加载内容。</T>
      //
      // @param p:event 加载事件
      //============================================================
      public function loadContent(p:FLoaderEvent):void{
         onLoadContent(p);
         // 完成处理
         if(lsnsComplete){
            lsnsComplete.process(p);
         }
         ready = true;
      }
   
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         console = null;
         url = null;
         loader = null;
         if(null != lsnsComplete){
            lsnsComplete.dispose();
            lsnsComplete = null;
         }
         super.dispose();
      }
   }
}