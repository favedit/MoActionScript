package mo.cr.console.queue
{
   import mo.cm.lang.FList;
   import mo.cm.system.RAllocator;
   import mo.cm.console.thread.FThread;
   
   //============================================================
   // <T>资源管理线程。</T>
   //============================================================
   public class FCrQueuePopThread extends FThread
   {
      //============================================================
      public function FCrQueuePopThread(){
         name = "core.queue.pop.thread";
         countMax = 1024;
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中还需要后续处理
      //    false: 表示当前处理中不需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
         // 获得处理完成对象
//         var q:ICrQueue = RCrLibrary.native.queueConsole.pop();
//         if(q){
//            q.onLoaded(this);
//         }
//         return (null != q);
         return true;
      }
   }
}