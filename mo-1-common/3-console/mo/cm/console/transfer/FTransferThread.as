package mo.cm.console.transfer
{
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>传输线程。</T>
   //============================================================
   public class FTransferThread extends FThread
   {
      // 传输器集合
      public var transfers:FLooper = new FLooper();
      
      //============================================================
      // <T>构造传输线程。</T>
      //============================================================
      public function FTransferThread(){
         name = "common.transfer.thread";
         countMin = 64;
         countMax = 1024;
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return true:处理已经完毕
      //         false:处理未完成，如果还有空闲时间，继续执行
      //============================================================
      public override function execute():Boolean{
         var r:Boolean = true;
         if(first){
            transfers.record();
         }
         var t:FTransfer = transfers.next();
         if(t){
            if(t.testReady()){
               t.complete();
               transfers.remove();
               r = false;
            }
         }
         return r;
      }
   }
}