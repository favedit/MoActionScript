package mo.cm.logger
{
   import mo.cm.system.FEvent;

   //============================================================
   // <T>日志事件对象。</T>
   //============================================================
   public class FLoggerEvent extends FEvent
   {
      // 级别
      public var levelCd:int;
      
      // 消息
      public var message:String;

      //============================================================
      // <T>构造日志事件对象。</T>
      //============================================================
      public function FLoggerEvent(){
      }
   }
}