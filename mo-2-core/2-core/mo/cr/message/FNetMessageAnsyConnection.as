package mo.cr.message
{
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.lang.RByte;
   import mo.cm.logger.RLogger;
   import mo.cm.logger.RTracker;
   import mo.cm.net.FSocket;
   import mo.cm.net.FSocketReceiveEvent;
   import mo.cm.stream.FByteStream;
   import mo.cm.stream.FOutputStream;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>网络消息链接。</T>
   //============================================================
   public class FNetMessageAnsyConnection extends FObject implements INetMessageConnection
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FNetMessageAnsyConnection); 
      
      // 压缩设置
      public var optionCompress:Boolean = false; 
      
      // 网络链接
      public var socket:FSocket; 
      
      // 网络主机地址
      public var socketHost:String;
      
      // 网络主机端口
      public var socketPort:int;
      
      // 超时处理
      public var timeout:Number = 0;
      
      // 链接准备
      public var connectReady:Boolean;
      
      // 链接完成
      public var connectFinish:Boolean;
      
      // 序列号
      public var serial:int;
      
      // 重链监听器
      public var lsnsReconnect:FListeners = new FListeners();
      
      // 接收监听器
      public var lsnsReceive:FListeners = new FListeners();
      
      // 断开监听器
      public var lsnsSocketClose:FListeners = new FListeners();
      
      // 消息提供商
      public var provider:INetMessageProvider;
      
      // 消息头
      public var messageHead:FNetMessageHead = new FNetMessageHead();
      
      // 消息时间
      public var messageEvent:FNetMessageEvent = new FNetMessageEvent();
      
      // 发送块
      public var sendBlock:FOutputStream = new FOutputStream(); 
      
      // 发送数据
      public var sendStream:FOutputStream = new FOutputStream(); 
      
      // 接收流
      public var receiveSteam:FByteStream = new FByteStream();
      
      // 接收管道
      public var receivePipe:FNetMessagePipe = new FNetMessagePipe();
      
      // 最后时间
      public var lastTick:Number = 0;
      
      // 消息信息
      public var info:SNetMessageInfo;
      
      //============================================================
      // <T>构造网络消息链接。</T>
      //============================================================
      public function FNetMessageAnsyConnection(){
         socket = new FSocket();
         socket.lsnsConnect.register(onSocketConnect, this);
         socket.lsnsReceive.register(onSocketReceive, this);
         socket.lsnsError.register(onSockeError, this);
         socket.lsnsSecurity.register(onSockeSecurityt, this);
         socket.lsnsClose.register(onSocketClose, this);
      }
      
      //============================================================
      // <T>链接连接成功事件。</T>
      //
      // @param p:event 事件
      //============================================================
      public function onSocketConnect(p:FEvent):void{
         if(!connectReady){
            connectReady = true;
            lsnsReconnect.process();
         }
      }
      
      //============================================================
      // <T>接收消息事件。</T>
      //============================================================
      public function onReceiveMessage():Boolean{
         _logger.debug("onReceiveMessage", "Receive message. (length={1})]", socket.input.length);
         receivePipe.write(socket.input.memory, 0, socket.input.length);
         socket.input.clear();
         return false;
         //         var s:FByteStream = socket.input;
         //         if(s.length >= messageHead.capacity()){
         //            s.position = 0;
         //            messageHead.unserialize(s);
         //            var length:int = messageHead.length;
         //            if(length <= s.length){
         //               // 获得消息对象
         //               var code:int = messageHead.code;
         //               var message:FNetMessage = provider.message(code);
         //               // 反序列化消息
         //               s.position = 0;
         ////               _logger.debug("receiveMessage", "Receive message. (length={1})\n[{2}]\n------------------------------------------------------------\n{3}",
         ////                  length, message.head.name, RByte.format(bytes.memory, length, " - "));
         //               if(message.unserialize(s)){
         //                  // 删除读取过的数据
         //                  s.deleteLeft(length);
         //                  // 处理消息读取事件
         //                  messageEvent.message = message;
         //                  lsnsReceive.process(messageEvent);
         //                  return true;
         //               }
         //            }
         //         }
      }
      
      //============================================================
      // <T>接收消息事件。</T>
      //============================================================
      public function onSocketReceive(p:FSocketReceiveEvent):void{
         RTracker.messageReceive.begin();
         // 接收消息
         while(true){
            if(!onReceiveMessage()){
               break;
            }
         }
         RTracker.messageReceive.end();
      }
      
      //============================================================
      // <T>链接关闭事件。</T>
      //============================================================
      public function onSockeError(p:FEvent):void{
         reconnect();
      }
      
      //============================================================
      // <T>链接关闭事件。</T>
      //============================================================
      public function onSockeSecurityt(p:FEvent):void{
         reconnect();
      }
      
      //============================================================
      // <T>链接关闭事件。</T>
      //============================================================
      public function onSocketClose(p:FEvent):void{
         lsnsSocketClose.process(p);
         connectReady = false;
         connectFinish = false;
      }
      
      //============================================================
      // <T>判断是否已链接。</T>
      //============================================================
      public function get connected():Boolean{
         return socket.connected;
      }
      
      //============================================================
      // <T>网络链接指定主机和端口。</T>
      //
      // @param ph:host 主机
      // @param pp:port 端口
      //============================================================
      public function connect(ph:String = null, pp:int = -1):void{
         // 设置参数
         if(null != ph){
            socketHost = ph;
         }
         if(pp > 0){
            socketPort = pp;
         }
         serial = 0;
         // 链接网络
         socket.connect(socketHost, socketPort);
         connectReady = true;
         connectFinish = true;
      }
      
      //============================================================
      // <T>网络链接指定主机和端口。</T>
      //
      // @param ph:host 主机
      // @param pp:port 端口
      //============================================================
      public function reconnect():void{
         serial = 0;
         // 链接网络
         if(RGlobal.socketAuto){
            socket.connect(socketHost, socketPort);
         }
      }
      
      //============================================================
      // <T>断开网络链接。</T>
      //
      // @param ph:host 主机
      // @param pp:port 端口
      //============================================================
      public function disconnect():void{
         socket.disconnect();
      }
      
      //============================================================
      // <T>发送消息信息。</T>
      //
      // @param pm:message 消息
      // @param pd:direct 直接
      //============================================================
      public function send(pm:FNetMessage = null, pd:Boolean = false):Boolean{
         RTracker.messageSend.begin();
         // 序列化消息，保存到发送流上
         if(null != pm){
            sendBlock.clear();
            if(optionCompress){
               pm.compress(sendBlock);
            }else{
               pm.serialize(sendBlock);
            }
            if(null != info){
               info.sendTotal += sendBlock.length;
               info.sendOriginTotal += pm.originLength;
               info.sendCount++;
            }
         }
         if(!pd){
            sendStream.writeBytes(sendBlock.memory, 0, sendBlock.length);
         }
         // 检查链接
         if(!pd && connectFinish){
            // 检查链接状态
            if(!socket.connected){
               _logger.error("send", "Socket is disconnected.");
               return false;
            }
            // 发送消息
            socket.sendBytes(sendStream.memory, 0, sendStream.length);
            socket.flush();
            sendStream.clear();
         }else if(connectReady){
            // 发送消息
            socket.sendBytes(sendBlock.memory, 0, sendBlock.length);
            socket.flush();
            sendBlock.clear();
         }else{
            // 检查准备状态
            reconnect();
         }
         // 输出调试信息
         RTracker.messageSend.end();
         if(RLogger.debugAble){
            if(null != pm){
               _logger.debugTrack("send", RTracker.messageSend.currentTick,
                  "Send message. (length={1}, serial={2})\n[{3}]\n------------------------------------------------------------\n{4}",
                  pm.head.length, serial, pm.head.name,
                  RByte.format(sendBlock.memory, 0, sendBlock.length, " - "));
            }
         }
         lastTick = RTimer.currentTick;
         return true;
      }
      
      //============================================================
      // <T>解析消息函数。</T>
      //============================================================
      public function process():Boolean{
         //............................................................
         // 发送数据处理
         if(sendStream.length > 0){
            if(connectFinish){
               send();
            }
         }
         //............................................................
         // 收取数据处理
         var s:FByteStream = receivePipe.popData();
         if(null != s){
            // 反序列化消息头
            s.position = 0;
            messageHead.unserialize(s);
            // 获得消息对象
            var ml:int = messageHead.length;
            var mc:int = messageHead.code;
            var m:FNetMessage = provider.message(mc);
            _logger.debug("process", "Receive message. (code={1}, name={2}, length={3})", mc, m.head.name, ml);
            s.position = 0;
            // 反序列化消息
            var r:Boolean = false;
            if(optionCompress){
               r = m.uncompress(s);
            }else{
               r = m.unserialize(s);
            }
            if(r){
               // 处理消息读取事件
               messageEvent.message = m;
               lsnsReceive.process(messageEvent);
               // 数据统计
               if(null != info){
                  info.receiveTotal += s.length;
                  info.receiveOriginTotal += m.originLength;
                  info.receiveCount++;
               }
            }
            s.dispose();
            s = null;
            lastTick = RTimer.currentTick;
            return false;
         }
         //............................................................
         // 检测是否超时
         if(connectFinish && (timeout > 0)){
            var tick:Number = RTimer.currentTick - lastTick;
            if(tick > timeout){
               socket.disconnect();
            }
         }
         return true;
      }
      
      //============================================================
      // <T>重连完成。</T>
      //============================================================
      public function reconnectFinish():void{
         connectFinish = true;
         lastTick = RTimer.currentTick;
      }
      
      //============================================================
      // <T>获得信息字符串。</T>
      //
      // @return 字符串
      //============================================================
      public function dump():String{
         return receivePipe.length + "/" + receivePipe.capacity + "[" + receivePipe.first + "~" +receivePipe.last + "]";
      }
   }
}
