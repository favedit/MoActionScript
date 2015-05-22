package mo.cr.ui
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.xml.FXmlNode;

   public class FUiFactoryConsole extends FConsole
   {  
      public var thread:FUiFactoryThread = new FUiFactoryThread();
      
      //============================================================
      // <T>构造UI控制台。</T>
      //============================================================
      public function FUiFactoryConsole(){
         name = "core.ui.factory";
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 启动线程
         RCmConsole.threadConsole.start(thread);
      }
   }
}