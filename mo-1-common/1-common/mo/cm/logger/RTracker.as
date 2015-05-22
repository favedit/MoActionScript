package mo.cm.logger
{
   //============================================================
   // <T>跟踪器。</T>
   //============================================================
   public class RTracker
   {
      public static var threadCount:int = 0;
      
      public static var threadTotal:int = 0;
      
      public static var threadTick:int = 0;
      
      public static var monitorCount:int = 0;

      public static var monitorTotal:int = 0;

      public static var monitorTick:int = 0;

      public static var frame:FTracker = new FTracker();
      
      public static var frameEnter:FTracker = new FTracker();

      public static var frameExit:FTracker = new FTracker();

      public static var stage:FTracker = new FTracker();

      public static var event:FTracker = new FTracker();

      public static var core:FTracker = new FTracker();
      
      public static var thread:FTracker = new FTracker();
      
      public static var monitor:FTracker = new FTracker();

      public static var draw:FTracker = new FTracker();
      
      public static var gecore:FTracker = new FTracker();
      
      public static var listener:FTracker = new FTracker();
      
      public static var messageReceive:FTracker = new FTracker();
      
      public static var messageSend:FTracker = new FTracker();
      
      public static var sceneProcess:FTracker = new FTracker();
      
      public static var sceneUpdate:FTracker = new FTracker();
      
      public static var sceneDraw:FTracker = new FTracker();
      
      //============================================================
      // <T>构造跟踪器。</T>
      //============================================================
      public function RTracker(){
      }
      
      //============================================================
      // <T>帧重置处理。</T>
      //============================================================
      public static function frameReset():void{
         threadCount = 0;
         threadTotal = 0;
         threadTick = 0;
         monitorCount = 0;
         monitorTotal = 0;
         monitorTick = 0;
      }
      
      //============================================================
      // <T>重置处理。</T>
      //============================================================
      public static function reset():void{
         frame.reset();
         frameEnter.reset();
         frameExit.reset();
         event.reset();
         stage.reset();
         thread.reset();
         monitor.reset();
         messageReceive.reset();
         messageSend.reset();
      }
   }
}