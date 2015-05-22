package mo.cr.message
{
   import mo.cm.system.FEvent;

   //============================================================
   // <T>消息事件。</T>
   //============================================================
   public class FNetMessageEvent extends FEvent
   {
      // 消息
      public var message:FNetMessage;
      
      //============================================================
      // <T>构造消息事件。</T>
      //
      // @param p:message 消息
      //============================================================
      public function FNetMessageEvent(p:FNetMessage = null){
         message = p;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         message = null;
         super.dispose();
      }
   }
}