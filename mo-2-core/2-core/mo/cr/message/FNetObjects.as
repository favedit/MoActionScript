package mo.cr.message
{
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>网络对象容器。</T>
   //============================================================
   public class FNetObjects extends FObject
   {
      // 类对象
      public var clazz:Class;
      
      // 当前个数
      public var count:int;
      
      // 存储数组
      public var objects:Array = new Array();
      
      // 总数
      public var total:int;
      
      //============================================================
      // <T>构造网络对象容器。</T>
      //
      // @param pc:class 类对象
      // @param pt:count 总数
      //============================================================
      public function FNetObjects(pc:Class, pt:int = -1){
         clazz = pc;
         total = pt;
      }
      
      //============================================================
      // <T>同步指定索引位置的对象。</T>
      //
      // @param index 索引位置
      // @return 对象
      //============================================================
      protected function innerSync(index:int):INetObject{
         var object:INetObject = objects[index] as INetObject;
         if(null == object){
            object = new clazz();
            objects[index] = object; 
         }
         return object;
      }
      
      //============================================================
      // <T>收集一个对象。</T>
      //
      // @return 对象
      //============================================================
      public function alloc():INetObject{
         return innerSync(count++);
      }
      
      //============================================================
      // <T>获得指定索引位置的对象。</T>
      //
      // @param index 索引位置
      // @return 对象
      //============================================================
      public function get(index:int):INetObject{
         var object:INetObject = null;
         if(index >=0 && index < count){
            object = objects[index];
         }
         return object;
      }
      
      //============================================================
      // <T>接收对象列表内容。</T>
      //
      // @param objects 对象列表
      //============================================================
      public function assign(objects:FNetObjects):void{
         count = objects.count;
         for(var n:int = 0; n < count; n++){
            var object:INetObject = innerSync(n) as INetObject;
            object.assign(objects.get(n));
         }
      }
      
      //============================================================
      // <T>序列化对象列表到输入流中。</T>
      //
      // @param output 输入流
      //============================================================
      public function serialize(output:IOutput):void{
         output.writeInt16(count);
         for(var n:int = 0; n < count; n++){
            var object:INetObject = objects[n] as INetObject;
            object.serialize(output);
         }
      }
      
      //============================================================
      // <T>从输出流中反序列化对象列表。</T>
      //
      // @param output 输入流
      //============================================================
      public function unserialize(input:IInput):void{
         count = input.readInt16();
         for(var n:int = 0; n < count; n++){
            var object:INetObject = innerSync(n) as INetObject;
            object.unserialize(input);
         }
      }
      
      //============================================================
      // <T>重置内容。</T>
      //============================================================
      public function sortOn(compare:Function):void{
         objects.sort(compare);
      }
      
      //============================================================
      // <T>重置内容。</T>
      //============================================================
      public function reset():void{
         count = 0;
      }
   }
}