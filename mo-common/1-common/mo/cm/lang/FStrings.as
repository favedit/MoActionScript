package mo.cm.lang
{
   //============================================================
   // <T>字符串集合。</T>
   //============================================================
   public class FStrings extends FObject
   {
      public var values:Vector.<String> = new Vector.<String>();
      
      //============================================================
      // <T>构造字符串集合。</T>
      //============================================================
      public function FStrings(){
      }
      
      //============================================================
      // <T>列表是否为空。</T>
      //
      // @return Boolean
      //============================================================
      public function isEmpty():Boolean{
         return (0 == values.length);
      }
      
      //============================================================
      // <T>获得字符串列表的总数。</T>
      //
      // @return 总数
      //============================================================
      public function get count():uint{
         return values.length;
      }
      
      //============================================================
      // <T>列表是否包含指定内容。</T>
      //
      // @param p:value 数据内容
      // @return 是否包含
      //============================================================
      public function contains(p:String):Boolean{
         return (-1 != values.indexOf(p));
      }
      
      //============================================================
      // <T>获得指定值的位置。</T>
      //
      // @param p:value 指定内容
      // @return int 索引位置
      //============================================================
      public function indexOf(p:String):int{
         return values.indexOf(p);
      }
      
      //============================================================
      // <T>判断两个列表是否相等。</T>
      //
      // @param p:list 列表
      // @return 是否相等
      //============================================================
      public function equals(p:FStrings):Boolean{
         var c:int = values.length;
         if(p.count != c){
            return false;
         }else{
            for(var n:int = 0; n < c; n++){
               if(values[n] != p.get(n)){
                  return false;
               }
            }
         }
         return true;
      }
      
      //============================================================
      // <T>获得指定索引位置的字符串内容。</T>
      //
      // @params p:index 索引
      // @return 字符串内容
      //============================================================
      public function get(p:int):String{
         return values[p];
      }
      
      //============================================================
      // <T>设置指定索引位置的字符串内容。</T>
      //
      // @params pi:index 索引位置
      // @params pv:value 字符串内容
      //============================================================
      public function set(pi:int, pv:String):void{
         if((-1 != pi) && (pi < count)){
            values[pi] = pv;
         }
      }
      
      //============================================================
      // <T>在头部压入字符串内容。</T>
      //
      // @params p:value 字符串内容
      //============================================================
      public function unshift(p:String):void{
         values.unshift(p);
      }
      
      //============================================================
      // <T>弹出头部的字符串内容。</T>
      //
      // @return 字符串内容
      //============================================================
      public function shift():String{
         return values.shift();
      }
      
      //============================================================
      // <T>插入尾元素。</T>
      //
      // @params value 值
      //============================================================
      public function push(value:String):void{
         values.push(value);
      }
      
      //============================================================
      // <T>在尾部插入多个元素。</T>
      //
      // @return value 值
      //============================================================
      public function pushs(...values):void{
         values.concat(values);
      }
      
      //============================================================
      // <T>弹出尾元素。</T>
      //
      // @return value 值
      //============================================================
      public function pop():String{
         return values.pop();
      }
      
      //============================================================
      // <T>追加一个列表。</T>
      //
      // @params FStrings 列表
      //============================================================
      public function append(list:FStrings):void{
         values.concat(list.values);
      }
      
      //============================================================
      // <T>清空指定位置的值。</T>
      //
      // @params FStrings 列表
      //============================================================
      public function erase(index:int):Object{
         var value:Object = null;
         if(-1 != index && index < count){
            value = values[index];
            values[index] = null;
         }
         return value;
      }
      
      //============================================================
      // <T>移除列表中的所有职位value的项目。</T>
      //
      // @params value 值
      //============================================================
      public function remove(value:String):void{
         var index:int = values.indexOf(value);
         while(-1 != index){
            values.splice(index, 1);
            index = values.indexOf(value);
         }
      }
      
      //============================================================
      // <T>清除对象。</T>
      //
      //============================================================
      public function clear():void{
         values.splice(0, values.length);
      }
      
      //============================================================
      public function dump(level:int):String{
         return null;
      }
   }
}