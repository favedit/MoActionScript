package mo.cm.console.resource
{
   import mo.cm.lang.FObject;
   import mo.cm.system.FFatalUnsupportError;

   //============================================================
   // <T>资源提供商。</T>
   //============================================================
   public class FResourceVendor extends FObject implements IResourceVendor
   {
      //============================================================
      // <T>构造资源提供商。</T>
      //============================================================
      public function FResourceVendor(){
      }
      
      //============================================================
      // <T>创建资源域。</T>
      //
      // @return 资源域
      //============================================================
      public function createDomain():FResourceDomain{
         return new FResourceDomain();
      }
   
      //============================================================
      // <T>创建资源组。</T>
      //
      // @return 资源组
      //============================================================
      public function createGroup():FResourceGroup{
         return new FResourceGroup();
      }

      //============================================================
      // <T>创建资源对象。</T>
      //
      // @param pd:domainName 域名称
      // @param pt:typeName 类型名称
      // @return 资源对象
      //============================================================
      public function create(pd:String, pt:String):FResource{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      // <T>生成网络地址。</T>
      //
      // @param p:resource 资源
      //============================================================
      public function makeUrl(p:IResource):String{
         throw new FFatalUnsupportError();
      }
   }
}