package mo.cm.console.transfer
{
   import mo.cm.lang.FObject;
   import mo.cm.system.FFatalUnsupportError;
   
   //============================================================
   // <T>传输提供商。</T>
   //============================================================
   public class FTransferVendor extends FObject implements ITransferVendor
   {
      //============================================================
      // <T>构造传输提供商。</T>
      //============================================================
      public function FTransferVendor(){
      }
      
      //============================================================
      // <T>生成网络地址。</T>
      //
      // @param ps:transferSource 传输来源
      // @param pd:transferData 传输数据
      //============================================================
      public function makeUrl(ps:FTransferSource, pd:FTransferData):String{
         throw new FFatalUnsupportError();
      }

      //============================================================
      // <T>创建传输器。</T>
      //
      // @return 传输器
      //============================================================
      public function createTransfer():FTransfer{
         return new FTransfer();
      }
   }
}