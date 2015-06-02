package mo.cm.console.memory
{
   import mo.cm.console.thread.FInterval;
   
   //============================================================
   // <T>内存定时器。</T>
   //============================================================
   public class FMemoryInterval extends FInterval
   {
      //============================================================
      // <T>构造资源线程。</T>
      //============================================================
      public function FMemoryInterval(){
         name = "common.memory.interval";
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中不需要后续处理
      //    false: 表示当前处理中需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
//         // 获得类集合
//         var cs:FLooper = RClass.createLooper;
//         // 检测是否需要加载
//         var cp:FObjectPool = cs.next();
//         if(cp){
//            cp.process();
//         }
         return true;
      }
   }
}