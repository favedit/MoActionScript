package mo.cm.lang
{
   //============================================================
   // <T>集合。</T>
   //============================================================
   public class FUintSet extends FAbsUintSet
   {
      public var values:Vector.<Object> = new Vector.<Object>();
      
      //============================================================
      // <T>创建对象实例。</T>
      //============================================================
      public function FUintSet(){
      }
      
      //============================================================
      // <T>判断两个集合是否相等。</T>
      //
      //@param p:set 指定集合
      //@return Boolean 是否相等 
      //============================================================
      public function equals(p:FSet):Boolean{
         var length:uint = values.length;
         var n:uint = 0;
         while(values[n] == p.values[n]){
            n++;
            if(n > length -1){
               return true;
            }
         }
         return false;
      }
      
      //============================================================
      // <T>获得指定位置的内容。</T>
      //
      // @param p:int 索引位置
      // @return * 内容
      //============================================================
      public function value(p:int):*{
         return values[p];
      }
      
      //============================================================
      // <T>设置指定ID的内容。</T>
      //
      // @param pi:int ID
      // @param pi:* 内容
      // @return void
      //============================================================
      public function swap(index1:int, index2:int):void{
         var id1:uint = names[index1];
         var id2:uint = names[index2];
         var v1:Object = values[index1];
         var v2:Object = values[index2];
         values[index1] = v2;
         values[index2] = v1;
         names[index1] = id2;
         names[index2] = id1;
         storage[id1] = index2;
         storage[id2] = index1;
      }
      
      //============================================================
      // <T>获得指定ID的内容。</T>
      //
      // @param p:int ID
      // @return * 内容
      //============================================================
      public function get(p:uint):*{
         var v:* = storage[p];
         if((undefined != v) && (-1 != v)){
            return values[v];
         }
         return null;
      }
      
      //============================================================
      // <T>设置指定ID的内容。</T>
      //
      // @param pi:int ID
      // @param pi:* 内容
      // @return void
      //============================================================
      public function set(pi:uint, pv:*):void{
         var v:* = storage[pi];
         if(undefined != v){
            if(v >= 0){
               values[v] = pv;
            }else{
               storage[pi] = values.length;
               names.push(pi);
               values.push(pv);
            }
         }else{
            storage[pi] = values.length;
            names.push(pi);
            values.push(pv);
         }
      }
      
      //============================================================
      // <T>擦除指定ID的内容。</T>
      //
      // @param p:int ID
      // @return r:* 要擦除的内容
      //============================================================
      public function eraseId(p:uint):*{
         var r:* = null;
         var v:* = storage[p];
         if(undefined != v){
            var i:int = v;
            r = values[i];
            values[i] = null;
         }
         return r;
      }
      
      //============================================================
      // <T>擦除指定索引的内容。</T>
      //
      // @param p:int 索引
      // @return r:* 要擦除的内容
      //============================================================
      public function eraseIndex(p:int):*{
         var r:* = values[p];
         values[p] = null;
         return r;
      }
      
      //============================================================
      // <T>删除指定ID的键和内容。</T>
      //
      // @param p:int ID
      // @return r:* 要删除的内容
      //============================================================
      public function remove(p:uint):*{
         var r:* = null;
         var n:String = p.toString();
         var v:* = storage[n];
         if((undefined != v) && (-1 != v)){
            // 删除键
            storage[n] = -1;
            // 删除内容
            var i:int = v;
            r = values[i];
            names.splice(i, 1);
            values.splice(i, 1);
            // 修正索引
            var c:int = names.length;
            for(var x:int = i; x < c; x++){
               storage[names[x]]--;
            }
         }
         return r;
      }
      
      //============================================================
      // <T>清空键与值。</T>
      //
      // return void
      //============================================================
      public function clear():void{
         // 清空对照表
         var c:int = names.length;
         for(var n:int = 0; n < c; n++){
            storage[names[n]] = -1;
         }
         // 清空内容
         names.length = 0;
         values.length = 0;
      }
      
      //============================================================
      // <T>销毁。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         var c:int = values.length;
         for(var n:int = 0; n < c; n++){
            values[n] = null;
         }
         values.length = 0;
         values = null;
      }
   }
}