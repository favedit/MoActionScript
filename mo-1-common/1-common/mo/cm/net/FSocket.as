package mo.cm.net
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.core.device.RGlobal;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.FByteStream;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>网络套接字。</T>
   //============================================================
   public class FSocket extends FObject 
   {
      // 日志输出器
      private static var _logger:ILogger = RLogger.find(FSocket);
      
      // 套接字
      public var socket:Socket;
      
      // 套接字
      public var loggered:Boolean = true;
      
      // 连接成功监听
      public var lsnsConnect:FListeners = new FListeners();
      
      // 断开连接监听
      public var lsnsClose:FListeners = new FListeners();
      
      // 断开连接监听
      public var lsnsError:FListeners = new FListeners();
      
      // 断开连接监听
      public var lsnsSecurity:FListeners = new FListeners();
      
      // 接收数据监听
      public var lsnsReceive:FListeners = new FListeners();
      
      // 接收数据事件
      public var receiveEvent:FSocketReceiveEvent = new FSocketReceiveEvent();
      
      // 输入数据流
      public var input:FByteStream = new FByteStream();
      
      //============================================================
      // <T>构造网络套接字。</T>
      //============================================================
      public function FSocket(){
      }
      
      //============================================================
      // <T>注册一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerConnect(pm:Function, po:Object = null, pc:int = -1):FListener{
         return lsnsConnect.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注册一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      //============================================================
      public function unregisterConnect(pm:Function, po:Object = null):void{
         lsnsConnect.unregister(pm, po);
      }
      
      //============================================================
      // <T>注册一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerSecurity(pm:Function, po:Object = null, pc:int = -1):FListener{
         return lsnsSecurity.register(pm, po, pc);
      }
      
      //============================================================
      // <T>套接字连接成功处理。</T>
      // 
      // @params e:event 连接成功事件
      //============================================================
      public function onConnect(e:Event):void{
         if(RLogger.debugAble && loggered){
            _logger.debug("onConnect", "Socket connect. {event={1}}", e);
         }
         if(lsnsConnect){
            lsnsConnect.process(new FEvent(null, this));
         }
      }
      
      //============================================================
      // <T>套接字断开连接处理。</T>
      // 
      // @params e:event 断开连接事件
      //============================================================
      public function onClose(e:Event):void{
         if(RLogger.debugAble && loggered){
            _logger.debug("onClose", "Socket close. {event={1}}", e);
         }
         if(lsnsClose){
            lsnsClose.process(new FEvent());
         }
      }
      
      //============================================================
      // <T>套接字接收数据处理。</T>
      // 
      // @params e:event 接收数据事件
      //============================================================
      public function onReceive(e:ProgressEvent):void{
         if(RLogger.debugAble && loggered){
            _logger.debug("onReceive", "Socket receive data. (length={1})", e.bytesLoaded);
         }
         // 读取长度
         var c:int = socket.bytesAvailable;
         socket.readBytes(input.memory, input.length, c);   
         if(lsnsReceive){
            receiveEvent.readed = c;
            lsnsReceive.process(receiveEvent);
         }
      }
      
      //============================================================
      // <T>出现输入输出错误。</T>
      // 
      // @params p:event 输入输出错误事件
      //============================================================
      public function onIoError(e:IOErrorEvent):void{
         if(loggered){
            _logger.debug("onError", "Socket io error. {event={1}}", e);
         }
         if(lsnsSecurity){
            lsnsError.process(new FEvent);
         }
      }
      
      //============================================================
      // <T>出现输入输出错误。</T>
      // 
      // @params e:event 输入输出错误事件
      //============================================================
      public function onSecurity(e:SecurityErrorEvent):void{
         if(loggered){
            _logger.debug("onSecurity", "Socket security error. {event={1}}", e);
         }
         if(lsnsSecurity){
            lsnsSecurity.process(new FEvent);
         }
      }
      
      //============================================================
      // <T>套接字是否已经连接。</T>
      // 
      // @return 是否连接
      //============================================================
      public function get connected():Boolean{
         return socket ? socket.connected : false;
      }
      
      //============================================================
      // <T>将套接字连接到指定的主机和端口。。</T>
      // 
      // @params ph:host 要连接到的主机的IP地址
      // @params pp:port 要连接的端口号
      //============================================================
      public function connect(ph:String, pp:int):void{
         // 断开处理
         disconnect();
         // 创建网络链接
         try{
            socket = new Socket();
            socket.endian = Endian.LITTLE_ENDIAN;
            // 监听连接成功事件
            socket.addEventListener(Event.CONNECT, onConnect);
            // 监听关闭事件
            socket.addEventListener(Event.CLOSE, onClose);
            // 监听错误处理
            socket.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
            // 监听错误处理
            socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurity);
            // 监听服务器新信息
            socket.addEventListener(ProgressEvent.SOCKET_DATA, onReceive);
            // 设置超时
            socket.timeout = RGlobal.socketConnectTimeout;
            // 连接服务器
            socket.connect(ph, pp);
            if(loggered){
               _logger.debug("connect", "Socket connect. (host={1}:{2})", ph, pp);
            }
         }catch(e:Error){
            _logger.error("connect", "Socket connect failure. (host={1}:{2})", ph, pp);
         }
      }
      
      //============================================================
      // <T>套接字发送数据。</T>
      // 
      // @param pd:data 要发送的数据
      // @param po:offset 位置 
      // @param pl:length 长度
      //============================================================
      public function sendBytes(pd:ByteArray, po:int = 0, pl:int = 0):void{
         if(loggered){
            _logger.debug("sendBytes", "Socket send data. (length={1})", pl);
         }
         socket.writeBytes(pd, po, pl);
      }
      
      //============================================================
      // <T>套接字输出缓冲区中积累的所有数据进行刷新。</T>
      //============================================================
      public function flush():void{
         socket.flush();
      }
      
      //============================================================
      // <T>关闭套接字。</T>
      //============================================================
      public function disconnect():void{
         // 卸载事件
         if(null != socket){
            try{
               // 卸载连接成功事件
               socket.removeEventListener(Event.CONNECT, onConnect);
               // 卸载关闭事件
               socket.removeEventListener(Event.CLOSE, onClose);
               // 卸载错误处理
               socket.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
               // 卸载错误处理
               socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurity);
               // 卸载服务器新信息
               socket.removeEventListener(ProgressEvent.SOCKET_DATA, onReceive);
            }catch(e:Error){
               _logger.error("disconnect", "Socket remove event failure.");
            }
            // 关闭事件
            onClose(null);
            // 关闭处理
            try{
               socket.close();
            }catch(e:Error){
               _logger.error("disconnect", "Socket close failure.");
            }
            socket = null;
         }
      }
   }
}