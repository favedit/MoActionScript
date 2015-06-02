package mo.cm.console.resource
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>资源请求线程。</T>
   //============================================================
   public class FResourceRequestThread extends FThread
   {
      // 资源组集合
      public var groups:FLooper = new FLooper();
      
      // 资源集合
      public var resources:FLooper = new FLooper();
      
      //============================================================
      // <T>构造资源请求线程。</T>
      //============================================================
      public function FResourceRequestThread(){
         name = "common.resource.request.thread";
         countMin = 1;
         countMax = 16;
      }
      
      //============================================================
      // <T>请求一个加载资源组对象。</T>
      //
      // @param p:group 资源组对象
      //============================================================
      public function pushGroup(p:FResourceGroup):void{
         groups.push(p);
      }
      
      //============================================================
      // <T>请求一个加载资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function pushResource(p:FResource):void{
         resources.push(p);
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中不需要后续处理
      //    false: 表示当前处理中需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
         // 检测是否需要加载
         var g:FResourceGroup = groups.next();
         if(g){
            g.loadRequest();
            groups.remove();
            return false;
         }
         // 检测是否需要加载
         var r:FResource = resources.next();
         if(r){
            r.loadRequest();
            resources.remove();
            return false;
         }
         return true;
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return super.toString() + " (request=" + resources.count + ")";
      }
   }
}
