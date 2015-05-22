package mo.cm.console.resource
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>资源加载线程。</T>
   //============================================================
   public class FResourceLoadThread extends FThread
   {
      // 资源控制台
      public var console:FResourceConsole;
      
      // 处理计数器
      public var processCounter:int = 0;
      
      // 加载集合
      public var resources:FLooper = new FLooper();
      
      //============================================================
      // <T>构造资源线程。</T>
      //============================================================
      public function FResourceLoadThread(){
         name = "common.resource.load.thread";
         countMin = 1;
         countMax = 64;
      }
      
      //============================================================
      // <T>增加一个加载资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      [Inline]
      public final function push(p:FResource):void{
         resources.push(p);
      }
      
      //============================================================
      // <T>比较资源对象优先级。</T>
      //
      // @param p:resource 资源对象
      // @return 比较优先级
      //============================================================
      public function sortResource(p:FResource):int{
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
         // 首次处理
         if(first){
            processCounter = resources.count;
         }
         // 检测是否需要加载
         var rs:FResource = resources.nextSort(sortResource);
         if(rs){
            var rl:FResourceLoader = rs.loader;
            if(rl){
               if(rl.loadError){
                  // 处理加载失败
                  resources.remove();
               }else if(rl.loaded){
                  // 处理资源组放入的资源数据
                  resources.remove();
                  console.pushProcess(rs);
               }
            }else if(rs.testLoaded()){
               rs.loadComplete();
               // 处理加载完成的资源
               resources.remove();
               console.pushProcess(rs);
            }
            processCounter--;
            r = false;
         }
         return (processCounter > 0) ? r : true;
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return super.toString() + " (load=" + resources.count + ")";
      }
   }
}