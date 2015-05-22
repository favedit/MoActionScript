package mo.cr.ui
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.RSingleton;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.common.FUiPlayerConsole;
   import mo.cr.ui.physical.FUiPhysicalConsole;
   import mo.cr.ui.style.FUiStyleConsole;
   import mo.cr.ui.style.ICrStyleProvider;
   import mo.cr.ui.tip.ICrTipProvider;

   //============================================================
   // <T>界面管理器。</T>
   //============================================================
   public class RUiConsole extends RSingleton
   {
      // 工厂控制台
      public static var factory:FUiFactory = new FUiFactory();
      
      // 播放控制台
      public static var playerConsole:FUiPlayerConsole = new FUiPlayerConsole();
      
      // 焦点控制台
      public static var focusConsole:FUiFocusConsole = new FUiFocusConsole();
      
      // 样式控制台
      public static var styleConsole:FUiStyleConsole = new FUiStyleConsole();

      // 表单控制台
      public static var formConsole:FUiControlConsole = new FUiControlConsole();

      // 样式控制台
      public static var physicalConsole:FUiPhysicalConsole = new FUiPhysicalConsole();

      // 样式提供器
      public static var styleProvider:ICrStyleProvider;
      
      // 提示提供器
      public static var tipProvider:ICrTipProvider;
      
      //============================================================
      {
         name = "core.ui.singleton";
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public static function loadConfig(p:FXmlNode):void{
         RSingleton.loadConfig(p);
         var c:int = p.nodeCount; 
         var thread:FUiFactoryThread = new FUiFactoryThread();
         RCmConsole.threadConsole.start(thread);
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Console")){
               var name:String = x.get("name");
               switch(name){
                  case playerConsole.name:
                     playerConsole.loadConfig(x);
                     break;
                  case focusConsole.name:
                     focusConsole.loadConfig(x);
                     break;
                  case formConsole.name:
                     formConsole.loadConfig(x);
                     break;
               }
            }
         }
      }   
   }
}