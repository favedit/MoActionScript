package mo.cm.stream
{
   import flash.utils.ByteArray;
   
   import mo.cm.lang.SInt64;
   import mo.cm.lang.SUint64;
   
   //============================================================
   // <T>数据输入流接口。</T>
   //============================================================
   public interface IInput
   {
      //============================================================
      // <T>获得数据。</T>
      //
      // @return 数据
      //============================================================
      function get data():ByteArray;

      //============================================================
      // <T>从字节流中读取一个布尔值。</T>
      // <P>占用一个字节，为1表示真，为0表示假。</P>
      //
      // @return 布尔值
      //============================================================
      function readBoolean():Boolean;
      
      //============================================================
      // <T>从字节流中读取一个枚举值。</T>
      // <P>占用4个字节，为32位无符号整数。</P>
      //
      // @return 枚举值
      //============================================================
      function readEnum():uint;
      
      //============================================================
      // <T>从字节流中读取一个有符号8位整数。</T>
      //
      // @return 有符号8位整数
      //============================================================
      function readInt8():int;
      
      //============================================================
      // <T>从字节流中读取一个有符号16位整数。</T>
      //
      // @return 有符号16位整数
      //============================================================
      function readInt16():int;
      
      //============================================================
      // <T>从字节流中读取一个有符号32位整数。</T>
      //
      // @return 有符号32位整数
      //============================================================
      function readInt32():int;
      
      //============================================================
      // <T>从字节流中读取一个有符号64位整数。</T>
      //
      // @param p:value 有符号64位整数
      // @return 有符号64位整数
      //============================================================
      function readInt64(p:SInt64 = null):SInt64;
      
      //============================================================
      // <T>从字节流中读取一个无符号8位整数。</T>
      //
      // @return 无符号8位整数
      //============================================================
      function readUint8():uint;
      
      //============================================================
      // <T>从字节流中读取一个无符号16位整数。</T>
      //
      // @return 无符号16位整数
      //============================================================
      function readUint16():uint;
      
      //============================================================
      // <T>从字节流中读取一个无符号32位整数。</T>
      //
      // @return 无符号32位整数
      //============================================================
      function readUint32():uint;
      
      //============================================================
      // <T>从字节流中读取一个无符号64位整数。</T>
      //
      // @param p:value 无符号64位整数
      // @return 无符号64位整数
      //============================================================
      function readUint64(p:SUint64 = null):SUint64;
      
      //============================================================
      // <T>从字节流中读取一个32位浮点数。</T>
      //
      // @return 32位浮点数
      //============================================================
      function readFloat():Number;
      
      //============================================================
      // <T>从字节流中读取一个64位浮点数。</T>
      //
      // @return 64位浮点数
      //============================================================
      function readDouble():Number;
      
      //============================================================
      // <T>从字节流中读取一个字符串。</T>
      //
      // @return 字符串
      //============================================================
      function readString():String;
      
      //============================================================
      // <T>从本字节流中读取一段数据，写入到字节流中。</T>
      //
      // @param pd:data: 要读取到的字节流
      // @param po:offset: 要读取到的数组写入位置
      // @param pl:length: 要读取的长度
      //============================================================
      function readBytes(pd:ByteArray, po:int = 0, pl:int = -1):void;
      
      //============================================================
      // <T>从字节流中忽略指定长度的数据。</T>
      //
      // @return 布尔值
      //============================================================
      function skip(p:int):void;
   }
}