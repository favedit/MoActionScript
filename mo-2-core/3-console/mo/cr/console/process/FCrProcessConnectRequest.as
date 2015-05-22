package mo.cr.console.process
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>进程命令事件。</T>
   //============================================================
   public class FCrProcessConnectRequest extends FCrProcessEvent
   {
      // 事件编号
      public static const CODE:int = ECrProcessGroup.Process + ECrProcessCommand.ConnectRequest;
      
      // 进程编号
      public var processId:int;
      
      // 进程名称
      public var processName:String;
      
      // 来源地址
      public var sourceUrl:String

      // 来源路径
      public var sourceUri:String;

      //============================================================
      // <T>构造进程命令事件。</T>
      //============================================================
      public function FCrProcessConnectRequest(p:FCrProcessEvent = null){
         code = CODE;
         if(p){
            loadEvent(p);
         }
      }
      
      //============================================================
      // <T>序列化对象内容。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public override function serialize(p:IOutput):void{
         super.serialize(p);
         p.writeInt32(processId);
         p.writeString(processName);
         p.writeString(sourceUrl);
         p.writeString(sourceUri);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public override function unserialize(p:IInput):void{
         super.unserialize(p);
         processId = p.readInt32();
         processName = p.readString();
         sourceUrl = p.readString();
         sourceUri = p.readString();
      }
   }
}