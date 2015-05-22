package mo.cm.console.transfer
{
   import mo.cm.console.loader.FLoader;
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>传输域。</T>
   //============================================================
   public class FTransferSource extends FObject
   {
      // 资源地址
      public var url:String;
      
      // 加载器集合
      public var loaders:Vector.<FLoader> = new Vector.<FLoader>();

      //============================================================
      // <T>构造传输域。</T>
      //============================================================
      public function FTransferSource(){
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置节点
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         url = p.value;
      }
   }
}