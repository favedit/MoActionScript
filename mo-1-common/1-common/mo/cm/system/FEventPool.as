package mo.cm.system
{
   import mo.cm.lang.FList;
   import mo.cm.lang.FObject;
   
   public class FEventPool extends FObject
   {
      protected var _class:Class;
      
      protected var _events:FList = new FList();
      
      //============================================================
      public function FEventPool(cls:Class){
         _class = cls;
      }
      
      //============================================================
      public function create():FEvent{
         var event:FEvent = RAllocator.create(_class);
         return event;
      }
      
      //============================================================
      public function invoke(callback:Function):void{
         _events.reset();
         while(_events.next()){
            var event:FEvent = _events.current() as FEvent;
            if(callback(event)){
               _events.removeCurrent();
            }  
         }
      }
   }
}