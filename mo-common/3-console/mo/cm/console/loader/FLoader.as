package mo.cm.console.loader
{
   import mo.cm.lang.FObject;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   
   //============================================================
   // <T>数据加载器。</T>
   //============================================================
   public class FLoader extends FObject
   {
      // 最大重试次数
      public static var RETRY_MAXCOUNT:int = 4;
      
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
      
      // 开始时刻
      public var beginTick:Number = 0;

      // 结束时刻
      public var endTick:Number = 0;

      // 加载时刻
      public var loadTick:Number = 0;

      // 最后读取时间
      public var lastTick:Number = 0;

      // 加载尝试最大次数
      public var tryCount:int;
      
      // 内容加载器
      public var contentLoader:FContentLoader;

      // 附属内容
      public var tag:Object;

      //============================================================
      // <T>构造数据加载器。</T>
      //============================================================
      public function FLoader(){
      }
      
      //============================================================
      // <T>注册一个完成监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function registerComplete(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsComplete){
            lsnsComplete = new FListeners(this);
         }
         return lsnsComplete.register(pm, po, pc);
      }

      //============================================================
      // <T>注册一个例外监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function registerIoError(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsIoError){
            lsnsIoError = new FListeners(this);
         }
         return lsnsIoError.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注册一个进度监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function registerProgressEvent(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsProgressEvent){
            lsnsProgressEvent = new FListeners(this);
         }
         return lsnsProgressEvent.register(pm, po, pc);
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
      // @param ps:source 来源地址
      // @param pp:params 参数几何
      //============================================================
      public function load(ps:String, pp:String = null):void{
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