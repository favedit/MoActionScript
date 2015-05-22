package mo.cr.ui.style
{
   import mo.cm.core.common.FConsole;
   import mo.cm.lang.FDictionary;
   import mo.cm.xml.FXmlNode;

   //============================================================
   // <T>样式控制台。</T>
   //============================================================
   public class FUiStyleConsole extends FConsole
   {
      // 样式组字典
      public var groups:FDictionary = new FDictionary();
      
      // 样式组字典
      public var activeGroup:FUiStyleGroup;

      //============================================================
      // <T>构造样式控制台。</T>
      //============================================================
      public function FUiStyleConsole(){
         name = "core.style.console";
      }
   
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function get(p:String):FUiStyle{
         return activeGroup.get(p);
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 加载列表
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Group")){
               var g:FUiStyleGroup = new FUiStyleGroup();
               g.loadConfig(x);
               groups.set(g.name, g);
               activeGroup = g;
            }
         }
      }
   }
}