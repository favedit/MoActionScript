package mo.cr.console.resource
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>资源管理器。</T>
   //============================================================
   public class FCrResourceConsole extends FConsole
   {
      // 位图处理线程
      public var threadBitmap:FCrBitmapThread = new FCrBitmapThread();
      
      //============================================================
      // <T>构造资源管理器。</T>
      //============================================================
      public function FCrResourceConsole(){
         name = "core.resource.console";
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         super.setup();
         // 启动资源线程
         RCmConsole.threadConsole.start(threadBitmap);
      }

      //============================================================
      // <T>加入线程。</T>
      //============================================================
      public function processBitmap(p:FCrBitmapData):void{
         threadBitmap.push(p);
      }
   }
}