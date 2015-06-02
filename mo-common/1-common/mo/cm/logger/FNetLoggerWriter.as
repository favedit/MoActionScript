package mo.cm.logger
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.lang.RDate;
   import mo.cm.lang.RInteger;
   import mo.cm.lang.RString;
   import mo.cm.net.FSocket;
   import mo.cm.system.RProcess;
   
   //============================================================
   // <T>网络日志输出器。</T>
   //============================================================
   public class FNetLoggerWriter extends FLoggerWriter
   {
      // 是否链接
      public var connected:Boolean;
      
      // 网络链接
      public var socket:FSocket = new FSocket();
      
      // 日志列表
      public var loggers:Vector.<String> = new Vector.<String>();
      
      // 数据
      public var data:ByteArray = new ByteArray();
      
      //============================================================
      // <T>构造网络日志输出器。</T>
      //
      // @param ph:host 主机
      // @param pp:port 端口
      //============================================================
      public function FNetLoggerWriter(ph:String = "127.0.0.1", pp:int = 999){
         // 设置数据
         data.endian = Endian.LITTLE_ENDIAN;
         // 设置网络
         socket.loggered = false;
         socket.lsnsConnect.register(onConnect, this);
         socket.lsnsError.register(onError, this);
         socket.connect(ph, pp);
      }
      
      //============================================================
      // <T>构造网络日志输出器。</T>
      //
      // @param ph:host 主机
      // @param pp:port 端口
      //============================================================
      public function onConnect(e:*):void{
         connected = true;
         flush();
      }
      
      //============================================================
      // <T>构造网络日志输出器。</T>
      //
      // @param ph:host 主机
      // @param pp:port 端口
      //============================================================
      public function onError(e:*):void{
         connected = false;
      }
      
      //============================================================
      // <T>格式化日志内容。</T>
      //
      // @param pl:level 级别
      // @param pc:class 类名称
      // @param pm:method 函数名称
      // @param pt:tick 时刻
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public override function format(pl:int, pc:String, pm:String, pt:int, ps:String, pp:Array):String{
         var r:String = RDate.format(RDate.now(), "YYMMDD-HH24MISS.MS|");
         r += ELogger.toSimple(pl) + ".WRK-" + RInteger.lpad(RProcess.processId, 4);
         var instance:String = pc + '.' + pm;
         r += " [ " + RString.rpad(instance, 48)  + " @flash ] ";
         // 替换埋入参数
         for(var n:uint = 0; n < pp.length; n++) {
            ps = ps.replace("{" + (n + 1) + "}", pp[n]);
         }
         return r + ps;
      }
      
      //============================================================
      // <T>格式化内容输出。</T>
      //
      // @param pl:level 级别
      // @param pc:class 类名称
      // @param pm:method 函数名称
      // @param ps:source 消息来源
      // @param pp:parameters 参数集合
      //============================================================
      public override function output(pl:int, pc:String, pm:String, pt:int, ps:String, pp:Array):void{
         var r:String = format(pl, pc, pm, pt, ps, pp);
         // 为链接时
         if(!connected){
            loggers.push(r);
         }else{
            // 输出当前日志
            if(r){
               data.position = 0;
               data.writeUTF(r);
               data.writeInt(0);
               data.length = data.position;
               data.position = 0;
               socket.sendBytes(data);
               socket.flush();
            }
         }
      }
      
      //============================================================
      // <T>刷新残留日志。</T>
      //============================================================
      public function flush():void{
         // 输出所有缓存日志
         var c:int = loggers.length;
         if(c){
            data.position = 0;
            for(var n:int = 0; n < c; n++){
               data.writeUTF(loggers[n]);
               data.writeInt(0);
               loggers[n] = null;
            }
            data.length = data.position;
            data.position = 0;
            socket.sendBytes(data);
            socket.flush();
         }
         loggers.length = 0;
      }
   }
}