package mo.cm.console.resource
{
   import mo.cm.console.RCmConsole;
   import mo.cm.console.common.EDomain;
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FLooper;
   import mo.cm.lang.FString;
   import mo.cm.lang.RInteger;
   import mo.cm.lang.RString;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>资源控制台。</T>
   //============================================================
   public class FResourceConsole extends FConsole
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FResourceConsole);
      
      // 资源数据提供商接口
      public var vendorData:IResourceDataVendor = new FResourceDataVendor();
      
      // 资源提供商接口
      public var vendor:IResourceVendor;
      
      // 资源域集合
      public var domains:Vector.<FResourceDomain> = new Vector.<FResourceDomain>();
      
      // 资源信息
      public var info:SResourceInfo = new SResourceInfo();
      
      // 资源集合
      public var resources:FDictionary = new FDictionary();
      
      // 资源集合
      public var resourceItems:Vector.<FResource> = new Vector.<FResource>();
      
      // 资源组集合
      public var resourceGroups:FDictionary = new FDictionary();
      
      // 内容集合
      public var contents:FDictionary = new FDictionary();
      
      // 资源请求线程
      public var threadRequest:FResourceRequestThread = new FResourceRequestThread();
      
      // 资源加载线程
      public var threadLoad:FResourceLoadThread = new FResourceLoadThread();
      
      // 资源处理线程
      public var threadProcess:FResourceProcessThread = new FResourceProcessThread();
      
      // 资源检查线程
      public var threadCheck:FResourceCheckThread = new FResourceCheckThread();
      
      // 资源流线程
      public var threadStream:FResourceStreamThread = new FResourceStreamThread();
      
      // 资源集合
      public var resourceVector:Vector.<FResource> = new Vector.<FResource>();
      
      //============================================================
      // <T>构造资源控制台。</T>
      //============================================================
      public function FResourceConsole(){
         name = "common.resource.console";
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         super.setup();
         threadLoad.console = this;
         RCmConsole.threadConsole.start(threadRequest);
         RCmConsole.threadConsole.start(threadLoad);
         RCmConsole.threadConsole.start(threadProcess);
         RCmConsole.threadConsole.start(threadCheck);
         RCmConsole.threadConsole.start(threadStream);
      }
      
      //============================================================
      // <T>获得资源信息。</T>
      //
      // @return 资源信息
      //============================================================
      public function updateInfo():SResourceInfo{
         info.reset();
         if(null != resources){
            // 信息设置
            info.count = resources.count;
            info.loadingCount = threadLoad.resources.count;
            //info.processCount = threadProcess.resourceTotal;
            info.validCount = threadCheck.resources.count;
            // 计算总计
            var t:int = 0;
            var rl:FLooper = threadCheck.resources;
            var rc:int = rl.count;
            resourceVector.length = 0;
            for(var n:int = 0; n < rc; n++){
               var r:FResource = rl.next() as FResource;
               if(-1 == resourceVector.indexOf(r)){
                  var ti:SResourceTypeInfo = info.types.get(r.typeName);
                  if(null == ti){
                     ti = new SResourceTypeInfo();
                     if(RString.isEmpty(r.typeName)){
                        RFatal.throwFatal("Unknown resource type name.");
                     }
                     info.types.set(r.typeName, ti);
                  }
                  if(r.ready){
                     ti.readyCount++;
                  }
                  ti.count++;
                  ti.totalBytes += r.totalBytes;
                  ti.memoryBytes += r.calculateMemoryBytes();
                  t += r.totalBytes
                  resourceVector.push(r);
               }
            }
            //            // 计算总计
            //            var t:int = 0;
            //            var c:int = resourceItems.length;
            //            for(var n:int = 0; n < c; n++){
            //               var r:FResource = resourceItems[n];
            //               if(null != r){
            //                  var ti:SResourceTypeInfo = info.types.get(r.typeName);
            //                  if(null == ti){
            //                     ti = new SResourceTypeInfo();
            //                     if(RString.isEmpty(r.typeName)){
            //                        RFatal.throwFatal("Unknown resource type name.");
            //                     }
            //                     info.types.set(r.typeName, ti);
            //                  }
            //                  if(r.ready){
            //                     ti.readyCount++;
            //                  }
            //                  ti.count++;
            //                  ti.totalBytes += r.totalBytes;
            //                  t += r.totalBytes
            //               }
            //            }
            //            info.totalBytes = t;
         }
         return info;
      }
      
      //============================================================
      // <T>同步一个资源域。</T>
      //
      // @param p:name 名称
      // @return 资源域
      //============================================================
      public function findDomain(p:String):FResourceDomain{
         var c:int = domains.length;
         for(var n:int = 0; n < c; n++){
            var d:FResourceDomain = domains[n];
            if(d.code == p){
               return d;
            }
         }
         return null;
      }
      
      //============================================================
      // <T>同步一个资源域。</T>
      //
      // @param p:name 名称
      // @return 资源域
      //============================================================
      public function syncDomain(p:String):FResourceDomain{
         var d:FResourceDomain = null;
         // 查找资源域
         var c:int = domains.length;
         for(var n:int = 0; n < c; n++){
            d = domains[n];
            if(d.code == p){
               return d;
            }
         }
         // 创建资源域
         d = vendor.createDomain();
         d.code = p;
         domains.push(d);
         return d;
      }
      
      //============================================================
      // <T>查找一个资源组。</T>
      //
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源组
      //============================================================
      public function findGroup(pc:String, pd:String = EDomain.D2):FResourceGroup{
         var d:FResourceDomain = findDomain(pd);
         if(null != d){
            return d.findGroup(pc);
         }
         return null;
      }
      
      //============================================================
      // <T>同步一个资源组。</T>
      //
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源组
      //============================================================
      public function syncGroup(pc:String, pd:String = EDomain.D2):FResourceGroup{
         // 检查参数
         if(!pc){
            RFatal.throwFatal("Resource group code is empty.");
         }
         // 获得资源组
         var d:FResourceDomain = syncDomain(pd);
         var g:FResourceGroup = d.syncGroup(pc);
         if(null != g){
            if(!g.requested){
               g.request();
            }
         }
         // 更新资源
         return g;
      }
      
      //============================================================
      // <T>同步一个资源组。</T>
      //
      // @param pi:id 编号
      // @param pd:domainName 主域名称
      // @return 资源组
      //============================================================
      public function syncGroupById(pi:int, pd:String = EDomain.D2):FResourceGroup{
         if(pi > 0){
            return syncGroup(pi.toString(), pd);
         }
         return null;
      }
      
      //============================================================
      // <T>放入一个资源组到资源池。</T>
      //
      // @param pr:resourceGroup 资源组
      // @param pc:code 代码
      //============================================================
      public function pushGroup(pg:FResourceGroup, pc:String = null):void{
         // 检查代码
         if(null == pc){
            pc = pg.code;
         }
         if(RString.isEmpty(pc)){
            RFatal.throwFatal("Resource group code is empty.");
         }
         // 按照代码添加
         var c:String = pg.domainCd + "|" + pc;
         var g:FResourceGroup = resourceGroups.get(c);
         if(null != g){
            if(g != pg){
               RFatal.throwFatal("Resource group is already exists.");
            }
         }
         resourceGroups.set(c, pg);
      }
      
      //============================================================
      // <T>查找一个资源。</T>
      //
      // @param pt:typeName 类型名称
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源
      //============================================================
      public function findResource(pt:String, pc:String, pd:String = EDomain.D2):*{
         // 检查参数
         if(!pt){
            RFatal.throwFatal("Resource type is empty.");
         }
         if(!pc){
            RFatal.throwFatal("Resource code is empty.");
         }
         // 获得资源
         var c:String = pd + "|" + pt + "|" + pc;
         return resources.get(c);
      }
      
      //============================================================
      // <T>同步一个资源。</T>
      //
      // @param pt:typeName 类型名称
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源
      //============================================================
      public function syncResource(pt:String, pc:String, pd:String = EDomain.D2):*{
         // 检查参数
         if(!pt){
            RFatal.throwFatal("Resource type is empty.");
         }
         if(!pc){
            RFatal.throwFatal("Resource code is empty.");
         }
         // 获得资源
         var c:String = pd + "|" + pt + "|" + pc;
         var r:FResource = resources.get(c);
         // 创建资源
         if(!r){
            r = vendor.create(pd, pt);
            r.code = pc;
            resources.set(c, r);
            if(-1 == resourceItems.indexOf(r)){
               resourceItems.push(r);
            }
            _logger.debug("syncResource", "Resource is create. (type={1}, code={2})", pt, pc);
         }
         // 加载资源
         if(!r.requested){
            // 请求数据
            r.request();
         }
         // 更新资源
         r.update();
         return r;
      }
      
      //============================================================
      // <T>同步一个资源。</T>
      //
      // @param pt:typeName 类型名称
      // @param pi:id 编号
      // @param pd:domainName 主域名称
      // @return 资源域
      //============================================================
      public function syncById(pt:String, pi:int, pd:String = EDomain.D2):*{
         if(pi > 0){
            return syncResource(pt, pi.toString(), pd);
         }
         return null;
      }
      
      //============================================================
      // <T>同步一个图片资源。</T>
      //
      // @param pi:id 编号
      // @return 资源域
      //============================================================
      public function syncPictureById(pi:int):*{
         return syncResource(EResourceType.Picture, pi.toString(), EDomain.D2);
      }
      
      //============================================================
      // <T>同步一个内容。</T>
      //
      // @param p:url 内容
      // @return 内容
      //============================================================
      public function createContent(p:String):FContent{
         // 检查参数
         if(!p){
            RFatal.throwFatal("Content url is empty.");
         }
         // 创建资源
         var c:FContent = new FContent();
         c.url = p;
         _logger.debug("createContent", "Content is create. (url={1})", p);
         // 加载资源
         if(!c.requested){
            // 请求数据
            c.request();
         }
         return c;
      }
      
      //============================================================
      // <T>同步一个内容。</T>
      //
      // @param p:url 内容
      // @return 内容
      //============================================================
      public function syncContent(p:String):FContent{
         // 检查参数
         if(!p){
            RFatal.throwFatal("Content url is empty.");
         }
         // 获得资源
         var c:FContent = contents.get(p);
         // 创建资源
         if(!c){
            c = new FContent();
            c.url = p;
            resources.set(p, c);
            _logger.debug("syncContent", "Content is create. (url={1})", p);
         }
         // 加载资源
         if(!c.requested){
            // 请求数据
            c.request();
         }
         return c;
      }
      
      //============================================================
      // <T>同步一个内容。</T>
      //
      // @param p:url 内容
      // @return 内容
      //============================================================
      public function syncBitmapContent(p:String):FBitmapContent{
         // 检查参数
         if(!p){
            RFatal.throwFatal("Content url is empty.");
         }
         // 获得资源
         var c:FBitmapContent = contents.get(p);
         // 创建资源
         if(!c){
            c = new FBitmapContent();
            c.url = p;
            resources.set(p, c);
            _logger.debug("syncBitmapContent", "Bitmap content is create. (url={1})", p);
         }
         // 加载资源
         if(!c.requested){
            // 请求数据
            c.request();
         }
         return c;
      }
      
      //============================================================
      // <T>放入一个资源到资源池。</T>
      //
      // @param pr:resource 资源
      // @param pc:code 代码
      //============================================================
      public function pushResource(pr:FResource, pc:String = null):void{
         // 检查代码
         if(null == pc){
            pc = pr.code;
         }
         if(RString.isEmpty(pc)){
            RFatal.throwFatal("Resource code is empty.");
         }
         // 按照代码添加
         var c:String = pr.domainCode + "|" + pr.typeName + "|" + pc;
         var r:FResource = resources.get(c);
         if(null != r){
            if(r != pr){
               RFatal.throwFatal("Resource is already exists.");
            }
         }
         resources.set(c, pr);
      }
      
      //============================================================
      // <T>放入一个资源到资源池。</T>
      //
      // @param pr:resource 资源
      // @param pc:code 代码
      //============================================================
      [Inline]
      public final function pushResourceItem(pr:FResource):void{
         resourceItems.push(pr);
      }
      
      //============================================================
      // <T>增加一个请求资源组对象。</T>
      //
      // @param p:group 资源组对象
      //============================================================
      public function pushRequestGroup(p:FResourceGroup):void{
         threadRequest.pushGroup(p);
      }
      
      //============================================================
      // <T>增加一个请求资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function pushRequestResource(p:FResource):void{
         threadRequest.pushResource(p);
      }
      
      //============================================================
      // <T>增加一个加载资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function pushLoading(p:FResource):void{
         threadLoad.push(p);
      }
      
      //============================================================
      // <T>增加一个处理资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function pushProcess(p:FResource):void{
         threadProcess.push(p);
      }
      
      //============================================================
      // <T>增加一个检查资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function pushCheck(p:FResource):void{
         threadCheck.push(p);
      }
      
      //============================================================
      // <T>增加一个检查资源流对象。</T>
      //
      // @param p:stream 资源流对象
      //============================================================
      public function pushStream(p:FResourceStream):void{
         threadStream.push(p);
      }
      
      //============================================================
      // <T>调试比较处理。</T>
      //
      // @param p1:resource1 资源对象1
      // @param p2:resource1 资源对象2
      // @return 比较结果
      //============================================================
      public function dumpCompare(p1:FResource, p2:FResource):int{
         if(p1.groupCode > p2.groupCode){
            return 1;
         }else if(p1.groupCode == p2.groupCode){
            if(p1.code > p2.code){
               return 1;
            }else if(p1.code == p2.code){
               return 0;
            }else if(p1.code < p2.code){
               return -1;
            }
         }else if(p1.groupCode < p2.groupCode){
            return -1;
         }
         return 0;
      }
      
      //============================================================
      // <T>输出调试信息。</T>
      //============================================================
      public function dump():void{
         var s:FString = new FString();
         //         var gc:int = resourceGroups.count;
         //         for(var gn:int = 0; gn < gc; gn++){
         //            var g:FResourceGroup = resourceGroups.values[gn] as FResourceGroup;
         //            if(g.loaded){
         //               s.append("domain_code=" + g.domainCd);
         //               s.append(", group_code=" + g.code);
         //               s.append(", size=" + g.totalBytes);
         //               s.appendLine();
         //            }
         //         }
         resourceVector.length = 0;
         var rl:FLooper = threadCheck.resources;
         var rc:int = rl.count;
         for(var n:int = 0; n < rc; n++){
            var r:FResource = rl.next() as FResource;
            if(-1 == resourceVector.indexOf(r)){
               resourceVector.push(r);
            }
         }
         var c:int = resourceVector.length;
         resourceVector.sort(dumpCompare);
         for(n = 0; n < c; n++){
            r = resourceVector[n];
            s.append("domain_code=" + RString.rpad(r.domainCode, 2, " "));
            s.append(", group_code=" + RString.rpad(r.groupCode, 6, " "));
            s.append(", type=" + RString.rpad(r.typeName, 3, " "));
            s.append(", code=" + RString.rpad(r.code, 30, " "));
            s.append(", status=" + (r.ready ? "R" : "_") + (r.loaded ? "L" : "_"));
            s.append(", res_size=" + RInteger.formatMemoryPad(r.totalBytes, "m"));
            s.append(", mem_size=" + RInteger.formatMemoryPad(r.memoryBytes, "m"));
            s.append(", timeout=" + (RTimer.currentTick - r.updateTick) + "/" + r.timeout);
            s.append("\n");
         }
         trace(s.toString());
         //         var rc:int = resourceItems.length;
         //         for(var rn:int = 0; rn< rc; rn++){
         //            var r:FResource = resourceItems[rn];
         //            if(r.loaded){
         //               if(-1 == resourceVector.indexOf(r)){
         //                  s.append("domain_code=" + RString.rpad(r.domainCode, 2, " "));
         //                  s.append(", group_code=" + RString.rpad(r.groupCode, 6, " "));
         //                  s.append(", type=" + RString.rpad(r.typeName, 2, " "));
         //                  s.append(", code=" + RString.rpad(r.code, 9, " "));
         //                  s.append(", size=" + RInteger.formatMemory(r.totalBytes));
         //                  resourceVector.push(r);
         //               }
         //            }
         //         }
         //         trace(s.toString());
      }
   }
}