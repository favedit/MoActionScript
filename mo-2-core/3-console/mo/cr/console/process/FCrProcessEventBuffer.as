package mo.cr.console.process
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   //============================================================
   // <T>进程事件缓冲。</T>
   //============================================================
   public class FCrProcessEventBuffer extends FCrProcessEvent
   {
      //============================================================
      // <T>构造进程事件缓冲。</T>
      //============================================================
      public function FCrProcessEventBuffer(){
      }
      
      //============================================================
      // <T>加载数据流。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function load(p:ByteArray):void{
         // 设置属性
         p.position = 0; 
         p.endian = Endian.LITTLE_ENDIAN;
         // 读取代码
         code = p.readInt();
         // 存储数值
         data.position = 0;
         data.writeBytes(p, 0, p.length);
         data.position = 0;
      }
   }
}