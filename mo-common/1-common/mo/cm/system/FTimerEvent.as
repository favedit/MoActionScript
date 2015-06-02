package mo.cm.system
{   
   import flash.events.TimerEvent;
   
   public class FTimerEvent extends FEvent
   {
      //============================================================
      public function FTimerEvent(psender:Object = null, pevent:TimerEvent = null){
         sender = psender;
         event = pevent;
      }      
   }
}