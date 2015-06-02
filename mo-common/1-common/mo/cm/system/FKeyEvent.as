package mo.cm.system
{
   import flash.events.KeyboardEvent;

   //============================================================
   // <T>按键事件对象。</T>
   //============================================================
   public class FKeyEvent extends FEvent
   {
      // 按键代码
      public var keyCode:uint;
      
      //============================================================
      // <T>构造按键事件对象。</T>
      //
      // @param pe:event 事件
      // @param ps:sender 发送者
      // @param pn:sender 发送名称
      //============================================================
      public function FKeyEvent(pe:* = null, ps:* = null, pn:String = null){
         super(pe, ps, pn);
         // 接收数据
         var e:KeyboardEvent = pe as KeyboardEvent;
         if(null != e){
            attach(e);
         }
      }
      
      //============================================================
      // <T>接收事件数据。</T>
      //
      // @param e:event 事件
      //============================================================
      public function attach(e:KeyboardEvent):void{
         keyCode = e.keyCode;
      }
   }
}