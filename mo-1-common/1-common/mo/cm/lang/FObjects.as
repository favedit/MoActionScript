package mo.cm.lang
{
   //============================================================
   // <T>对象集合。</T>
   //============================================================
   public class FObjects extends FObject  
   {
      // 存储集合
      public var items:Vector.<FObject>;
      
      //============================================================
      // <T>创建实例对象。</T>
      //
      // @return 实例对象
      //============================================================
      public function FObjects(capacity:int=0){
         if(capacity > 0){
            items = new Vector.<FObject>(capacity, true);
         }else{
            items = new Vector.<FObject>();
         }
      }
      
      //============================================================
      // <T>判断是否为空</T>
      //
      // @return 是否为空
      //============================================================
      public function isEmpty():Boolean{
         return (0 == items.length);
      }
      
      //============================================================
      // <T>获得对象总数</T>
      //
      // @return 对象总数
      //============================================================
      public function get count():int{
         return items.length;
      }
      
      //============================================================
      // <T>获取当前对象的索引</T>
      //
      // @params p:value 对象
      // @return 对象总数
      //============================================================
      public function indexof(p:FObject):int{
         return items.indexOf(p);
      }
      
      //============================================================
      // <T>获得对象总数</T>
      //
      // @param p:value 对象
      // @return 是否存在
      //============================================================
      public function constains(p:FObject):Boolean{
         return -1 != items.indexOf(p, 0);
      }
      
      //============================================================
      // <T>获得索引位置的对象。</T>
      //
      // @param index 索引位置
      // @return 对象
      //============================================================
      public function get(index:int):FObject{
         return items[index];
      }
      
      //============================================================
      // <T>获得索引位置的对象。</T>
      //
      // @param index 索引位置
      // @param value 缺省对象
      // @return 对象
      //============================================================
      public function nvl(index:int, value:FObject=null):FObject{
         return (index >=0 && index < items.length) ? items[index] : value;
      }
      
      //============================================================
      // <T>在当前索引位置插入一个值，</T>
      //
      // @param index 索引位置
      // @param value 缺省对象
      // @author HECNG 20120323
      //============================================================
      public function insert(index:int, value:FObject):void{
         if(index >= count){
            push(value);
         }else{
            var next:FObject = get(index);
            var curr:FObject;
            var length:int = count - index;
            set(index, value);
            for(var n:int = 0; n < length; n++ ){
               var i:int = index + n + 1;
               if(i < count){
                  curr = get(i);
                  set(i, next);
                  next = curr;
               }else{
                  push(next);
               }
            }  
         }
      }
      
      //============================================================
      // <T>设置索引位置的对象。</T>
      //
      // @param index 索引位置
      // @param value 对象
      //============================================================
      public function set(index:int, value:FObject):void{
         items[index] = value;
      }
      
      //============================================================
      // <T>增加一个对象到首部。</T>
      //
      // @param value 对象
      //============================================================
      public function unshift(value:FObject):void{
         items.unshift(value);
      }
      
      //============================================================
      // <T>从首部弹出一个对象。</T>
      //
      // @return 对象
      //============================================================
      public function shift():FObject{
         return items.shift();
      }
      
      //============================================================
      // <T>增加一个对象到尾部。</T>
      //
      // @param value 对象
      //============================================================
      public function push(value:FObject):void{
         items.push(value);
      }
      
      //============================================================
      // <T>从尾部弹出一个对象。</T>
      //
      // @return 对象
      //============================================================
      public function pop():FObject{
         return items.pop();
      }
      
      //============================================================
      // <T>增加一个对象集合到尾部。</T>
      //
      // @param values 对象集合
      //============================================================
      public function append(p:FObjects):void{
         var loop:int = p.count;
         for(var n:int = 0; n < loop; n++){
            p.items.push(p.items[n]);
         }
      }
      
      //============================================================
      // <T>移除指定对象。</T>
      //
      // @param object 指定对象
      //============================================================
      public function remove(p:FObject):void{
         var index:int = items.indexOf(p);
         if(-1 != index){
            items.splice(index, 1);
         }
      }
      
      //============================================================
      // <T>清除所有对象。</T>
      //============================================================
      public function clear():void{
         items.length = 0;
      }
   }  
}