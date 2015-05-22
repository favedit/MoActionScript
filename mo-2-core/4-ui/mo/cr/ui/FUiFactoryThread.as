package mo.cr.ui
{
   import mo.cm.console.thread.FThread;

   public class FUiFactoryThread extends FThread
   {  
      public var context:FUiContext = new FUiContext();
      
      //============================================================
      // <T>构造界面处理线程。</T>
      //
      // @return 执行结果
      // @author HECNG 20120227
      //============================================================
      public function FUiFactoryThread(){
         name = "core.ui.factory.thread";
         countMax = 256;
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return 执行结果
      // @author HECNG 20120227
      //============================================================
      public override function execute():Boolean{ 
         var cs:Vector.<FUiControl3d> = RUiConsole.factory.controls;
         for(var n:int = cs.length - 1; n >= 0; n--){
            cs[n].process(context);
         }
         return true;
      }
   }
}