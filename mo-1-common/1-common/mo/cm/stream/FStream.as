package mo.cm.stream
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.lang.FObject;
   import mo.cm.lang.SInt64;
   import mo.cm.lang.SUint64;
   
   //============================================================
   // <T>数据输入输出流。</T>
   // <P>实现输入输出流和数据输入流。</P>
   //============================================================
   public class FStream extends FObject implements IInput, IOutput
   {
      // 字节数据
      public var memory:ByteArray;
      
      //============================================================
      // <T>创建数据输入输出流。</T>
      //============================================================
      public function FStream(p:ByteArray){
         memory = p;
         memory.endian = Endian.LITTLE_ENDIAN;
      }
      
      //============================================================
      // <T>获得数据长度。</T>
      //
      // @return 数据长度
      //============================================================
      public final function get length():uint{
         return memory.length;
      }
      
      //============================================================
      // <T>获得数据。</T>
      //
      // @return 数据
      //============================================================
      public final function get data():ByteArray{
         return memory;
      }
      
      //============================================================
      // <T>从字节流中读取一个布尔值。</T>
      // <P>占用一个字节，为1表示真，为0表示假。</P>
      //
      // @return 布尔值
      //============================================================
      [Inline]
      public final function readBoolean():Boolean{
         return memory.readByte() > 0;
      }
      
      //============================================================
      // <T>从字节流中读取一个枚举值。</T>
      // <P>占用4个字节，为32位无符号整数。</P>
      //
      // @return 枚举值
      //============================================================
      [Inline]
      public final function readEnum():uint{
         return memory.readUnsignedInt();
      }
      
      //============================================================
      // <T>从字节流中读取一个有符号8位整数。</T>
      //
      // @return 有符号8位整数
      //============================================================
      [Inline]
      public final function readInt8():int{
         return memory.readByte();
      }
      
      //============================================================
      // <T>从字节流中读取一个有符号16位整数。</T>
      //
      // @return 有符号16位整数
      //============================================================
      [Inline]
      public final function readInt16():int{
         return memory.readShort();
      }
      
      //============================================================
      // <T>从字节流中读取一个有符号32位整数。</T>
      //
      // @return 有符号32位整数
      //============================================================
      [Inline]
      public final function readInt32():int{
         return memory.readInt();
      }
      
      //============================================================
      // <T>从字节流中读取一个有符号64位整数。</T>
      //
      // @param p:value 有符号64位整数
      // @return 有符号64位整数
      //============================================================
      [Inline]
      public final function readInt64(p:SInt64 = null):SInt64{
         if(null == p){
            p = new SInt64();
         }
         p.unserialize(this);
         return p;
      }
      
      //============================================================
      // <T>从字节流中读取一个无符号8位整数。</T>
      //
      // @return 无符号8位整数
      //============================================================
      [Inline]
      public final function readUint8():uint{
         return memory.readUnsignedByte();
      }
      
      //============================================================
      // <T>从字节流中读取一个无符号16位整数。</T>
      //
      // @return 无符号16位整数
      //============================================================
      [Inline]
      public final function readUint16():uint{
         return memory.readUnsignedShort();
      }
      
      //============================================================
      // <T>从字节流中读取一个无符号32位整数。</T>
      //
      // @return 无符号32位整数
      //============================================================
      [Inline]
      public final function readUint32():uint{
         return memory.readUnsignedInt();
      }
      
      //============================================================
      // <T>从字节流中读取一个无符号64位整数。</T>
      //
      // @param p:value 无符号64位整数
      // @return 无符号64位整数
      //============================================================
      [Inline]
      public final function readUint64(p:SUint64 = null):SUint64{
         if(null == p){
            p = new SUint64();
         }
         p.unserialize(this);
         return p;
      }
      
      //============================================================
      // <T>从字节流中读取一个32位浮点数。</T>
      //
      // @return 32位浮点数
      //============================================================
      [Inline]
      public final function readFloat():Number{
         return memory.readFloat();
      }
      
      //============================================================
      // <T>从字节流中读取一个64位浮点数。</T>
      //
      // @return 64位浮点数
      //============================================================
      [Inline]
      public final function readDouble():Number{
         return memory.readDouble();
      }
      
      //============================================================
      // <T>从字节流中读取一个字符串。</T>
      //
      // @return 字符串
      //============================================================
      [Inline]
      public final function readString():String{
         return memory.readUTF();
      }
      
      //============================================================
      // <T>从本字节流中读取一段数据，写入到字节流中。</T>
      //
      // @param pd:data: 要读取到的字节流
      // @param po:offset: 要读取到的数组写入位置
      // @param pl:length: 要读取的长度
      //============================================================
      [Inline]
      public final function readBytes(pd:ByteArray, po:int = 0, pl:int = -1):void{
         if(-1 == pl){
            pl = memory.length;
         }
         memory.readBytes(pd, po, pl);
      }
      
      //============================================================
      // <T>向字节流中写入一个布尔值。</T>
      // <P>占用一个字节，为1表示真，为0表示假。</P>
      //
      // @param p:value 布尔值
      //============================================================
      [Inline]
      public final function writeBoolean(p:Boolean):void{
         memory.writeByte(p? 1 : 0);
      }
      
      //============================================================
      // <T>向字节流中写入一个枚举值。</T>
      // <P>占用4个字节，为32位无符号整数。</P>
      //
      // @param p:value 枚举值
      //============================================================
      [Inline]
      public final function writeEnum(p:uint):void{
         memory.writeUnsignedInt(p);
      }
      
      //============================================================
      // <T>向字节流中写入一个有符号8位整数。</T>
      //
      // @param p:value 有符号8位整数
      //============================================================
      [Inline]
      public final function writeInt8(p:int):void{
         memory.writeByte(p);
      }
      
      //============================================================
      // <T>在字节流中写入一个有符号16位整数。</T>
      //
      // @param p:value 有符号16位整数
      //============================================================
      [Inline]
      public final function writeInt16(p:int):void{
         memory.writeShort(p);
      }
      
      //============================================================
      // <T>在字节流中写入一个有符号32位整数。</T>
      //
      // @param p:value 有符号32位整数
      //============================================================
      [Inline]
      public final function writeInt32(p:int):void{
         memory.writeInt(p);
      }
      
      //============================================================
      // <T>在字节流中写入一个有符号64位整数。</T>
      //
      // @param p:value 有符号64位整数
      //============================================================
      [Inline]
      public final function writeInt64(p:SInt64):void{
         p.serialize(this);
      }
      
      //============================================================
      // <T>向字节流中写入一个无符号8位整数。</T>
      //
      // @param p:value 无符号8位整数
      //============================================================
      [Inline]
      public final function writeUint8(p:uint):void{
         memory.writeByte(p);
      }
      
      //============================================================
      // <T>向字节流中写入一个无符号16位整数。</T>
      //
      // @param p:value 无符号16位整数
      //============================================================
      [Inline]
      public final function writeUint16(p:uint):void{
         memory.writeShort(p);
      }
      
      //============================================================
      // <T>向字节流中写入一个无符号32位整数。</T>
      //
      // @param p:value 无符号32位整数
      //============================================================
      [Inline]
      public final function writeUint32(p:uint):void{
         memory.writeUnsignedInt(p);
      }
      
      //============================================================
      // <T>向字节流中写入一个无符号64位整数。</T>
      //
      // @param p:value 无符号64位整数
      //============================================================
      [Inline]
      public final function writeUint64(p:SUint64):void{
         p.serialize(this);
      }
      
      //============================================================
      // <T>向字节流中写入一个32位浮点数。</T>
      //
      // @param p:value 32位浮点数
      //============================================================
      [Inline]
      public final function writeFloat(p:Number):void{
         memory.writeFloat(p);
      }
      
      //============================================================
      // <T>向字节流中写入一个64位浮点数。</T>
      //
      // @param p:value 64位浮点数
      //============================================================
      [Inline]
      public final function writeDouble(p:Number):void{
         memory.writeDouble(p);
      }
      
      //============================================================
      // <T>向字节流中写入一个字符串。</T>
      //
      // @param p:value 字符串
      //============================================================
      [Inline]
      public final function writeString(p:String):void{
         if(null != p){
            memory.writeUTF(p);
         }else{
            memory.writeShort(0);
         }
      }   
      
      //============================================================
      // <T>向本字节流中写入一段数据，写入到字节流中。</T>
      //
      // @param pd:data: 要写入到的字节流
      // @param po:offset: 要写入到的数组写入位置
      // @param pl:length: 要写入的长度
      //============================================================
      [Inline]
      public final function writeBytes(pd:ByteArray, po:int = 0, pl:int = 0):void{
         memory.writeBytes(pd, po, pl);
      }
      
      //============================================================
      // <T>从字节流中忽略指定长度的数据。</T>
      //
      // @return 布尔值
      //============================================================
      public function skip(p:int):void{
         memory.position += p;
      }
      
      //============================================================
      // <T>标记有效数据块。</T>
      //============================================================
      public function flip():void{
         memory.length = memory.position;
         memory.position = 0;
      }
      
      //============================================================
      // <T>清除内存。</T>
      //============================================================
      public function clear():void{
         memory.length = 0;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         memory = null;
         super.dispose();
      }
   }
}