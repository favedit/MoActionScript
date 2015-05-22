package mo.cr.console.process
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>进程命令事件。</T>
   //============================================================
   public class FCrProcessConnectResponse extends FCrProcessEvent
   {
      // 事件编号
      public static const CODE:int = ECrProcessGroup.Process + ECrProcessCommand.ConnectResponse;
      
      // 进程编号
      public var processId:int;
      
      // 进程名称
      public var processName:String;
      
      //============================================================
      // <T>构造进程命令事件。</T>
      //============================================================
      public function FCrProcessConnectResponse(p:FCrProcessEvent = null){
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
      }
   }
}