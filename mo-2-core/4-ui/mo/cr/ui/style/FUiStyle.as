package mo.cr.ui.style
{
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;

   //============================================================
   // <T>样式。</T>
   //============================================================
   public class FUiStyle extends FObject
   {
      // 名称
      public var name:String;
      
      //============================================================
      // <T>构建样式。</T>
      //============================================================
      public function FUiStyle(){
      }
   
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         name = p.get("name");
      }
   }
}