package mo.cr.console.process
{
   import flash.utils.ByteArray;
   
   import mo.cm.lang.FObject;
   import mo.cm.lang.RInteger;
   import mo.cm.stream.FByteStream;
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>进程事件。</T>
   //============================================================
   public class FCrProcessEvent extends FObject
   {
      // 类型
      public var group:String;
      
      // 代码
      public var code:int;
      
      // 编号
      public var id:int;
      
      // 数据
      public var data:FByteStream = new FByteStream();
      
      //============================================================
      // <T>构造进程事件。</T>
      //============================================================
      public function FCrProcessEvent(){
      }
      
      //============================================================
      // <T>获得数据。</T>
      //============================================================
      public function get bytes():ByteArray{
         return data.memory;
      }
      
      //============================================================
      // <T>加载数据流。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function loadBuffer(p:FCrProcessEventBuffer):void{
         p.data.position = 0;
         unserialize(p.data);
      }
      
      //============================================================
      // <T>加载数据流。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function loadEvent(p:FCrProcessEvent):void{
         p.data.position = 0;
         unserialize(p.data);
      }
      
      //============================================================
      // <T>序列化对象内容。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize(p:IOutput):void{
         p.writeInt32(code);
         p.writeInt32(id);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize(p:IInput):void{
         code = p.readInt32();
         id = p.readInt32();
      }
      
      //============================================================
      // <T>数据打包。</T>
      //============================================================
      public function pack():void{
         data.clear();
         serialize(data);
         data.position = 0;
      }
      
      //============================================================
      // <T>数据打包。</T>
      //============================================================
      public function unpack():void{
         data.position = 0;
         unserialize(data);
      }
      
      //============================================================
      // <T>获得格式化代码。</T>
      //
      // @return 格式化代码
      //============================================================
      public function formatCode():String{
         return RInteger.toHex(code >> 16, 2) + "-" + RInteger.toHex(code & 0xFFFF, 4);
      }
      
      //============================================================
      // <T>处理过程。</T>
      //============================================================
      public function process():void{
      }
   }
}