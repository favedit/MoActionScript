package mo.cr.message
{
   import mo.cm.console.thread.FThread;
   
   //============================================================
   // <T>消息处理线程。</T>
   //============================================================
   public class FNetMessageThread extends FThread
   {
      // 消息链接
      public var connection:INetMessageConnection;
      
      //============================================================
      // <T>构造消息处理线程。</T>
      //============================================================
      public function FNetMessageThread(){
         name = "core.message.thread";
         countMin = 16;
         countMax = 256;
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中还需要后续处理
      //    false: 表示当前处理中不需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
         var result:Boolean = false;
         if(null != connection){
            result = connection.process()
         }
         return result;
      }     
   }
}