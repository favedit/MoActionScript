package mo.cr.message
{
   import flash.utils.ByteArray;
   
   import mo.cm.core.device.RGlobal;
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
   public class FNetMessageConnection extends FObject implements INetMessageConnection
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FNetMessageConnection); 
      
      // 压缩设置
      public var optionCompress:Boolean = false; 

      // 网络链接
      public var socket:FSocket; 
      
      // 网络主机地址
      public var socketHost:String;
      
      // 网络主机端口
      public var socketPort:int;
      
      // 序列号
      public var serial:int;
      
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
      
      // 发送流
      public var sendStream:FOutputStream = new FOutputStream(); 
      
      // 接收流
      public var receiveSteam:FByteStream = new FByteStream();
      
      // 接收管道
      public var receivePipe:FNetMessagePipe = new FNetMessagePipe();
      
      // 消息分发
      public var dispatcher:INetMessageDispatcher;
      
      // 消息信息
      public var info:SNetMessageInfo;
      
      //============================================================
      // <T>构造网络消息链接。</T>
      //============================================================
      public function FNetMessageConnection(){
         socket = new FSocket();
         socket.lsnsReceive.register(onSocketReceive, this);
         socket.lsnsError.register(onSockeError, this);
         socket.lsnsSecurity.register(onSockeSecurityt, this);
         socket.lsnsClose.register(onSocketClose, this);
      }
      
      //============================================================
      // <T>接收消息事件。</T>
      //============================================================
      public function onSocketReceive(p:FSocketReceiveEvent):void{
         // 接收消息
         receivePipe.write(socket.input.memory, 0, socket.input.length);
         socket.input.clear();
      }
      
      //============================================================
      // <T>链接关闭事件。</T>
      //============================================================
      public function onSockeError(p:FEvent):void{
         connect();
      }
      
      //============================================================
      // <T>链接关闭事件。</T>
      //============================================================
      public function onSockeSecurityt(p:FEvent):void{
         connect();
      }
      
      //============================================================
      // <T>链接关闭事件。</T>
      //============================================================
      public function onSocketClose(p:FEvent):void{
         lsnsSocketClose.process(p);
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
      public function send(pm:FNetMessage, pd:Boolean = false):Boolean{
         RTracker.messageSend.begin();
         // 检查链接
         if(!socket.connected){
            _logger.error("send", "Socket is disconnected.");
            return false;
         }
         // 序列化消息
         sendStream.clear();
         if(optionCompress){
            pm.compress(sendStream);
         }else{
            pm.serialize(sendStream);
         }
         if(null != info){
            info.sendTotal += sendStream.length;
            info.sendOriginTotal += pm.originLength;
            info.sendCount++;
         }
         // 发送消息
         socket.sendBytes(sendStream.memory, 0, sendStream.length);
         socket.flush();
         RTracker.messageSend.end();
         // 输出调试信息
         if(RLogger.debugAble){
            _logger.debugTrack("send", RTracker.messageSend.currentTick,
               "Send message. (length={1}, serial={2})\n[{3}]\n------------------------------------------------------------\n{4}",
               pm.head.length, serial, pm.head.name,
               RByte.format(sendStream.memory, 0, sendStream.length, " - "));
         }
         return true;
      }
      
      //============================================================
      // <T>发送消息信息。</T>
      //
      // @param pm:message 消息
      // @param pd:direct 直接
      //============================================================
      public function sendTgwRequest():void{
         var ba:ByteArray = new ByteArray();
         ba.writeMultiByte(RGlobal.tgwKey, "GBK");
         socket.sendBytes(ba, 0, ba.length);
         socket.flush();
      }
      
      //============================================================
      // <T>解析消息函数。</T>
      //============================================================
      public function process():Boolean{
         while(true){
            // 获得数据块
            var s:FByteStream = receivePipe.popData();
            if(null == s){
               break;
            }
            //............................................................
            // 反序列化消息头
            var b:Number = new Date().time;
            s.position = 0;
            messageHead.unserialize(s);
            // 获得消息对象
            var ml:int = messageHead.length;
            var mc:int = messageHead.code;
            var m:FNetMessage = provider.message(mc);
            _logger.debug("process", "Receive message. (code={1}, name={2}, length={3})", mc, m.head.name, ml);
            // 反序列化消息
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
            //............................................................
            // 测试是否继续
            if(null != dispatcher){
               if(dispatcher.testContinue(mc)){
                  continue;
               }
            }
            var e:Number = new Date().time;
            var c:Number = e - b;
            if(c > 5){
               trace("message(name=" + m.head.name + ") process cost time:" + (e - b) + "ms");
            }
            //............................................................
            // 返回处理
            return false;
         }
         return true;
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