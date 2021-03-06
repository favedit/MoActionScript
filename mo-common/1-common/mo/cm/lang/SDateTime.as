package mo.cm.lang
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>日期时间类型。</T>
   //============================================================
   public class SDateTime
   {
      // 存储数据
      public var data:Number;
      
      //============================================================
      // <T>构造日期时间类型。</T>
      //============================================================
      public function SDateTime(p:Number = 0){
         data = p;
      }
      
      //============================================================
      // <T>接收对象内容。</T>
      //
      // @param object 对象
      //============================================================
      public function assign(p:SDateTime):void{
         data = p.data;
      }
      
      //============================================================
      // <T>序列化内部数据到输出流。</T>
      //
      // @param p:output 输出流
      //============================================================
      public function serialize(p:IOutput):void{
         p.writeInt32(data >> 32);
         p.writeInt32(data & 0xFFFFFFFF);
      }
      
      //============================================================
      // <T>反序列化输入流到内部数据。</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserialize(p:IInput):void{
         data = p.readInt32() << 32;
         data += p.readInt32();
      }

      //============================================================
      // <T>重置数据。</T>
      //============================================================
      public function reset():void{
         data = 0;
      }
   }
}