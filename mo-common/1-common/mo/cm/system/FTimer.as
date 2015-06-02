package mo.cm.system
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   import mo.cm.lang.FObject;
   
   public class FTimer extends FObject
   {
      public var timer:Timer;
      
      public var interval:uint = 1;
      
      public var lsnsTimer:FListeners = new FListeners();
      
      //============================================================
      public function FTimer(){
      }
      
      //============================================================
      public function onTimer(event:TimerEvent):void{
         lsnsTimer.process(new FTimerEvent(this, event));
      }
      
      //============================================================
      public function start():void{
         timer = new Timer(interval);
         timer.addEventListener(TimerEvent.TIMER, onTimer);
         timer.start();
      }
      
      //============================================================
      public function stop():void{
         if(null != timer){
            timer.stop();
         }
      }
   }  
}