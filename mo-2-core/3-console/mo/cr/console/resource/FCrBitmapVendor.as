package mo.cr.console.resource
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   
   import mo.cm.encode.ECompress;
   import mo.cm.core.device.RFatal;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;

   //============================================================
   // <T>位图提供商。</T>
   //============================================================
   public class FCrBitmapVendor implements ICrBitmapVendor
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrBitmapVendor);
      
      // 压缩方式
      public var compressCd:String = ECompress.DeflateCode;

      //============================================================
      // <T>构造位图提供商。</T>
      //============================================================
      public function FCrBitmapVendor(){
      }

      //============================================================
      // <T>根据类型创建位图数据。</T>
      //
      // @param p:typeName 类型名称
      // @return 位图数据
      //============================================================
      public function createBitmap(p:String):FCrBitmapData{
         switch(p){
            case ECrBitmapData.IndexStr:
               return new FCrBitmapDataIndex();
            case ECrBitmapData.BlockIndexStr:
               return new FCrBitmapDataBlockIndex();
            case ECrBitmapData.JpgStr:
               return new FCrBitmapDataJpg();
         }
         RFatal.throwFatal("Unknown bitmap type. (type_name={1})", p);
         return null;
      }
      
      //============================================================
      // <T>解压一个图块。</T>
      //
      // @param pi:input 输入数据
      // @param po:output 输出数据
      //============================================================
      public function blockDecompress(pi:ByteArray, po:ByteArray):void{
         if(RLogger.debugAble){
            var ts:Number = new Date().time;
         }
         // 读取属性
         var l:int = pi.readInt();
         var a:Boolean = pi.readBoolean();
         var w:int = pi.readShort();
         var h:int = pi.readShort();
         // 读取调色板
         var p:Vector.<uint> = new Vector.<uint>();
         var pc:int = pi.readUnsignedShort();
         for(var pn:int = 0; pn < pc; pn++){
            p[pn] = pi.readUnsignedInt();
         }
         // 读取数据
         var v:int = 0;
         var n:int = w * h;
         if(a){
            if((n % 2) == 0){
               while((n -= 2) >= 0){
                  v = pi.readUnsignedInt();
                  po.writeInt(p[v & 0x000000FF] | (((v >> 8) << 24)));
                  po.writeInt(p[(v >> 16) & 0x000000FF] | (v  & 0xFF000000));
               }
            }else{
               while((n -= 1) >= 0){
                  v = pi.readUnsignedShort();
                  po.writeInt(p[v & 0x000000FF] | ((v >> 8) << 24));
               }
            }
         }else{
            if((n % 4) == 0){
               while((n-=4) >= 0){
                  v = pi.readUnsignedInt();
                  po.writeInt(p[v & 0x000000FF]);
                  po.writeInt(p[(v >> 8) & 0x000000FF]);
                  po.writeInt(p[(v >> 16) & 0x000000FF]);
                  po.writeInt(p[(v >> 24) & 0x000000FF]);
               }
            }else if((n % 2) == 0){
               while((n-=2) >= 0){
                  v = pi.readUnsignedShort();
                  po.writeInt(p[v & 0x000000FF]);
                  po.writeInt(p[(v >> 8)& 0x000000FF]);
               }
            }else{
               while((n-=1) >= 0){
                  po.writeUnsignedInt(p[pi.readUnsignedByte()]);
               }
            }
         }
         // 日志统计
         if(RLogger.debugAble){
            var te:Number = new Date().time;
            var t:Number = te - ts;
            if(t > 4){
               _logger.debug("blockDecompress", "Decode bitmap index data. (length={1}, size={2}x{3}, tick={4})", l, w, h, t);
            }
         }
      }
      
      //============================================================
      // <T>压缩一个图块到内存字节流。</T>
      //
      // @param p:bitmapData 位图数据
      // @return 字节数据
      //============================================================
      public function compressBitmap(p:BitmapData):ByteArray{
         var r:ByteArray = p.getPixels(p.rect);
         //r.compress(CompressionAlgorithm.DEFLATE);
         r.deflate();
         return r;
      }
      
      //============================================================
      // <T>从内存字节流解压一个图块。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      // @param pd:data 字节数据
      // @return 位图数据
      //============================================================
      public function uncompressBitmap(pw:int, ph:int, pd:ByteArray):BitmapData{
         // 解压数据
         //pd.uncompress(CompressionAlgorithm.DEFLATE);
         pd.inflate();
         // 创建位图
         var r:BitmapData = new BitmapData(pw, ph, true, 0);
         r.setPixels(r.rect, pd);
         return r;
      }
   }
}