package mo.cm.xml
{   
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.net.XMLSocket;
   
   import mo.cm.lang.FObject;
   import mo.cm.lang.FString;
   import mo.cm.system.ILogger;
   import mo.cm.logger.RLogger;
   
   public class FXmlSocket extends FObject
   {
      //============================================================
      private static var _logger:ILogger = RLogger.find(FXmlSocket);
      
      //============================================================
      // 建立通讯对象
      public var _socket:XMLSocket = new XMLSocket();
      
      //============================================================
      public function FXmlSocket() {
         // 连接状态事件
         _socket.addEventListener(Event.CONNECT, onConnect);
         // 关闭事件
         _socket.addEventListener(Event.CLOSE, onClose);
         // 数据通信事件
         _socket.addEventListener(DataEvent.DATA, onData);
      }
      
      //============================================================
      public function onConnect(success:Boolean):void {
         _logger.debug("onConnect", "socket.onConnect: {0}", success);
         if(!success){
            _logger.debug("onConnect", "服务器连接失败,请检查网络状态!");
         }
      }
      
      //============================================================
      public function onClose():void {
         _logger.debug("onConnect", "服务端已关闭！");
      }
      
      //============================================================
      //数据通信事件；
      public function onData(event:DataEvent):void {
         _logger.debug("onData", "Read data: {0}", event);
         _socket.close();
      }
      
      //============================================================
      public function connect():void {
         _socket.connect("127.0.0.1", 88);
         var data:FString = new FString();
         data.append("GET /eUIS/Index.wa HTTP/1.1\r\n");
         data.append("Accept: */*\r\n");
         data.append("Accept-Language: zh-cn\r\n");
         data.append("User-Agent: Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.0; Trident/4.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.21022; InfoPath.2; .NET CLR 3.5.30729; .NET CLR 3.0.30618)\r\n");
         data.append("Accept-Encoding: deflate\r\n");
         data.append("Host: localhost:88\r\n");
         data.append("Connection: Keep-Alive\r\n");
         data.append("Cookie: JSESSIONID=C25715A0F1EE31811A0F6D2CDCDC3E2A\r\n");
         _socket.send(data.toString());         
      }
   }  
}