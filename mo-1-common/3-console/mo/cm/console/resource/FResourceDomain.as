package mo.cm.console.resource
{
   import mo.cm.console.RCmConsole;
   import mo.cm.console.transfer.FTransferDomain;
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   
   //============================================================
   // <T>资源域。</T>
   //============================================================
   public class FResourceDomain extends FObject
   {
      // 名称
      public var code:String;
      
      // 资源组
      public var groups:FDictionary = new FDictionary();
      
      // 资源组
      public var resources:FDictionary = new FDictionary();
      
      // 传输器
      public var transfer:FTransferDomain;
      
      //============================================================
      // <T>构造资源域。</T>
      //============================================================
      public function FResourceDomain(){
      }
      
      //============================================================
      // <T>查找资源组。</T>
      //
      // @param p:code 资源组代码
      // @return 资源组
      //============================================================
      public function findGroup(p:String):FResourceGroup{
         return groups.get(p);
      }
      
      //============================================================
      // <T>同步资源组。</T>
      //
      // @param p:code 资源组代码
      // @return 资源组
      //============================================================
      public function syncGroup(p:String):FResourceGroup{
         var g:FResourceGroup = groups.get(p);
         if(!g){
            g = RCmConsole.resourceConsole.vendor.createGroup();
            g.domainCd = code;
            g.code = p;
            groups.set(p, g);
         }
         return g;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param p:input 数据内容
      //============================================================
      public function unserialize(p:IInput):void{
         // 获得资源控制台
         var c:FResourceConsole = RCmConsole.resourceConsole;
         var v:IResourceVendor = c.vendor;
         // 读取资源定义集合
         var rc:int = p.readInt32();
         for(var rn:int = 0; rn < rc; rn++){
            // 读取资源定义
            var rcd:String = p.readString();
            var rtp:String = p.readString();
            // 创建资源对象
            var r:FResource = v.create(code, rtp);
            r.domainCode = code;
            r.code = rcd;
            r.unserializeConfig(this, p);
            // 放入资源池
            resources.set(rcd, r);
            c.pushResource(r);
         }
         // 读取资源组定义集合
         var gc:int = p.readInt32();
         for(var gn:int = 0; gn < gc; gn++){
            var g:FResourceGroup = v.createGroup();
            g.domainCd = code;
            g.unserializeDefine(this, p);
            groups.set(g.code, g);
         }
      }
   }
}