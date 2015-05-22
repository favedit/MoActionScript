package mo.cr.ui.style
{
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;

   //============================================================
   // <T>样式组。</T>
   //============================================================
   public class FUiStyleGroup extends FObject
   {
      // 名称
      public var name:String;

      // 样式字典
      public var styles:FDictionary = new FDictionary();
      
      //============================================================
      // <T>构造样式组。</T>
      //============================================================
      public function FUiStyleGroup(){
      }
      
      //============================================================
      // <T>根据名称获得样式。</T>
      //
      // @param p:name 名称
      //============================================================
      public function get(p:String):FUiStyle{
         return styles.get(p);
      }

      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         // 加载属性
         name = p.get("name");
         // 加载列表
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Style")){
               var s:FUiStyle = new FUiStyle();
               s.loadConfig(x);
               styles.set(s.name, s);
            }
         }
      }
   }
}