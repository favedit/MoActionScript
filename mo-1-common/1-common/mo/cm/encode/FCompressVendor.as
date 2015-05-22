package mo.cm.encode
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.core.device.RFatal;
   import mo.cm.stream.IInput;

   //============================================================
   // <T>压缩提供商。</T>
   //============================================================
   public class FCompressVendor implements ICompressVendor
   {
      //============================================================
      // <T>构造压缩提供商。</T>
      //============================================================
      public function FCompressVendor(){
      }
      
      //============================================================
      // <T>从输入流中解压缩数据。</T>
      //
      // @param pi:input 输入数据
      // @param po:output 输出数据
      // @return 处理结果
      //============================================================
      public function decode(pi:IInput, po:ByteArray):Boolean{
         // 读取压缩类型
         var c:int = pi.readInt32();
         // 读取数据
         var l:int = pi.readInt32();
         pi.readBytes(po, 0, l);
         po.position = 0;
         po.endian = Endian.LITTLE_ENDIAN;
         // 解压缩处理
         if(ECompress.None == c){
            // 不处理
         }else if(ECompress.Deflate == c){
            po.inflate();
         }else if(ECompress.Lzma == c){
            RFatal.throwFatal("Unsupport.");
         }
         return true;
      }
   }
}