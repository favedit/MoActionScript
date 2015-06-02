package mo.cm.stream
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.core.device.RFatal;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>管道。</T>
   //============================================================
   public class FPipe extends FObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FPipe); 

      // 间隔
      public static const Interval:int = 16;

      // 容量
      public var capacity:int = 1024;

      // 内存
      public var memory:ByteArray = new ByteArray();

      // 首指针
      public var first:int;
      
      // 尾指针
      public var last:int;
      
      //============================================================
      // <T>构造管道。</T>
      //============================================================
      public function FPipe(){
         memory.endian = Endian.LITTLE_ENDIAN;
         memory.length = capacity;
      }
      
      //============================================================
      // <T>获取可用长度。</T>
      //
      // @return 长度
      //============================================================
      public function get length():int{
         if(last >= first){
            return (last - first);
         }
         return last + capacity - first;
      }
      
      //============================================================
      // <T>可用空闲长度。</T>
      //
      // @return 长度
      //============================================================
      public function get remain():int{
         if(first <= last){
            return capacity - last + first - Interval;
         }
         return first - last - Interval;
      }
      
      //============================================================
      // <T>扩展管道。</T>
      //============================================================
      public function ensureSize(p:int):void{
         if(p > capacity){
            var c:int = (p / capacity) + 1;
            var t:int = capacity * c;
            if(first == last){
               first = 0;
               last = 0;
               memory.length = t;
            }else if(first < last){
               memory.length = t;
            }else if(last > 0){
               var m:ByteArray = new ByteArray();
               m.endian = Endian.LITTLE_ENDIAN;
               m.writeBytes(memory, first, capacity - first);
               m.writeBytes(memory, 0, last);
               memory.length = t;
               memory.position = 0;
               memory.writeBytes(m, 0, m.length);
               m.clear();
               m = null;
               first = 0;
               last = memory.position;
            }
            capacity = t;
         }
      }

      //============================================================
      // <T>放入一段数据。</T>
      //
      // @prama pb:bytes 字节流
      // @prama po:offset 位置
      // @prama pl:length 长度
      //============================================================
      public function write(pb:ByteArray, po:int = 0, pl:int = -1):void{
         // 计算长度
         if(-1 == pl){
            pl = pb.length;
         }
         // 扩展内存
         var r:int = remain;
         if(pl > r){
            ensureSize(capacity + pl);
         }
         // 写入数据
         if(pl > 0){
            memory.position = last;
            var w:int = capacity - last;
            if(pl < w){
               memory.writeBytes(pb, 0, pl);
               last += pl;
            }else if(pl == w){
               memory.writeBytes(pb, 0, pl);
               last = 0;
            }else{
               last = pl - w;
               memory.writeBytes(pb, 0, w);
               memory.position = 0;
               memory.writeBytes(pb, w, last);
            }
            // 输出调试信息
            if(RLogger.deepDebugAble){
               _logger.debug("write", "Write net data. (caption={1}, length={2}({3}~{4}), remain={5}, write={6})",
                  capacity, length, first, last, r, pl);
            }
         }
      }
      
      //============================================================
      // <T>放入一段数据。</T>
      //
      // @prama pb:bytes 字节流
      // @prama pl:length 长度
      //============================================================
      public function push(pb:ByteArray, pl:int):void{
         var r:int = remain;
         if(r < pl){
            ensureSize(pl - r);
         }
         if(pl > 0){
            memory.position = last;
            var d:int = pl - (capacity - last);
            if(last >= first && d > 0){
               memory.writeBytes(pb, 0, capacity - last);
               memory.position = 0;
               memory.writeBytes(pb, capacity - last, pl);
               last = d;
            }else{
               memory.writeBytes(pb, 0, pl);
               last += pl;
            }
         }
      }
      
      //============================================================
      // <T>取出一段数据。</T>
      //
      // @pramas pb:bytes 字节流
      // @pramas pz:length 长度
      //============================================================
      public function pop(pb:ByteArray, pz:int):void{
         if(length < pz){
            // 要取出的数据长度大于拥有的数据长度
            RFatal.throwFatal("");
         }
         if((length > 0) && (pz > 0)){
            var d:int = pz - (capacity - first);
            if((first > last) && (d > 0)){
               pb.writeBytes(memory, first, capacity - first);
               pb.writeBytes(memory, 0, d);
               first = d;
            }else{
               pb.writeBytes(memory, first, pz);
               first += pz;
            }
         }      
      }
      
      //============================================================
      // <T>清空管道。</T>
      //============================================================
      public function clear():void{
         first = 0;
         last = 0;
      }
      
      //============================================================
      // <T>销毁管道。</T>
      //============================================================
      public function release():void{
         memory.length = 0;
         memory = null;
      }
   }
}