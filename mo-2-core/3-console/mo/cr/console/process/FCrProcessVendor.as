package mo.cr.console.process
{
   import flash.utils.ByteArray;
   
   import mo.cm.lang.FObject;

   //============================================================
   // <T>进程提供商。</T>
   //============================================================
   public class FCrProcessVendor extends FObject
   {
      //============================================================
      // <T>构造进程提供商。</T>
      //============================================================
      public function FCrProcessVendor(){
      }

      //============================================================
      // <T>创建进程对象。</T>
      //============================================================
      public function create(pc:String, pd:ByteArray):FCrProcess{
         return null;
      }
   }
}