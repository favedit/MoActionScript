package mo.cm.console.resource
{
   import flash.utils.ByteArray;
   
   import mo.cm.cache.FCacheStream;
   import mo.cm.cache.RCache;
   import mo.cm.core.device.RFatal;
   import mo.cm.encode.ECompress;
   import mo.cm.lang.IPoolObject;
   import mo.cm.stream.FByteStream;
   
   //============================================================
   // <T>资源数据流。</T>
   //============================================================
   public class FResourceStream extends FByteStream implements IPoolObject
   {
      // 已加载
      public var loaded:Boolean;
      
      // 已准备
      public var ready:Boolean;
      
      // 压缩类型
      public var compressCd:int;
      
      // 分块大小
      public var blockSize:int;
      
      // 分块大小
      public var blockCount:int;
      
      // 分块位置
      public var blockCurrent:int;
      
      // 数据长度
      public var dataLength:int;
      
      // 校验代码
      public var verifyCode:int;
      
      // 数据
      public var stream:FByteStream = new FByteStream();
      
      //============================================================
      // <T>构造资源数据流。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public function FResourceStream(pd:ByteArray = null, po:int = 0, pl:int = -1){
         if(null != pd){
            load(pd, po, pl);
         }
      }
      
      //============================================================
      // <T>加载事件处理。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public function load(pd:ByteArray, po:int = 0, pl:int = -1):void{
         // 检查数据
         stream.writeBytes(pd, po, pl);
         stream.flip();
         // 读取设置
         compressCd = stream.readUint8();
         dataLength = stream.readInt32();
         verifyCode = stream.readInt32();
         blockSize = stream.readInt32();
         // 读取数据
         blockCount = stream.readInt32();
         blockCurrent = blockCount;
         // 设置数据长度
         memory.position = 0;
         memory.length = dataLength;
         loaded = true;
      }      
      
      //============================================================
      // <T>数据解压处理。</T>
      //
      // @param p:data 数据
      //============================================================
      public function uncompress(p:ByteArray):void{
         p.inflate();
      }
      
      //============================================================
      // <T>数据处理过程。</T>
      //
      // @return 处理结果
      //============================================================
      public function onProcess():Boolean{
         // 数据是否已经加载
         if(!loaded){
            return false;
         }
         // 处理未压缩
         if(ECompress.None == compressCd){
            var l:int = stream.readInt32(); 
            memory.writeBytes(stream.memory, stream.position, l);
            return true;
         }
         // 读取数据块
         if(blockCurrent > 0){
            // 解压数据快
            var dl:int = stream.readInt32();
            var cs:FCacheStream = RCache.allocStream(dl);
            stream.readBytes(cs.memory, 0, dl);
            uncompress(cs.memory);
            memory.writeBytes(cs.memory, 0, cs.memory.length);
            RCache.freeStream(cs);
            // 修改计数
            blockCurrent--;
         }
         // 修正计数
         if(0 == blockCurrent){
            memory.position = 0;
            if(memory.length != dataLength){
               RFatal.throwFatal("Uncompress length is invalid.");
            }
            return true;
         }
         return false;
      }
      
      //============================================================
      // <T>完成处理过程。</T>
      //
      // @return 处理结果
      //============================================================
      public function onComplete():void{
         memory.position = 0;
      }
      
      //============================================================
      // <T>数据处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function process():Boolean{
         // 循环处理
         if(!ready){
            ready = onProcess();
         }
         // 完成处理
         if(ready){
            onComplete();
         }
         return ready;
      }
      
      //============================================================
      // <T>回收资源。</T>
      //============================================================
      public function free():void{
         loaded = false;
         ready = false;
         compressCd = 0;
         blockSize = 0;
         blockCount = 0;
         blockCurrent = 0;
         dataLength = 0;
         verifyCode = 0;
         position = 0;
         stream.position = 0;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != stream){
            stream.dispose();
            stream = null;
         }
         super.dispose();
      }
   }
}