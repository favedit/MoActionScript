package mo.cm.cache
{
   import flash.net.SharedObject;
   
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>缓冲对象。</T>
   //============================================================
   public class RCache
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(RCache);
      
      // 缓冲数据限制
      public static var byteLimit:int = 1024 * 1024 * 16;
      
      // 缓冲数据流集合
      public static var streams:Vector.<FCacheStream> = new Vector.<FCacheStream>();
      
      // 自由缓冲数据流集合
      public static var catchStreams:Vector.<FCacheStream> = new Vector.<FCacheStream>();
      
      // 存储对象
      public static var _data:SharedObject = SharedObject.getLocal("local_storge");
      
      //============================================================
      // <T>计算全部字节总数.</T>
      //
      // @return 字节总数;
      //============================================================
      public static function calculateTotalBytes():int{
         var t:int = 0;
         var c:int = streams.length;
         for(var n:int = 0; n < c; n++){
            t += streams[n].length;
         }
         return t;
      }
      
      //============================================================
      // <T>创建一块临时数据.</T>
      //
      // @param p:size 大小
      // @reutrn 临时数据
      //============================================================
      public static function allocStream(p:int = 0):FCacheStream{
         // 创建新缓冲流
         var r:FCacheStream = null;
         if(catchStreams.length > 0){
            r = catchStreams.pop();
         }else{
            r = new FCacheStream();
            streams.push(r);
         }
         // 关联数据
         r.link();
         if(0 != p){
            r.ensureSize(p);
         }
         return r;
      }
      
      //============================================================
      // <T>释放一块临时数据.</T>
      //
      // @param p:stream 临时数据
      //============================================================
      public static function freeStream(p:FCacheStream):void{
         if(null != p){
            // 检查上限
            var t:int = calculateTotalBytes();
            if(t > byteLimit){
               p.clear();
            }
            // 取消链接
            p.unlink();
            catchStreams.push(p);
         }
      }
      
      //============================================================
      // <T>获取指定数据.</T>
      public static function setup():void{
         // 手动设定本地存储大小为无限制
         _data.flush(10000000000);
      }
      
      //============================================================
      // <T>获取指定数据.</T>
      public static function get(name:String):Object{
         return _data.data[name];
      }
      
      //============================================================
      // <T>设置指定数据.</T>
      public static function set(name:String, value:Object):void{
         _data.data[name] = value;
      }
      
      //============================================================
      // <T>写入本地存储文件.</T>
      public static function flush():void{
         _data.flush();
      }
      
      //============================================================
      // <T>获得内部信息.</T>
      //============================================================
      public static function dump():void{
         var c:int = streams.length;
         var t:int = calculateTotalBytes();
         _logger.debug("dump", "Dump info. (count={1}, total={2})", c, t);
      }
   }
}