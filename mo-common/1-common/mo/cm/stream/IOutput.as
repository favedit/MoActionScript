package mo.cm.stream
{
   import flash.utils.ByteArray;
   
   import mo.cm.lang.SInt64;
   import mo.cm.lang.SUint64;
   
   //============================================================
   // <T>数据输出流接口。</T>
   //============================================================
   public interface IOutput
   {
      //============================================================
      // <T>获得数据。</T>
      //
      // @return 数据
      //============================================================
      function get data():ByteArray;

      //============================================================
      // <T>向字节流中写入一个布尔值。</T>
      // <P>占用一个字节，为1表示真，为0表示假。</P>
      //
      // @param p:value 布尔值
      //============================================================
      function writeBoolean(p:Boolean):void;
      
      //============================================================
      // <T>向字节流中写入一个枚举值。</T>
      // <P>占用4个字节，为32位无符号整数。</P>
      //
      // @param p:value 枚举值
      //============================================================
      function writeEnum(p:uint):void;
      
      //============================================================
      // <T>向字节流中写入一个有符号8位整数。</T>
      //
      // @param p:value 有符号8位整数
      //============================================================
      function writeInt8(p:int):void;
      
      //============================================================
      // <T>在字节流中写入一个有符号16位整数。</T>
      //
      // @param p:value 有符号16位整数
      //============================================================
      function writeInt16(p:int):void;
      
      //============================================================
      // <T>在字节流中写入一个有符号32位整数。</T>
      //
      // @param p:value 有符号32位整数
      //============================================================
      function writeInt32(p:int):void;
      
      //============================================================
      // <T>在字节流中写入一个有符号64位整数。</T>
      //
      // @param p:value 有符号64位整数
      //============================================================
      function writeInt64(p:SInt64):void;
      
      //============================================================
      // <T>向字节流中写入一个无符号8位整数。</T>
      //
      // @param p:value 无符号8位整数
      //============================================================
      function writeUint8(p:uint):void;
      
      //============================================================
      // <T>向字节流中写入一个无符号16位整数。</T>
      //
      // @param p:value 无符号16位整数
      //============================================================
      function writeUint16(p:uint):void;
      
      //============================================================
      // <T>向字节流中写入一个无符号32位整数。</T>
      //
      // @param p:value 无符号32位整数
      //============================================================
      function writeUint32(p:uint):void;
      
      //============================================================
      // <T>向字节流中写入一个无符号64位整数。</T>
      //
      // @param p:value 无符号64位整数
      //============================================================
      function writeUint64(p:SUint64):void;
      
      //============================================================
      // <T>向字节流中写入一个32位浮点数。</T>
      //
      // @param p:value 32位浮点数
      //============================================================
      function writeFloat(p:Number):void;
      
      //============================================================
      // <T>向字节流中写入一个64位浮点数。</T>
      //
      // @param p:value 64位浮点数
      //============================================================
      function writeDouble(p:Number):void;
      
      //============================================================
      // <T>向字节流中写入一个字符串。</T>
      //
      // @param p:value 字符串
      //============================================================
      function writeString(p:String):void;
      
      //============================================================
      // <T>向本字节流中写入一段数据，写入到字节流中。</T>
      //
      // @param pd:data: 要写入到的字节流
      // @param po:offset: 要写入到的数组写入位置
      // @param pl:length: 要写入的长度
      //============================================================
      function writeBytes(pd:ByteArray, po:int = 0, pl:int = -1):void;
      
      //============================================================
      // <T>从字节流中忽略指定长度的数据。</T>
      //
      // @return 布尔值
      //============================================================
      function skip(p:int):void;
   }
}