package mo.cm.lang
{
   import flash.sampler.getSize;
   import flash.utils.Dictionary;
   
   import mo.cm.reflection.RType;
   import mo.cm.reflection.SClassInfo;
   
   //============================================================
   // <T>键值对存储表。</T>
   //============================================================
   public class FMap extends FObject
   {
      // 存储器
      public var storage:Dictionary = new Dictionary(); 
      
      // 名称集合
      public var names:Vector.<Object> = new Vector.<Object>();
      
      // 内容集合
      public var values:Vector.<Object> = new Vector.<Object>();
      
      //============================================================
      // <T>创建键值对存储表。</T>
      //============================================================
      public function FMap(){
      }
      
      //============================================================
      // <T>判断map是否为空。</T>
      //
      //@return Boolean 是否为空
      //============================================================
      public function isEmpty():Boolean{
         return (0 == names.length);
      }
      
      //============================================================
      // <T>判断map是否为空。</T>
      //
      //@return Boolean 是否为空
      //============================================================
      public function get count():uint{
         return names.length;
      }
      
      //============================================================
      // <T>判断是否包含指定名称的值。</T>
      //
      //@param p:name 名称
      //@return Boolean 是否为空
      //============================================================
      public function contains(p:Object):Boolean{
         return (null != storage[p]);
      }
      
      //============================================================
      // <T>判断是否包含指定的值。</T>
      //
      //@param Object value
      //@return Boolean 是否为空
      //============================================================
      public function containsValue(p:Object):Boolean{
         return (values.indexOf(p) != -1);
      }
      
      //============================================================
      // <T>获得指定名称首次出现的位置。</T>
      //
      //@param Object name
      //@return int 位置
      //============================================================
      public function indexOf(p:Object):int{
         var v:Object = storage[p];
         // return (null != v) ? parseInt(v) : -1;
         return -1;
      }
      
      //============================================================
      // <T>获得指定值首次出现的位置。</T>
      //
      //@param Object value
      //@return int 位置
      //============================================================
      public function indexOfValue(value:Object):int{
         return (values.indexOf(value));
      }
      
      //============================================================
      // <T>获得指定值首次出现的位置。</T>
      //
      //@param Object value
      //@return int 位置
      //============================================================
      public function indexOfName(name:Object):int{
         return (names.indexOf(name));
      }
      
      //============================================================
      // <T>判断两个map是否相等。</T>
      //
      //@param FMap map 指定map
      //@return Boolean 是否相等 
      //============================================================
      public function equals(map:FMap):Boolean{
         // 先判断数量是否相等
         var count:int = names.length;
         if(map.names.length != count){
            return false;
         }
         // 内容相等就是相等的，与顺序无关
         for(var n:int=0; n < count; n++){
            var name:Object = names[n];
            if(values[n] != map.get(name)){
               return false;
            }
         }
         return true;
      }
      
      //============================================================
      // <T>获得指定位置的名称。</T>
      //
      //@param index 索引位置
      //@return Object 名称对象 
      //============================================================
      public function name(index:int):Object{
         return (index >= 0 && index < names.length) ? names[index] : null;
      }
      
      //============================================================
      // <T>获得指定位置的值。</T>
      //
      //@param index 索引位置
      //@return Object 值对象 
      //============================================================
      public function value(index:int):Object{
         return (index >= 0 && index < values.length) ? values[index] : null;
      }
      
      //============================================================
      // <T>设置指定位置的值，如果索引位置错误，则不执行。</T>
      //
      //@param index 索引位置
      //@param value 内容
      //============================================================
      public function setValue(index:int, value:Object):void{
         if(index >= 0 && index < values.length){
            values[index] = value;
         }
      }
      
      //============================================================
      // <T>获得指定名称的值。</T>
      //
      //@param name 名称
      //@return value 内容
      //============================================================
      public function get(name:Object):Object{
         var ptr:String = storage[name];
         return (null != ptr) ? values[parseInt(ptr)] : null;
      }
      
      //============================================================
      // <T>设置指定名称的值，如果查找到，则直接赋值，否则直接添加。</T>
      //
      //@param name 名称
      //@return value 内容
      //============================================================
      public function set(name:Object, value:Object):void{
         var ptr:String = storage[name];
         if(null != ptr){
            values[parseInt(ptr)] = value;
         }else{
            var length:uint = names.push(name);
            values.push(value);
            storage[name] = length - 1;
         }
      }
      
      //============================================================
      // <T>将指定位置的值清空，不删除。</T>
      //
      // @param index 索引位置
      // @return value 擦除的值
      //============================================================
      public function erase(index:int):Object{
         var value:Object = null;
         var count:int = names.length;
         if(index >= 0 && index < count){
            var name:Object = names[index];
            value = values[index];
            delete storage[name];
            names.splice(index, 1);
            values.splice(index, 1);
            // 设置对照顺序
            count--;
            for(var n:int=index; n<count; n++){
               storage[names[n]] = n;  
            }
         }
         return value;
      }
      
      //============================================================
      // <T>删除指定名称的对照。</T>
      //
      // @param index 索引位置
      // @return value 删除的值
      //============================================================
      public function remove(name:Object):Object{
         var ptr:String = storage[name];
         return (null != ptr) ? erase(parseInt(ptr)) : null;
      }
      
      //============================================================
      // <T>清空对照表。</T>
      //
      // @param index 索引位置
      //============================================================
      public function clear():void{
         // 清空对照表
         for(var name:Object in storage){
            storage[name] = null;
         }
         
         var nc:int = names.length;
         for(var n:int = 0; n < nc; n++){
            names[n] = null;
         }
         
         var vc:int = values.length;
         for(var m:int = 0; n < vc; m++){
            values[m] = null;
         }
         // 清空名称和内容数组
         names.length = 0; 
         values.length = 0;
      }
      
      //============================================================
      // <T>清空对照表。</T>
      //
      // @param index 索引位置
      //============================================================
      public override function dispose():void{
         super.dispose()
         clear();
         // 清空名称和内容数组
         names = null;
         values = null;
      }
      
      //============================================================
      // <T>获得运行总大小。</T>
      //
      // @return 运行总大小
      //============================================================
      public override function runtimeCalculateTotal(p:SClassInfo):int{
         var r:int = getSize(this);
         r += getSize(storage);
         var c:int = names.length;
         for(var i:int = 0; i < c; i++){
            var n:Object = names[i];
            if(n){
               if(-1 == p.instances.indexOf(n)){
                  p.instances.push(n);
                  r += RType.calculateTotal(n, p);
               }
            }
            var v:Object = values[i];
            if(v){
               if(-1 == p.instances.indexOf(v)){
                  p.instances.push(v);
                  r += RType.calculateTotal(v, p);
               }
            }
         }
         return r;
      }
      
      //============================================================
      public function dump(level:int):String{
         return null;
      }
   }
}