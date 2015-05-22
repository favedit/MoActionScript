package mo.cr.message
{
   import mo.cm.lang.FObject;

   public class FNetMessageQueue extends FObject
   {
      //============================================================
      public function FNetMessageQueue(){
      }

      //============================================================
      public function PushMessage(message:FNetMessage):void{
      }

      //============================================================
      public function PopupMessage():FNetMessage{
         return null;
      }

   }
}