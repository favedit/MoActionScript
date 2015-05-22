package mo.cr.message
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RTimer;
   import mo.cm.encode.RCompress;
   import mo.cm.lang.FObject;
   import mo.cm.stream.FByteStream;
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>网络消息。</T>
   //============================================================
   public class FNetMessage extends FObject implements INetObject
   {
      // 序列
      public static var SerialNumber:int = 0;

      // 原始长度
      public var originLength:int;
      
      // 头信息
      public var head:FNetMessageHead = new FNetMessageHead();
      
      //============================================================
      // <T>构造网络消息。</T>
      //============================================================
      public function FNetMessage(){
         head.protocol = ENetProtocol.Message;
      }
      
      //============================================================
      // <T>序列化数据部分到输入流中。</T>
      //
      // @param p:output 输入流
      //============================================================
      public function serializeData(p:IOutput):void{
      }
      
      //============================================================
      // <T>从输出流中反序列化数据部分。</T>
      //
      // @param p:input 输出流
      //============================================================
      public function unserializeData(p:IInput):void{
      }
      
      //============================================================
      // <T>接收消息内容。</T>
      //
      // @param p:message 消息
      //============================================================
      public function assign(p:Object):void{
      }
      
      //============================================================
      // <T>序列化到输入流中。</T>
      //
      // @param p:output 输入流
      //============================================================
      public function serialize(p:IOutput):void{
         // 序列化内容
         var s:FByteStream = new FByteStream();
         serializeData(s);
         s.flip();
         // 序列化消息头
         var hc:int = head.capacity(); 
         head.length = hc + s.length;
         head.serial = ++SerialNumber;
         head.tick = RTimer.totalTick;
         head.hash = RNetUtility.calculateHash(head.serial, head.tick, s.memory);
         head.serialize(p);
         // 保存内容
         if(RGlobal.socketMask){
            RNetUtility.markData(s.memory, head.hash);            
         }
         p.writeBytes(s.memory, 0, s.length);
         // 释放内容
         s.dispose();
         s = null;
      }
      
      //============================================================
      // <T>序列化到输入流中。</T>
      //
      // @param p:output 输入流
      //============================================================
      public function compress(p:IOutput):void{
         // 序列化内容
         var d:ByteArray = new ByteArray();
         d.endian = Endian.LITTLE_ENDIAN;
         var s:FByteStream = new FByteStream();
         serializeData(s);
         originLength = s.length + head.capacity();
         s.flip();
         RCompress.lreEncode(s.memory, s.length, d);
         // 序列化消息头
         var hc:int = head.capacity(); 
         head.length = hc + d.length;
         head.serial = ++SerialNumber;
         head.tick = RTimer.totalTick;
         head.hash = RNetUtility.calculateHash(head.serial, head.tick, d);
         head.serialize(p);
         // 保存内容
         RNetUtility.markData(d, head.hash);
         p.writeBytes(d, 0, d.length);
         // 释放内容
         s.dispose();
         s = null;
         d.clear();
         d = null;
      }
      
      //============================================================
      // <T>从输出流中反序列化。</T>
      //
      // @param input 输出流
      //============================================================
      public function unserialize(p:IInput):Boolean{
         // 反序列化消息头
         head.unserialize(p);
         // 反序列化内容
         unserializeData(p);
         return true;
      }
      
      //============================================================
      // <T>从输出流中反序列化。</T>
      //
      // @param input 输出流
      //============================================================
      public function uncompress(p:IInput):Boolean{
         // 反序列化消息头
         head.unserialize(p);
         // 解压数据
         var s:FByteStream = new FByteStream();
         var d:ByteArray = new ByteArray();
         d.endian = Endian.LITTLE_ENDIAN;
         var dl:int = head.length - head.capacity();
         p.readBytes(d, 0, dl);
         RCompress.lreDecode(d, d.length, s.memory);
         // 反序列化内容
         s.flip();
         originLength = s.length;
         unserializeData(s);
         s.dispose();
         s = null;
         d.clear();
         d = null;
         return true;
      }
      
      //============================================================
      // <T>重置内容。</T>
      //============================================================
      public function reset():void{
      }
   }
}