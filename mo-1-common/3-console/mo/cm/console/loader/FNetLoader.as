package mo.cm.console.loader
{
   import flash.utils.ByteArray;
   
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>数据加载器。</T>
   //============================================================
   public class FNetLoader extends FObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FNetLoader);

      // 控制台
      public var console:FNetLoaderConsole;
      
      // 加载中标志
      public var loading:Boolean;

      // 状态类型
      public var statusCd:int;

      // 内容加载器
      public var content:FNetContent;

      // 字节加载
      public var bytesLoaded:int;
      
      // 字节全部
      public var bytesTotal:int;

      // 开始时刻
      public var beginTick:Number = 0;
      
      // 结束时刻
      public var endTick:Number = 0;
      
      // 加载时刻
      public var loadTick:Number = 0;

      // 最后读取时间
      public var lastTick:Number = 0;

      // 加载进度监听
      public var lsnsProgress:FListeners;
      
      // 完成监听列表
      public var lsnsComplete:FListeners;
      
      // 加载错误监听
      public var lsnsError:FListeners;
      
      // 附属内容
      public var tag:Object;
      
      //============================================================
      // <T>构造数据加载器。</T>
      //============================================================
      public function FNetLoader(){
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function setup():void{
      }
      
      //============================================================
      // <T>注册进度监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerProgress(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(!lsnsProgress){
            lsnsProgress = new FListeners(this);
         }
         return lsnsProgress.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注册进度监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerComplete(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(!lsnsComplete){
            lsnsComplete = new FListeners(this);
         }
         return lsnsComplete.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注册进度监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerError(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(!lsnsError){
            lsnsError = new FListeners(this);
         }
         return lsnsError.register(pm, po, pc);
      }
      
      //============================================================
      // <T>加载网络内容。</T>
      //
      // @param p:content 网络内容
      //============================================================
      public function load(p:FNetContent):void{
         content = p;
         // 检查是否已经打开
         if(loading){
            RFatal.throwFatal("Current loader is already opened.");
         }
      }
      
      //============================================================
      // <T>读取网络数据。</T>
      //
      // @param p:data 数据
      //============================================================
      public function readBytes(p:ByteArray):int{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      // <T>获得加载进度。</T>
      //
      // @return 加载进度
      //============================================================
      public function progress():Number{
         return (bytesTotal > 0) ? bytesLoaded / bytesTotal : 0;
      }
      
      //============================================================
      // <T>关闭处理。</T>
      //============================================================
      public function process():void{
         // 处理工作的加载器
         var t:Number = RTimer.realTick - lastTick;
         if(t > console.loadTimeout){
            // 修正超时次数
            content.timeoutCount++;
            _logger.debug("process", "Process loader timeout. (spend={1}, timeout={2}, count={3})", t, console.loadTimeout, content.timeoutCount);
            // 放回队列
            console.contents.push(content);
            content = null;
            // 重置处理
            reset();
         }
      }
      
      //============================================================
      // <T>重置处理。</T>
      //============================================================
      public function reset():void{
         loading = false;
      }
   
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         console = null;
         content = null;
         if(lsnsProgress){
            lsnsProgress.dispose();
            lsnsProgress= null;
         }
         if(lsnsComplete){
            lsnsComplete.dispose();
            lsnsComplete = null;
         }
         if(lsnsError){
            lsnsError.dispose();
            lsnsError = null;
         }
         tag = null;
      }
   }
}