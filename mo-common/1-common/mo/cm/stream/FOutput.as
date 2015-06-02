package mo.cm.stream
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.lang.FObject;
   import mo.cm.lang.SInt64;
   import mo.cm.lang.SUint64;
   
   //============================================================
   // <T>数据输出流。</T>
   //============================================================
   public class FOutput extends FObject implements IOutput
   {
      // 字节数据
      public var memory:ByteArray;
      
      //============================================================
      // <T>构造数据输出流。</T>
      //
      // @param p:memory 字节数据
      //============================================================
      public function FOutput(p:ByteArray){
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