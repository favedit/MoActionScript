package mo.cm.console.resource
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.console.loader.ELoader;
   import mo.cm.console.loader.FLoaderEvent;
   import mo.cm.console.loader.RLoader;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.lang.RString;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.FInput;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>资源组。</T>
   //============================================================
   public class FResourceGroup extends FObject implements IResource
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FResourceGroup);
      
      // 资源域代码
      public var domainCd:String;
      
      // 代码
      public var code:String;
      
      // 加载类型
      public var loaderCd:int;
      
      // 大小
      public var totalBytes:int;
      
      // 数据已请求
      public var requested:Boolean;
      
      // 数据已加载
      public var loaded:Boolean;
      
      // 数据已准备好
      public var ready:Boolean;
      
      // 优先级别
      public var priority:int;
      
      // 加载器
      public var loader:FResourceLoader;
      
      // 资源集合
      public var resources:Vector.<FResource>;
      
      // 资源集合
      public var blockResources:Vector.<FResource>;
      
      // 资源块集合(必须按照Offset顺序放入，否则写入指针判断会错误)
      public var blocks:Vector.<FResourceBlock>;
      
      // 读取位置
      public var positionRead:int;
      
      // 写入位置
      public var positionWrite:int;
      
      // 数据内容
      public var data:ByteArray;
      
      // 数据内容
      public var version:int;
      
      // 测试时间
      public var lastTestTick:Number = 0;
      
      //============================================================
      // <T>构造资源分组。</T>
      //============================================================
      public function FResourceGroup(){
         loaderCd = ELoader.Data;
      }
      
      //============================================================
      // <T>数据加载完成事件处理。</T>
      //
      // @param pt:type 类型
      // @param pc:code 代码
      //============================================================
      public function create(pt:String, pc:String):FResource{
         // 创建资源
         var r:FResource = RCmConsole.resourceConsole.vendor.create(domainCd, pt);
         r.groupCode = code;
         r.code = pc;
         r.typeName = pt;
         pushResource(r);
         // 放入缓冲
         RCmConsole.resourceConsole.pushResource(r);
         return r;
      }
      
      //============================================================
      // <T>资源组内资源是否全部准备完成。</T>
      //============================================================
      public function isReady():Boolean{
         if(!ready){
            return false;
         }
         var c:int = resources.length;
         for(var n:int = 0; n < c; n++){
            var r:FResource = resources[n] as FResource;
            if(!r.ready){
               return false;
            }
         }
         return true;
      }
      
      //============================================================
      // <T>获取资源组解压进度。</T>
      //============================================================
      public function get progress():Number{
         if(requested){
            if(loaded){
               // 加载完成
               //               var readyCount:int = 0;
               //               var c:int = resources.length;
               //               for(var n:int = 0; n < c; n++){
               //                  var r:FResource = resources[n] as FResource;
               //                  if(r && r.ready){
               //                     readyCount++;
               //                  }
               //               }
               //               if(c){
               //                  return (0.9 + readyCount / c * 0.1);
               //               }
               return 1;
            }else{
               // 加载中
               return loader.processRate;
            }
         }
         return 0;
      }
      
      //============================================================
      // <T>从资源组内根据代码查找资源。</T>
      //
      // @param p:code 代码
      // @return 资源
      //============================================================
      public function find(p:String):FResource{
         var c:int = resources.length;
         for(var n:int = 0; n < c; n++){
            var r:FResource = resources[n] as FResource;
            if(r.code == p){
               return r;
            }
         }
         return null;
      }
      
      //============================================================
      // <T>放入一个资源。</T>
      //
      // @param pr:resource 资源
      // @param pc:code 代码
      //============================================================
      public function pushResource(pr:FResource, pc:String = null):void{
         // 检查代码
         if(null == pc){
            pc = pr.code;
         }
         if(RString.isEmpty(pr.code)){
            RFatal.throwFatal("Resource code is empty.");
         }
         // 创建集合
         if(!resources){
            resources = new Vector.<FResource>();
         }
         // 增加资源
         var fr:FResource = find(pc);
         if(null != fr){
            if(fr != pr){
               RFatal.throwFatal("Resource is already exists in this group.");
            }
         }
         resources.push(pr);
      }
      
      //============================================================
      // <T>测试资源组内所有资源是否全部已请求。</T>
      //
      // @return 是否全部已请求
      //============================================================
      public function testRequested():Boolean{
         var c:int = resources.length
         for(var n:int = 0; n < c; n++){
            var r:FResource = resources[n] as FResource;
            if(!r.requested){
               return false;
            }
         }
         return true;
      }
      
      //============================================================
      // <T>测试资源组内所有资源是否全部准备完成。</T>
      //
      // @return 是否全部准备完成
      //============================================================
      public function testReady():Boolean{
         if(!ready){
            var c:int = resources.length
            for(var n:int = 0; n < c; n++){
               var r:FResource = resources[n] as FResource;
               if(!r.ready){
                  return false;
               }
            }
         }
         return true;
      }
      
      //============================================================
      // <T>测试资源组内所有资源是否全部失效。</T>
      //
      // @return 是否全部失效
      //============================================================
      public function testInvalid():Boolean{
         var r:Boolean = false;
         // 检查间隔
         if(RTimer.currentTick - lastTestTick > 100){
            lastTestTick = RTimer.currentTick;
            // 设置信息
            var rr:Boolean = false;
            var rv:Boolean = true;
            var c:int = resources.length
            for(var n:int = 0; n < c; n++){
               var rs:FResource = resources[n] as FResource;
               if(!rr){
                  rr = rs.ready;
               }
               if(rv){
                  rv = !rs.testValid()
               }
            }
            if(rr){
               r = rv;
            }
         }
         return r;
      }
      
      //============================================================
      // <T>测试是否有块准备好可以读取数据。</T>
      //
      // @return 是否有准备可以读取数据的块
      //============================================================
      public function testBlockValid():Boolean{
         var c:int = blocks.length;
         for(var n:int = 0; n < c; n++){
            var b:FResourceBlock = blocks[n];
            if(b.valid){
               return true;
            }
         }
         return false;
      }
      
      //============================================================
      // <T>提交资源。</T>
      //============================================================
      public function onRequest():void{
         loader.url = RCmConsole.resourceConsole.vendor.makeUrl(this);
         loader.priority = priority;
      }
      
      //============================================================
      // <T>请求资源组。</T>
      //============================================================
      public function request():void{
         if(!requested){
            // 创建加载器
            if(null != loader){
               RFatal.throwFatal("Resourc loader is already exists.");
            }
            loader = new FResourceLoader();
            loader.resource = this;
            // 开始请求处理
            onRequest();
            // 设置状态
            var c:int = resources.length;
            for(var n:int = 0; n < c; n++){
               var r:FResource = resources[n] as FResource;
               r.requested = true;
            }
            // 放入线程
            // 加载资源
            RCmConsole.resourceConsole.pushRequestGroup(this);
            requested = true;
         }
      }
      
      //============================================================
      // <T>请求资源组。</T>
      //============================================================
      public function loadRequest():void{
         // 加载资源
         RLoader.console(loaderCd).load(loader);
      }
      
      //============================================================
      // <T>请求资源组。</T>
      //============================================================
      public function requestMulti():void{
         if(!requested){
            var c:int = blocks.length;
            for(var n:int = 0; n < c; n++){
               var b:FResourceBlock = blocks[n];
            }
            // 创建加载器
            loader = new FResourceLoader();
            loader.resource = this;
            // 开始请求处理
            onRequest();
            // 加载资源
            RLoader.console(loaderCd).load(loader);
            // 设置状态
            requested = true;
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param p:input 数据内容
      //============================================================
      public function unserializeDefine(pd:FResourceDomain, pi:IInput):void{
         // 读取属性
         code = pi.readString();
         totalBytes = pi.readInt32();
         // 读取资源列表
         var c:int = pi.readInt32();
         blockResources = new Vector.<FResource>(c, true);
         for(var n:int = 0; n < c; n++){
            var ri:int = pi.readInt32();
            //var r:FResource = pd.resources.get(ri);
            //r.groupCode = code;
            //blockResources[n] = r;
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserialize(p:IInput):void{
         // 读取属性
         var cd:String = p.readString();
         if(code != cd){
            RFatal.throwFatal("Resource group code is invalid.");
         }
         var gn:String = p.readString();
         if(gn != "g"){
            RFatal.throwFatal("Resource group type is invalid.");
         }
         //............................................................
         // 读取资源列表
         var c:int = p.readInt16();
         for(var n:int = 0; n < c; n++){
            // 获得资源对象
            var r:FResource = resources[n];
            if(!r){
               RFatal.throwFatal("Resource is not exists.");
            }
            // 检查资源是否要重新读取
            var l:int = p.readInt32();
            if(r.loaded){
               // 略过当前资源
               p.skip(l);
            }else{
               // 读取数据块
               var d:ByteArray = new ByteArray();
               d.endian = Endian.LITTLE_ENDIAN;
               p.readBytes(d, 0, l);
               r.load(d, 0, l);
               d.clear();
               // 放入处理线程
               RCmConsole.resourceConsole.pushProcess(r);
            }
         }
      }
      
      //============================================================
      // <T>加载资源数据。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public function load(pd:ByteArray, po:int = 0, pl:int = -1):void{
         // 读取数据
         var i:FInput = new FInput(pd);
         unserialize(i);
         i.dispose();
         // 释放加载器
         loader.dispose();
         loader = null;
         // 设置状态
         loaded = true;
         ready = true;
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
      // <T>测试资源组内所有资源是否全部准备完成。</T>
      //
      // @return 是否全部准备完成
      //============================================================
      public function processBlockValid():void{
         // 写入块数据
         var c:int = blocks.length;
         for(var n:int = 0; n < c; n++){
            var b:FResourceBlock = blocks[n];
            if(b.valid){
               // 写入数据
               data.position = b.offset + b.positionRead;
               data.writeBytes(b.data, b.positionRead, b.positionWrite - b.positionRead);
               b.positionRead = b.positionWrite;
               // 计算位置
               if((positionWrite >= b.offset) && (positionWrite < b.offset + b.size)){
                  positionWrite = b.offset + b.positionRead;
               }
               b.valid = false;
            }
         }
         // 修正尾指针，防止后边数据块先完成错误
         for(n = 0; n < c; n++){
            b = blocks[n];
            if(b.ready){
               // 计算位置
               if((positionWrite >= b.offset) && (positionWrite < b.offset + b.size)){
                  positionWrite = b.offset + b.positionRead;
               }
            }
         }
         // 读取数据处理
         if(positionRead < positionWrite){
            var vl:int = positionWrite - positionRead;
            if(vl > 4){
               data.position = positionRead;
               var l:int = data.readInt();
               if(vl >= 4 + l){
                  // 读取数据块
                  var d:ByteArray = new ByteArray();
                  data.readBytes(d, 0, l);
                  // TODO:处理数据块
                  // ...
               }
            }
         }
      }
      
      //============================================================
      // <T>测试是否有块准备好可以读取数据。</T>
      //
      // @return 是否有准备可以读取数据的块
      //============================================================
      public function testBlockReady():Boolean{
         var c:int = blocks.length;
         for(var n:int = 0; n < c; n++){
            var b:FResourceBlock = blocks[n];
            if(b.valid){
               return true;
            }
         }
         return false;
      }
      
      //============================================================
      // <T>测试资源组内所有资源是否全部准备完成。</T>
      //
      // @return 是否全部准备完成
      //============================================================
      public function processBlockReady():void{
         ready = true;
      }
      
      //============================================================
      // <T>计算资源的进度。</T>
      //============================================================
      public function calculateProgress():Number{
         return 0;
      }
      
      //============================================================
      // <T>关闭资源。</T>
      //============================================================
      public function close():Boolean{
         // 关闭所有资源
         var i:int = 0;
         var c:int = resources.length
         for(var n:int = 0; n < c; n++){
            var r:FResource = resources[n];
            if(r.requested){
               if(r.ready){
                  r.close();
                  i++;
               }
            }else{
               i++;
            }
         }
         // 设置状态
         requested = false;
         loaded = false;
         ready = false;
         _logger.debug("close", "Close resource group. (domain={1}, code={2})", domainCd, code)
         return (i == c);
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         var c:int = resources.length;
         for(var n:int = 0; n < c; n++){
            var r:FResource = resources[n];
            r.dispose();
            resources[n] = null;
         }
         resources.length = 0;
         resources = null;
         super.dispose();
      }
   }
}