package mo.cm.console.resource
{
   import mo.cm.lang.FObject;
   import mo.cm.system.RAllocator;
   
   //============================================================
   // <T>资源数据提供商。</T>
   //============================================================
   public class FResourceDataVendor extends FObject implements IResourceDataVendor
   {
      //============================================================
      // <T>构造数据资源提供商。</T>
      //============================================================
      public function FResourceDataVendor(){
      }
      
      //============================================================
      // <T>创建数据流。</T>
      //
      // @return 数据流
      //============================================================
      public function createStream():FResourceStream{
         return RAllocator.alloc(FResourceStream);
      }
      
      //============================================================
      // <T>释放数据流。</T>
      //
      // @param p:stream 数据流
      //============================================================
      public function freeStream(p:FResourceStream):void{
         RAllocator.erase(FResourceStream, p);
      }
   }
}