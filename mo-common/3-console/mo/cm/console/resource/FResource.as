package mo.cm.console.resource
{
   import flash.utils.ByteArray;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.console.loader.ELoader;
   import mo.cm.console.loader.FLoaderEvent;
   import mo.cm.console.loader.RLoader;
   import mo.cm.console.transfer.FTransfer;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.lang.RString;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.FInput;
   import mo.cm.stream.IInput;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>基础资源。</T>
   //============================================================
   public class FResource extends FObject implements IResource
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FResource);
      
      // 加载类型
      public var loaderCd:int;
      
      // 主域类型
      public var domainCode:String;
      
      // 分组代码
      public var groupCode:String;
      
      // 代码
      public var code:String;
      
      // 类型名称
      public var typeName:String;
      
      // 校检代码
      public var verifyCode:int;
      
      // 数据大小
      public var totalBytes:int;
      
      // 内存大小
      public var memoryBytes:int;
      
      // 数据已请求
      public var requested:Boolean;
      
      // 数据已准备
      public var prepared:Boolean;
      
      // 数据已加载
      public var loaded:Boolean;
      
      // 数据已准备好
      public var ready:Boolean;
      
      // 超时时刻
      public var timeout:int;
      
      // 当前版本
      public var version:int;
      
      // 创建时刻
      public var createTick:Number;
      
      // 更新时刻
      public var updateTick:Number;
      
      // 优先级别
      public var priority:int;
      
      // 加载器
      public var loader:FResourceLoader;
      
      // 传输器
      public var transfer:FTransfer;
      
      // 完成监听
      public var lsnsComplete:FListeners;
      
      //============================================================
      // <T>构造资源。</T>
      //============================================================
      public function FResource(){
         loaderCd = ELoader.Data;
      }
      
      //============================================================
      // <T>获得关联的资源域。</T>
      //
      // @return 资源域
      //============================================================
      public function get domain():FResourceDomain{
         if(null != domainCode){
            return RCmConsole.resourceConsole.findDomain(domainCode);
         }
         return null;
      }
      
      //============================================================
      // <T>获得关联的资源域。</T>
      //
      // @return 资源域
      //============================================================
      public function get group():FResourceGroup{
         if((null != domainCode) && (null != groupCode)){
            return RCmConsole.resourceConsole.findGroup(groupCode, domainCode);
         }
         return null;
      }
      
      //============================================================
      // <T>计算实际内存大小。</T>
      //
      // @return 内存大小
      //============================================================
      public function calculateMemoryBytes():int{
         return memoryBytes;
      }
      
      //============================================================
      // <T>注册完成监听器。</T>
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
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param pd:domain 数据域
      // @param pi:input 输入流
      //============================================================
      public function unserializeConfig(pd:FResourceDomain, pi:IInput):void{
         transfer = RCmConsole.transferConsole.vendor.createTransfer();
         transfer.unserialize(pd.transfer, pi);
      }
      
      //============================================================
      // <T>测试资源是否加载完成。</T>
      //
      // @return 是否加载完成
      //============================================================
      public function testLoaded():Boolean{
         if(RResource.optionBlock && transfer){
            return transfer.ready;
         }
         return loaded;
      }
      
      //============================================================
      // <T>测试资源是否有效。</T>
      //
      // @return 是否有效
      //============================================================
      public function testValid():Boolean{
         if(ready){
            if(timeout > 0){
               var t:int = RTimer.currentTick - updateTick;
               if(t > timeout){
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      //============================================================
      // <T>请求资源处理。</T>
      //============================================================
      public function onRequest():void{
         createTick = RTimer.currentTick;
         loader.url = RCmConsole.resourceConsole.vendor.makeUrl(this);
         loader.priority = priority;
      }
      
      //============================================================
      // <T>加载事件处理。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public function onLoaded(pd:ByteArray, po:int, pl:int):void{
         prepared = true;
         loaded = true;
      }
      
      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function onProcess():Boolean{
         return true;
      }
      
      //============================================================
      // <T>完成事件处理。</T>
      //============================================================
      public function onComplete():void{
         ready = true;
      }
      
      //============================================================
      // <T>压缩资源处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function onCompress():Boolean{
         return true;
      }
      
      //============================================================
      // <T>解压资源处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function onUncompress():Boolean{
         return true;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function onFree():void{
      }
      
      //============================================================
      // <T>获得加载进度。</T>
      //
      // @return 加载进度
      //============================================================
      public function get progress():Number{
         if(loader){
            return loader.processRate;
         }
         return 0;
      }
      
      //============================================================
      // <T>加载完成。</T>
      //============================================================
      public function loadComplete():void{
         // 加载数据
         var s:FInput = new FInput(transfer.data);
         unserializeData(s);
         s.dispose();
         // 允许传输器释放资源
         transfer.free();
         loaded = true;
      }
      
      //============================================================
      // <T>需求资源。</T>
      //============================================================
      public function request():void{
         if(!requested){
            if(RResource.optionBlock && transfer){
               // 使用传输加载器
               RCmConsole.transferConsole.loadTransfer(transfer);
               // 放入线程
               RCmConsole.resourceConsole.pushLoading(this);
               RCmConsole.resourceConsole.pushCheck(this);
            }else if(RResource.optionGroup && !RString.isEmpty(groupCode)){
               _logger.debug("request", "Request resource group. (group_code={1}, resource_code={2})", groupCode, code);
               // 使用组加载器
               var g:FResourceGroup = RCmConsole.resourceConsole.syncGroup(groupCode, domainCode);
               g.request();
            }else{
               _logger.debug("request", "Request resource. (resource_code={1})", code);
               // 创建加载器
               if(null != loader){
                  RFatal.throwFatal("Loader is already exist.");
               }
               loader = new FResourceLoader(this);
               // 开始请求处理
               onRequest();
               // 加载资源
               RCmConsole.resourceConsole.pushRequestResource(this);
            }
            requested = true;
         }
      }
      
      //============================================================
      // <T>加载请求。</T>
      //============================================================
      public function loadRequest():void{
         // 加载资源
         RLoader.console(loaderCd).load(loader);
         // 放入线程
         RCmConsole.resourceConsole.pushLoading(this);
      }
      
      //============================================================
      // <T>校验有效性。</T>
      //
      // @param p:code 校验代码
      //============================================================
      public function verify(p:int):void{
         // 读取校验代码
         if(0 == verifyCode){
            verifyCode = p;
         }else if(verifyCode != p){
            if(RResource.optionVerify){
               RFatal.throwFatal("Resource verify code is invalid.");
            }
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化信息内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserializeInfo(p:IInput):void{
         // 检查是否关闭
         if(ready){
            RFatal.throwFatal("Resource is already.");
         }
         // 读取代码
         var c:String = p.readString();
         if(RString.isEmpty(code)){
            code = c;
         }else if(code != c){
            //RFatal.throwFatal("Resource code is invalid.");
         }
         // 读取类型
         var t:String = p.readString();
         if(RString.isEmpty(typeName)){
            typeName = t;
         }else if(typeName != t){
            RFatal.throwFatal("Resource type is invalid.");
         }
         // 读取超时
         timeout = EResourceTimeout.parse(p.readInt32());
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserializeData(p:IInput):void{
      }
      
      //============================================================
      // <T>加载资源数据。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public function load(pd:ByteArray, po:int = 0, pl:int = -1):void{
         onLoaded(pd, po, pl);
      }
      
      //============================================================
      // <T>加载资源事件</T>
      //
      // @param p:event 加载事件
      //============================================================
      public function loadContent(p:FLoaderEvent):void{
         var d:ByteArray = p.data;
         load(d, 0, d.length);
         loaded = true;
      }
      
      //============================================================
      // <T>资源处理。</T>
      //
      // @return 是否需要继续处理
      //============================================================
      public function process():Boolean{
         return onProcess();
      }
      
      //============================================================
      // <T>完成处理。</T>
      //============================================================
      public function complete():void{
         // 完成处理
         onComplete();
         // 更新处理
         update();
         // 完成处理
         if(ready){
            // 完成事件
            if(lsnsComplete){
               var e:FEvent = new FEvent();
               lsnsComplete.process(e);
               e.dispose();
            }
            // 释放加载器
            if(loader){
               loader.dispose();
               loader = null;
            }
         }
         // 放入检查线程
         RCmConsole.resourceConsole.pushCheck(this);
         // 显示加载信息
         if(RGlobal.sourceTrack){
            RCmConsole.progressConsole.showInfo("正在加载游戏数据。 (资源=" + code + ", 文件大小=" + totalBytes + ")", 95);
         }
         // 加载资源完成
         if(RLogger.debugAble){
            _logger.debug("complete", "Load resource complete. (domain={1}, group={2}, resource={3}, type={4}, length={5}, verify_code={6})",
               domainCode, groupCode, code, typeName, totalBytes, verifyCode);
         }
      }
      
      //============================================================
      // <T>更新处理。</T>
      //============================================================
      public function update():void{
         updateTick = RTimer.currentTick;
      }
      
      //============================================================
      // <T>关闭资源。</T>
      //
      // @return 处理结果
      //============================================================
      public function close():Boolean{
         // 检查状态
         if(!ready){
            RFatal.throwFatal("Resource is not ready.");
            return false;
         }
         if(RGlobal.isDebug){
            var ts:Number = new Date().time;
         }
         // 释放内容
         onFree();
         // 设置状态
         requested = false;
         loaded = false;
         ready = false;
         totalBytes = 0;
         if(RGlobal.isDebug){
            var te:Number = new Date().time;
            _logger.debugTrack("close", te - ts, "Close resource. (domain={1}, group={2}, code={3})", domainCode, groupCode, code);
         }
         return true;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         domainCode = null;
         groupCode = null;
         code = null;
         typeName = null;
         if(null != loader){
            loader.dispose();
            loader = null;
         }
         transfer = null;
         if(null != lsnsComplete){
            lsnsComplete.dispose();
            lsnsComplete = null;
         }
         super.dispose();
      }
   }
}