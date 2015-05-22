package mo.cm.encode
{
   import flash.utils.ByteArray;
   
   import mo.cm.stream.IInput;

   //============================================================
   // <T>压缩提供接口。</T>
   //============================================================
   public interface ICompressVendor
   {
      //============================================================
      // <T>从输入流中解压缩数据。</T>
      //
      // @param pi:input 输入数据
      // @param po:output 输出数据
      // @return 处理结果
      //============================================================
      function decode(pi:IInput, po:ByteArray):Boolean;
   }
}