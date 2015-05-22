package mo.cm.console.resource
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>资源线程。</T>
   //============================================================
   public class FResourceGroupThread extends FThread
   {
      // 资源组集合
      public var groups:FLooper = new FLooper();
      
      //============================================================
      // <T>构造资源线程。</T>
      //============================================================
      public function FResourceGroupThread(){
         name = "common.resource.group.thread";
         countMax = 256;
      }
      
      //============================================================
      // <T>增加一个加载资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function push(p:FResource):void{
         groups.push(p);
      }
      
      //============================================================
      // <T>比较资源对象优先级。</T>
      //
      // @param p:resource 资源对象
      // @return 比较优先级
      //============================================================
      public function sortResource(p:FResourceGroup):int{
         return p.priority;
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中不需要后续处理
      //    false: 表示当前处理中需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
         var r:Boolean = true;
         // 检测资源组加载
         var g:FResourceGroup = groups.nextSort(sortResource);
         if(g){
            if(g.testBlockValid()){
               g.processBlockValid();
            }
            if(g.testBlockReady()){
               g.processBlockReady();
               groups.remove();
            }
            r = false;
         }
         return r;
      }
      
      //============================================================
      public override function toString():String{
         return "core.resource.group.thread [group_count=" + groups.count + "]";
      }
   }
}