package mo.cr.console.resource
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;

   //============================================================
   // <T>位图提供商接口。</T>
   //============================================================
   public interface ICrBitmapVendor
   {
      //============================================================
      // <T>根据类型创建位图数据。</T>
      //
      // @param p:typeName 类型名称
      // @return 位图数据
      //============================================================
      function createBitmap(p:String):FCrBitmapData;
      
      //============================================================
      // <T>解压一个图块。</T>
      //
      // @param pi:input 输入数据
      // @param po:output 输出数据
      //============================================================
      function blockDecompress(pi:ByteArray, po:ByteArray):void;

      //============================================================
      // <T>压缩一个图块到内存字节流。</T>
      //
      // @param p:bitmapData 位图数据
      // @return 字节数据
      //============================================================
      function compressBitmap(p:BitmapData):ByteArray;

      //============================================================
      // <T>从内存字节流解压一个图块。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      // @param pd:data 字节数据
      // @return 位图数据
      //============================================================
      function uncompressBitmap(pw:int, ph:int, pd:ByteArray):BitmapData;
   }
}