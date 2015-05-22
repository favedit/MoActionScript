package mo.cm.console.transfer
{
   import mo.cm.console.RCmConsole;
   import mo.cm.console.resource.FResource;
   import mo.cm.console.resource.FResourceGroup;
   import mo.cm.console.resource.RResource;
   import mo.cm.core.common.FConsole;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>传输控制台。</T>
   // <P>
   //    TransferData:   传输数据  （一个完整网络文件，拥有多个数据块，多个加载器）
   //    TransferBlock:  传输块    （一个传输数据中的一块连续数据，是数据的最小单位，所有测试都以一个传输块为单位触发）
   //    TransferLoader: 加载器    （多个加载器同时加载一个传输数据，一个加载器完成，其他加载器必须放弃任务）
   //    Transfer:       传输器    （一个完整数据内容，最小单位由数据块构成，可以分布在多个传输数据中）
   // </P>
   //============================================================
   public class FTransferConsole extends FConsole
   {
      // 资源提供商接口
      public var vendor:ITransferVendor;

      // 传输域集合
      public var sources:Vector.<FTransferSource> = new Vector.<FTransferSource>();
      
      // 资源域集合
      public var domains:Vector.<FTransferDomain> = new Vector.<FTransferDomain>();
      
      // 传输线程
      public var thread:FTransferThread = new FTransferThread();
      
      //============================================================
      // <T>构造传输控制台。</T>
      //============================================================
      public function FTransferConsole(){
         name = "common.transfer.console";
      }
      
      //============================================================
      // <T>同步一个资源域。</T>
      //
      // @param p:name 名称
      // @return 资源域
      //============================================================
      public function syncDomain(p:String):FTransferDomain{
         var d:FTransferDomain = null;
         // 查找资源域
         var c:int = domains.length;
         for(var n:int = 0; n < c; n++){
            d = domains[n];
            if(d.code == p){
               return d;
            }
         }
         // 创建资源域
         d = new FTransferDomain();
         d.code = p;
         domains.push(d);
         return d;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置节点
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 读取设置
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++ ){
            var x:FXmlNode = p.node(n);
            if(x.isName("Source")){
               var s:FTransferSource = new FTransferSource();
               s.loadConfig(x);
               sources.push(s);
            }
         }
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         super.setup();
         RCmConsole.threadConsole.start(thread);
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置节点
      //============================================================
      public function loadTransfer(p:FTransfer):void{
         // 放入线程
         if(!p.loading){
            thread.transfers.push(p);
            p.loading = true;
         }
         // 获得传输块
         var bc:int = p.blocks.length;
         for(var bn:int = 0; bn < bc; bn++){
            var b:FTransferBlock = p.blocks[bn];
            var d:FTransferData = b.data;
            if(!d.loading){
               // 创建传输加载器
               var sc:int = sources.length;
               for(var sn:int = 0; sn < sc; sn++){
                  // 获得来源
                  var td:FTransferSource = sources[sn];
                  // 创建加载器
                  var l:FTransferContent = new FTransferContent();
                  l.data = d;
                  l.url = vendor.makeUrl(td, d);
                  d.pushLoader(l);
                  // 加载数据
                  RCmConsole.loaderConsole.load(l);
                  // 不使用传输器时，单来源加载
                  if(!RResource.optionTransfer){
                     break;
                  }
               }
               d.load();
            }
         }
      }
      
      //============================================================
      // <T>加载资源。</T>
      //
      // @param p:resource 资源
      //============================================================
      public function loadResource(p:FResource):void{
      }
      
      //============================================================
      // <T>加载资源组。</T>
      //
      // @param p:resourceGroup 资源组
      //============================================================
      public function loadResourceGroup(p:FResourceGroup):void{
//         // 创建传输器
//         var t:FTransfer = new FTransfer();
//         var bc:int = p.blocks.length;
//         for(var bn:int = 0; bn < bc; bn++){
//            var b:FResourceBlock = p.blocks[bn];
//            // 创建传输块
//            var tb:FTransferBlock = new FTransferBlock();
//            var dc:int = domains.length;
//            for(var dn:int = 0; dn < dc; dn++){
//               var d:FTransferDomain = domains[dn];
//               // 创建加载器
//               var l:FTransferLoader = new FTransferLoader();
//               l.block = tb;
//               t.pushLoader(l);
//            }
//            t.pushBlock(tb);
//         }
      }
   }
}