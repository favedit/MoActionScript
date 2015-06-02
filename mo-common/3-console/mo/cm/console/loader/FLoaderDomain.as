package mo.cm.console.loader
{
   import flash.net.URLRequest;
   
   import mo.cm.lang.FObject;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.FListeners;
   
   //============================================================
   // <T>数据域加载器。</T>
   //============================================================
   public class FLoaderDomain extends FObject
   {
      // 最大重试次数
      public static var RETRY_MAXCOUNT:int = 4;
      
      // 请求地址
      public var request:URLRequest = new URLRequest();
      
      // 完成监听列表
      public var lsnsComplete:FListeners;
      
      // 加载错误监听
      public var lsnsIoError:FListeners;
      
      // 加载进度监听
      public var lsnsProgressEvent:FListeners;
      
      // 访问相对地址
      public var uri:String;
      
      // 访问绝对地址
      public var url:String;
      
      // 加载中标志
      public var loading:Boolean;
      
      // 字节加载
      public var bytesLoaded:int;
      
      // 字节全部
      public var bytesTotal:int;
      
      // 超时时长
      public var timeout:Number = 30000;
      
      // 最后读取时间
      public var lastTick:Number = 0;
      
      // 加载尝试最大次数
      public var tryCount:int;
      
      // 内容加载器
      public var contentLoader:FContentLoader;
      
      // 附属内容
      public var tag:Object;
      
      // 加载中标志
      public var loaders:Vector.<FLoader> = new Vector.<FLoader>();
      
      //============================================================
      // <T>构造数据加载器。</T>
      //============================================================
      public function FLoaderDomain(){
         lsnsComplete = new FListeners(this);
         lsnsIoError = new FListeners(this);
         lsnsProgressEvent = new FListeners(this);
      }
      
      //============================================================
      // <T>处理数据内容。</T>
      //============================================================
      public function progress():Number{
         return (bytesTotal > 0) ? bytesLoaded / bytesTotal : 0;
      }
      
      //============================================================
      // <T>加载指定地址的数据内容。</T>
      //
      // @param p:url 网络地址
      //============================================================
      public function load(p:String):void{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      // <T>关闭处理。</T>
      //============================================================
      public function close():void{
         loading = false;
      }
   }
}