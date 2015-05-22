package mo.cr.console.process
{
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.ILogger;
   import mo.cm.system.RProcess;
   import mo.cr.console.RCrConsole;
   
   //============================================================
   // <T>进程对象。</T>
   //============================================================
   public class FCrProcess extends FObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrProcess);
      
      // 控制台
      public var console:FCrProcessConsole;
      
      // 编号
      public var id:int;
      
      // 代码
      public var code:String; 
      
      // 可用
      public var ready:Boolean;
      
      // 发送次数
      public var sendCount:int;
      
      // 接收次数
      public var receiveCount:int;
      
      //============================================================
      // <T>构造进程对象。</T>
      //============================================================
      public function FCrProcess(){
         id = ++RProcess.nextId;
      }
      
      //============================================================
      // <T>发送事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function send(e:FCrProcessEvent):void{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      // <T>发送事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function receive():FCrProcessEvent{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      // <T>处理命令事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function processCommand(e:FCrProcessEvent):void{
         throw new FFatalUnsupportError();
      }
      
      //============================================================
      // <T>处理过程。</T>
      //============================================================
      public function process():void{
         // 非堵塞式接收消息
         var e:FCrProcessEvent = receive();
         if(e){
            // 加载消息
            var c:int = e.code;
            // 分发消息
            var g:int = c & ECrProcessGroup.Mask;
            if(ECrProcessGroup.Process == g){
               // 命令事件处理
               processCommand(e);
            }else{
               // 普通事件处理
               RCrConsole.processConsole.processor.process(e);
            }
         }
      }
   }
}