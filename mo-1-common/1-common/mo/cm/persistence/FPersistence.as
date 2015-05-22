package mo.cm.persistence
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>构造持久化对象。</T>
   //============================================================
   public class FPersistence extends FObject implements IPersistence
   {
      //============================================================
      // <T>构造持久化对象。</T>
      //============================================================
      public function FPersistence(){
      }
      
      //============================================================
      // <T>获得持久化键。</T>
      //
      // @return 持久化键
      //============================================================
      public function get persistenceKey():String{
         return null;
      }
      
      //============================================================
      // <T>读取持久化数据。</T>
      //
      // @param p:storage 持久化数据
      // @return 处理结果
      //============================================================
      public function persistenceRead(p:Object):Boolean{
         return false;
      }
      
      //============================================================
      // <T>写入持久化数据。</T>
      //
      // @param p:storage 持久化数据
      // @return 处理结果
      //============================================================
      public function persistenceWrite(p:Object):Boolean{
         return false;
      }
   }
}