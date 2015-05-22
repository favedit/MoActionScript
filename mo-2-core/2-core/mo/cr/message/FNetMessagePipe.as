package mo.cr.message
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.logger.RLogger;
   import mo.cm.stream.FByteStream;
   import mo.cm.stream.FPipe;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>消息管道。</T>
   //============================================================
   public class FNetMessagePipe extends FPipe
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FNetMessagePipe); 
      
      // 临时数据
      public var temp:ByteArray = new ByteArray();
      
      //============================================================
      // <T>构造消息管道。</T>
      //============================================================
      public function FNetMessagePipe(){
         temp.endian = Endian.LITTLE_ENDIAN;
      }
      
      //============================================================
      // <T>取出一段数据。</T>
      //
      // @pramas pb:bytes 字节流
      // @pramas pz:length 长度
      //============================================================
      public function popData():FByteStream{
         var p:FByteStream = null;
         var c:int = length;
         if(c >= 4){
            // 读取长度
            var l:int = capacity - first;
            temp.position = 0;
            if(l >= 4){
               temp.writeBytes(memory, first, 4);
            }else{
               temp.writeBytes(memory, first, l);
               temp.writeBytes(memory, 0, 4 - l);
            }
            temp.position = 0;
            var r:int = temp.readInt();
            // 读取数据
            if(r <= c){
               p = new FByteStream();
               if(first + r <= last){
                  p.writeBytes(memory, first, r);
                  first += r;
               }else{
                  var w:int = capacity - first;
                  if(r <= w){
                     p.writeBytes(memory, first, r);
                     first += r;
                  }else{
                     p.writeBytes(memory, first, w);
                     p.writeBytes(memory, 0, r - w);
                     first = r - w;
                  }
               }
            }
            // 输出调试信息
            if(RLogger.deepDebugAble){
               _logger.debug("popData", "Pop message data. (caption={1}, length={2}({3}~{4}), remain={5}, read={6})",
                  capacity, c, first, last, remain, r);
            }
         }
         return p;
      }
   }
}