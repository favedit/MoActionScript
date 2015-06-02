package mo.cm.system
{
   import mo.cm.lang.FMap;
   
   public class REvent
   {
      protected static var _objects:FMap = new FMap();
      
      //============================================================
      public static function findPool(cls:Class):FEventPool{
         var name:String = "" + cls;
         var pool:FEventPool = _objects.get(name) as FEventPool;
         if(null == pool){
            pool = new FEventPool(cls);
            _objects.set(name, pool);
         }
         return pool;
      }
      
      //============================================================
      public static function create(cls:Class):FEvent{
         var pool:FEventPool = findPool(cls);
         return pool.create();
      }
      
      //============================================================
      public static function invoke(cls:Class, callback:Function):void{
         var pool:FEventPool = findPool(cls);
         pool.invoke(callback);
      }

      //============================================================
      public static function process():void{
      }
   }
}