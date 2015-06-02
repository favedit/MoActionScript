package mo.cm.console.resource
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>资源流处理线程。</T>
   //============================================================
   public class FResourceStreamThread extends FThread
   {
      // 资源流集合
      public var streams:FLooper = new FLooper();
      
      //============================================================
      // <T>构造资源流线程。</T>
      //============================================================
      public function FResourceStreamThread(){
         name = "common.resource.stream.thread";
         countMin = 1;
         countMax = 64;
      }
      
      //============================================================
      // <T>判断是否繁忙。</T>
      //
      // @return 是否繁忙
      //============================================================
      public override function testBusy():Boolean{
         return !streams.isEmpty();
      }
      
      //============================================================
      // <T>增加一个处理资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      [Inline]
      public final function push(p:FResourceStream):void{
         streams.push(p);
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
         // 选取资源
         var s:FResourceStream = streams.next();
         // 处理资源
         if(null != s){
            if(s.process()){
               streams.remove();
            }
            r = streams.isEmpty();
         }
         return r;
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return super.toString() + " (process=" + streams.count + ")";
      }
   }
}