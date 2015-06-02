package mo.cm.console.resource
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>资源处理线程。</T>
   //============================================================
   public class FResourceProcessThread extends FThread
   {
      // 资源字典
      public var types:FDictionary = new FDictionary(); 
      
      // 资源总数
      public var resourceTotal:int = 0;
      
      //============================================================
      // <T>构造资源线程。</T>
      //============================================================
      public function FResourceProcessThread(){
         name = "common.resource.process.thread";
         countMin = 1;
         countMax = 64;
      }
      
      //============================================================
      // <T>判断是否繁忙。</T>
      //
      // @return 是否繁忙
      //============================================================
      public override function testBusy():Boolean{
         return resourceTotal > 0;
      }
      
      //============================================================
      // <T>增加一个处理资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      [Inline]
      public final function push(p:FResource):void{
         var tn:String = p.typeName;
         var rl:FLooper = types.get(tn);
         if(null == rl){
            rl = new FLooper();
            types.set(tn, rl);
         }
         rl.push(p);
         resourceTotal++;
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
         // 重置
         if(first){
            RResource.processReset();
         }
         // 处理所有
         for(var i:int = 0; i < 4; i++){
            var p:Boolean = false; 
            // 选取资源
            var c:int = types.count;
            for(var n:int = 0; n < c; n++){
               var rl:FLooper = types.values[n] as FLooper;
               // 获得下一个资源
               var rs:FResource = rl.nextSort(sortResource);
               // 处理资源
               if(null != rs){
                  // 调整级别
                  if(rs.priority > 0){
                     rs.priority--;
                  }
                  if(rs.process()){
                     rl.remove();
                     rs.complete();
                     resourceTotal--;
                  }
                  // 是否还有需要处理的
                  if(!rl.isEmpty()){
                     r = false;
                  }
                  p = true;
               }
            }
            // 检查是否可以继续处理
            if(p){
               if(!RResource.processTest()){
                  break;
               }
            }else{
               break;
            }
         }
         return r;
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return super.toString() + " (process=" + resourceTotal + ")";
      }
   }
}
