package mo.cr.console.physical
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>资源管理线程。</T>
   //============================================================
   public class FCrPhysicalThread extends FThread
   {
      // 跟踪循环器
      public var position:int;

      // 跟踪循环器
      public var count:int;

      // 跟踪循环器
      public var trackers:FLooper = new FLooper();
      
      //============================================================
      // <T>构造资源管理线程。</T>
      //============================================================
      public function FCrPhysicalThread(){
         countMax = 32;
         name = "core.physical.thread";
      }
      
      //============================================================
      // <T>增加一个资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function push(p:FCrPhysicalTracker):void{
         trackers.push(p);
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中不需要后续处理
      //    false: 表示当前处理中需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
         if(first){
            position = 0;
            count = trackers.count;
         }
         // 跟踪器处理
         var t:FCrPhysicalTracker = trackers.next();
         if(t){
            if(t.process()){
               trackers.remove();
            }
         }
         return (++position < count) ? trackers.isEmpty() : true;
      }
      
      //============================================================
      public override function toString():String{
         return name + " [load=" + trackers.count + "]";
      }
   }
}