package mo.cr.io
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.encode.ECompress;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.FByteStream;
   import mo.cm.stream.IInput;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>分块数据处理流。</T>
   //============================================================
   public class FBlockStream extends FByteStream
   {
      private static var _logger:ILogger = RLogger.find(FBlockStream);
      
      // 压缩方式
      public var compressCd:int = ECompress.Deflate;
      
      // 数据总长度
      public var uncompressLength:uint;
      
      // 数据分块总数
      public var blockCount:int;
      
      // 当前块数
      public var blockCurrent:int;
      
      public var content:ByteArray = new ByteArray();
      
      public var contentDecode:ByteArray = new ByteArray();
      
      //============================================================
      public function FBlockStream(){
         content.endian = Endian.LITTLE_ENDIAN;
         contentDecode.endian = Endian.LITTLE_ENDIAN;
      }
      
      //============================================================
      // <T>写入数据。</T>
      //============================================================
      public function loadInput(p:IInput):void{
         var l:int = p.readInt32();
         p.readBytes(content, 0, l);
         content.position = 0;
         uncompressLength = content.readUnsignedInt();
         blockCount = content.readUnsignedInt();
      }
      
      //============================================================
      // <T>写入数据。</T>
      //============================================================
      public function write(bytes:ByteArray, offset:int = 0, length:int = 0):void{
         content.writeBytes(bytes, offset, length);
         content.position = 0;
         uncompressLength = content.readUnsignedInt();
         blockCount = content.readUnsignedInt();
      }
      
      //============================================================
      // <T>解析数据块。</T>
      //============================================================
      public function process():Boolean{
         // var ts:Number = new Date().time;
         var length:int = content.readUnsignedInt();
         contentDecode.length = 0;
         if(content.position + length > content.length){
            _logger.error("process", "Decode content stream invalid. (position={1}, length={2}, size={3})", content.position, length, content.length);
            throw new FFatalUnsupportError();
            //return false;
         }
         contentDecode.writeBytes(content, content.position, length);
         contentDecode.position = 0;
         //RCrConsole.resourceConsole.factory.dataDecompress(contentDecode, memory);
         content.position += length;
         if(++blockCurrent >= blockCount){
            memory.position = 0;
            return true;
         }
         return false;
      }
      
      //============================================================
      public override function clear():void{
         super.clear();
         blockCurrent = 0;
         content.clear();
         contentDecode.clear();
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         blockCurrent = 0;
         content.clear();
         content = null;
         contentDecode.clear();
         contentDecode = null;
      }
   }
}