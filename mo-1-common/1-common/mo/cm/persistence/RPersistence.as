package mo.cm.persistence
{
   import flash.net.SharedObject;
   
   //============================================================
   // <T>持久化管理器。</T>
   //============================================================
   public class RPersistence
   {
      protected static var _data:SharedObject = SharedObject.getLocal("local_storge");
      
      //============================================================
      // <T>初始化设置。.</T>
      //============================================================
      public static function setup(p:int = 10000000000):void{
         // 手动设定本地存储大小为无限制
         _data.flush(10000000000);
      }
      
      //============================================================
      // <T>生成持久化键值。</T>
      //
      // @param  
      //============================================================
      public static function makeKey(p:String):String{
         return "mo.persistence." + p;
      }

      //============================================================
      // <T>根据代码获得持久化对象。</T>
      //
      // @param p:persistence 持久化对象
      // @return 处理结果
      //============================================================
      public static function persistenceRead(p:IPersistence):Boolean{
         var k:String = makeKey(p.persistenceKey)
         var so:SharedObject = SharedObject.getLocal(k);
         return p.persistenceRead(so.data);
      }
      
      //============================================================
      // <T>存储持久化对象。</T>
      //
      // @param p:persistence 持久化对象
      // @return 处理结果
      //============================================================
      public static function persistenceWrite(p:IPersistence):Boolean{
         var k:String = makeKey(p.persistenceKey);
         var so:SharedObject = SharedObject.getLocal(k);
         var r:Boolean = p.persistenceWrite(so.data);
         so.flush();
         return r;
      }
   }
}