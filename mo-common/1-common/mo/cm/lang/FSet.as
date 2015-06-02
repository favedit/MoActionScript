package mo.cm.lang
{
   import mo.cm.reflection.RType;
   import mo.cm.reflection.SClassInfo;
   
   //============================================================
   // <T>集合。</T>
   //============================================================
   public class FSet extends FAbsIntSet
   {
      // 内容集合
      public var values:Vector.<Object> = new Vector.<Object>();
      
      //============================================================
      // <T>创建对象实例。</T>
      //============================================================
      public function FSet(){
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
      // <T>查找指定编号的内容。</T>
      //
      // @param p:int 编号
      // @return 内容
      //============================================================
      [Inline]
      public final function find(p:int):*{
         var v:* = storage[p];
         if(null != v){
            return values[v];
         }
         return null;
      }
      
      //============================================================
      // <T>获得指定编号的内容。</T>
      //
      // @param p:int 编号
      // @return 内容
      //============================================================
      [Inline]
      public final function get(p:int):*{
         var v:* = storage[p];
         if(null != v){
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
      [Inline]
      public final function set(pi:int, pv:*):void{
         var v:* = storage[pi];
         if(null != v){
            var i:int = v;
            values[i] = pv;
         }else{
            storage[pi] = values.length;
            names.push(pi);
            values.push(pv);
         }
      }
      
      //============================================================
      // <T>获得指定位置的内容。</T>
      //
      // @param p:int 索引位置
      // @return * 内容
      //============================================================
      [Inline]
      public final function value(p:int):*{
         return values[p];
      }
      
      //============================================================
      // <T>擦除指定ID的内容。</T>
      //
      // @param p:int ID
      // @return r:* 要擦除的内容
      //============================================================
      public function eraseId(p:int):*{
         var r:* = null;
         var v:* = storage[p];
         if(null != v){
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
      public function remove(p:int):*{
         var r:* = null;
         var n:String = p.toString();
         var v:* = storage[n];
         if(null != v){
            // 删除键
            delete storage[n];
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
            storage[names[n]] = null;
         }
         // 清空内容
         names.length = 0;
         values.length = 0;
      }
      
      //============================================================
      // <T>销毁。</T>
      //
      // return void
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
      
      //============================================================
      // <T>获得运行总大小。</T>
      //
      // @return 运行总大小
      //============================================================
      public override function runtimeCalculateTotal(p:SClassInfo):int{
         var r:int = super.runtimeCalculateTotal(p);
         var c:int = values.length;
         for(var n:int = 0; n < c; n++){
            var v:Object = values[n];
            if(v){
               if(-1 == p.instances.indexOf(v)){
                  p.instances.push(v);
                  r += RType.calculateTotal(v, p);
               }
            }
         }
         return r;
      }
   }
}