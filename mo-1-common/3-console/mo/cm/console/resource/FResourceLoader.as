package mo.cm.console.resource
{
   import mo.cm.console.loader.FContentLoader;
   import mo.cm.console.loader.FLoaderEvent;
   
   //============================================================
   // <T>资源加载器</T>
   //============================================================
   public class FResourceLoader extends FContentLoader
   {
      // 资源对象
      public var resource:IResource;
      
      // 加载过标志
      public var loaded:Boolean;
      
      //============================================================
      // <T>构造资源加载器</T>
      //
      // @param p:resource 资源
      //============================================================
      public function FResourceLoader(p:IResource = null){
         resource = p;
      }
      
      //============================================================
      // <T>加载资源事件</T>
      //
      // @param p:event 加载事件
      //============================================================
      public override function onLoadContent(p:FLoaderEvent):void{
         resource.loadContent(p);
         loaded = true;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         resource = null;
         super.dispose();
      }
   }
}
