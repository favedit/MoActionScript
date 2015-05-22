package mo.cr.message
{
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>消息头信息。</T>
   //============================================================
   public class FNetMessageHead extends FObject
   {
      // 名称
      public var name:String;
      
      // 长度
      public var length:uint;
      
      // 协议
      public var protocol:int;
      
      // 签名
      public var sign:int;
      
      // 哈希
      public var hash:uint;
      
      // 类型
      public var type:int;
      
      // 命令
      public var command:int;
      
      // 代码
      public var code:int;
      
      // 版本
      public var version:int;
      
      // 序列
      public var serial:uint;
      
      // 时刻
      public var tick:uint;
      
      //============================================================
      // <T>构造消息头信息。</T>
      //============================================================
      public function FNetMessageHead(){
      }
      
      //============================================================
      // <T>获得消息头容量。</T>
      //
      // @return 容量
      //============================================================
      public function capacity():int{
         return 24;
      }
      
      //============================================================
      // <T>序列化数据内容到输出流。</T>
      //
      // @param p:output 输出流
      //============================================================
      public function serialize(p:IOutput):void{
         // 网络数据头信息 (10字节)
         p.writeUint32(length);
         p.writeUint8(protocol);
         p.writeUint8(sign);
         p.writeUint32(hash);
         // 网络消息头信息 (14字节)
         p.writeUint8(type);
         p.writeUint8(command);
         p.writeUint16(code);
         p.writeUint16(version);
         p.writeUint32(serial);
         p.writeUint32(tick);
      }
      
      //============================================================
      // <T>从输入流反序列化数据内容。</T>
      //
      // @param p:output 输出流
      //============================================================
      public function unserialize(p:IInput):void{
         // 网络数据头信息
         length = p.readUint32();
         protocol = p.readUint8();
         sign = p.readUint8();
         hash = p.readUint32();
         // 网络消息头信息
         type = p.readUint8();
         command = p.readUint8();
         code = p.readUint16();
         version = p.readUint16();
         serial = p.readUint32();
         tick = p.readUint32();
      }
   }
}