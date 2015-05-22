package mo.cm.lang
{
   import mo.cm.reflection.RType;
   import mo.cm.reflection.SClassInfo;
   
   //============================================================
   // <T>对象字典。</T>
   //============================================================
   public class FDictionary extends FAbsMap
   {
      // 存储内容集合
      public var values:Vector.<Object> = new Vector.<Object>(); 
      
      //============================================================
      // <T>创建对象字典。</T>
      //============================================================
      public function FDictionary(){
      }
      
      //============================================================
      // <T>判断是否包含指定的值。</T>
      //
      // @param p:value 内容
      // @return 是否包含
      //============================================================
      [Inline]
      public final function containsValue(p:Object):Boolean{
         var r:int = values.indexOf(p);
         return (-1 != r);
      }
      
      //============================================================
      // <T>获得指定值首次出现的位置。</T>
      //
      // @param p:value 内容
      // @return int 位置
      //============================================================
      [Inline]
      public final function indexOfValue(p:Object):int{
         return values.indexOf(p);
      }
      
      //============================================================
      // <T>判断两个dictionary是否相等。</T>
      //
      // @param p:dictionary 字典对象
      // @return 是否相等 
      //============================================================
      public function equals(p:FDictionary):Boolean{
         // 先判断数量是否相等
         var c:int = names.length;
         if(p.names.length != c){
            return false;
         }
         // 内容相等就是相等的，与顺序无关
         for(var n:int = 0; n < c; n++){
            var v:Object =  p.get(names[n]);
            if(values[n] != v){
               return false;
            }
         }
         return true;
      }
      
      //============================================================
      // <T>获得指定位置的值。</T>
      //
      // @param index 索引位置
      // @return Object 值对象 
      //============================================================
      [Inline]
      public final function value(p:int):*{
         return ((0 <= p) && (p < values.length)) ? values[p]: null;
      }
      
      //============================================================
      // <T>设置指定位置的值，如果索引位置错误，则不执行。</T>
      //
      // @param pi:index 索引位置
      // @param pv:value 内容
      //============================================================
      [Inline]
      public final function setValue(pi:int, pv:Object):void{
         if(pi >= 0 && pi < values.length){
            values[pi] = pv;
         }
      }
      
      //============================================================
      // <T>获取指定名称的值，不存在返回空。</T>
      //
      // @param p:name 名称
      // @param 内容
      //============================================================
      [Inline]
      public final function get(p:String):*{
         var r:String = storage[p];
         return (null != r) ? values[parseInt(r)] : null;
      }
      
      //============================================================
      // <T>设置指定名称的值，不存在则添加一条。</T>
      //
      // @param pn:name 名称
      // @param pv:value 内容
      //============================================================
      [Inline]
      public final function set(pn:String, pv:Object):void{
         var r:String = storage[pn];
         if(null != r){
            values[parseInt(r)] = pv;
         }else{
            storage[pn] = names.length;
            names.push(pn);
            values.push(pv);
         }
      }
      
      //============================================================
      // <T>清除指定位置的内容。</T>
      //
      //@param p:index 位置
      //============================================================
      public function erase(p:int):Object{
         var v:Object = null;
         var c:int = names.length;
         if((p >= 0) && (p < c)){
            var pn:String = names[p];
            v = values[p];
            delete storage[pn];
            names.splice(p, 1);
            values.splice(p, 1);
            // 设置对照顺序
            c--;
            for(var n:int = p; n < c; n++){
               storage[names[n]] = n;
            }
         }
         return v;
      }
      
      //============================================================
      // <T>清除指定位置的内容。</T>
      //
      //@param int index 位置
      //============================================================
      public function remove(p:String):Object{
         var r:String = storage[p];
         return (null != r) ? erase(parseInt(r)) : null;
      }
      
      //============================================================
      // <T>清除字典的内容。</T>
      //
      //============================================================
      public function clear():void{
         // 清空对照表
         var c:int = names.length;
         for(var n:int = 0; n < c; n++){
            storage[names[n]] = null;
            names[n] = null;
            values[n] = null;
         }
         // 清空名称和内容数组
         names.length = 0;
         values.length = 0;
      }
      
      //============================================================
      // <T>获得运行时信息。</T>
      //
      // @return 运行时信息
      //============================================================
      public function get runtime():String{
         var r:FString = new FString();
         var c:int = names.length;
         for(var n:int = 0; n < c; n++){
            if(n > 0){
               r.appendLine();
            }
            r.append(names[n] + " = [" + values[n] + "]");
         }
         return r.toString();
      }
      
      //============================================================
      // <T>释放资源。</T>
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