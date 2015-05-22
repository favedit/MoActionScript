package mo.cr.ui.common
{
   import mo.cm.console.thread.FThread;

   //============================================================
   // <T>动画处理线程。</T>
   //
   // @return 执行结果
   //============================================================
   public class FUiPlayerThread extends FThread
   {
      public var plays:Vector.<FUiPlayer> = new Vector.<FUiPlayer>();
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @return 执行结果
      //============================================================
      public function FUiPlayerThread(){
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return 执行结果
      //============================================================
      public override function execute():Boolean{
         for each(var n:FUiPlayer in plays){
            if(n.playing){
               n.process();
            }
         }
         return true;
      }
   }
}