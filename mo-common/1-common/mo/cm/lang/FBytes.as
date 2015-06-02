package mo.cm.lang
{
   import flash.sampler.getSize;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   //============================================================
   // <T>字节数组。</T>
   //============================================================
   public class FBytes extends FObject
   {
      // 字节内存
      public var memory:ByteArray = new ByteArray();
      
      //============================================================
      // <T>创建字节数组。</T>
      //============================================================
      public function FBytes(){
         memory.endian = Endian.LITTLE_ENDIAN; 
      }
      
      //============================================================
      // <T>获得数据长度。</T>
      //
      // @return 数据长度
      //============================================================
      public final function get length():int{
         return memory.length;
      }
      
      //============================================================
      // <T>设置数据长度。</T>
      //
      // @param p:length 数据长度
      //============================================================
      public final function set length(p:int):void{
         memory.length = p;
      }
      
      //============================================================
      // <T>获得当前位置。</T>
      //
      // @return 当前位置
      //============================================================
      public final function get position():int{
         return memory.position;
      }
      
      //============================================================
      // <T>设置当前位置。</T>
      //
      // @param p:position 当前位置
      //============================================================
      public final function set position(p:int):void{
         memory.position = p;
      }
      
      //============================================================
      // <T>获得剩余长度。</T>
      //
      // @param p:position 当前位置
      //============================================================
      public final function get remain():int{
         return memory.bytesAvailable;
      }
      
      //============================================================
      // <T>删除左部分数据。</T>
      //
      // @param p:position 位置
      //============================================================
      [Inline]
      public final function deleteLeft(p:uint):void{
         var l:uint = memory.length - p;
         memory.position = 0;
         memory.writeBytes(memory, p, l);
         memory.length = l;
         memory.position = 0;
      }
      
      //============================================================
      // <T>标记有效数据块。</T>
      //============================================================
      [Inline]
      public final function flip():void{
         memory.length = memory.position;
         memory.position = 0;
      }
      
      //============================================================
      // <T>清除内存。</T>
      //============================================================
      public function clear():void{
         memory.length = 0;
      }
      
      //============================================================
      // <T>获得运行大小。</T>
      //
      // @return 运行大小
      //============================================================
      public override function get runtimeSize():int{
         var r:int = getSize(this);
         r += getSize(memory)
         return r;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != memory){
            memory.clear();
            memory = null;
         }
         super.dispose();
      }
   }
}