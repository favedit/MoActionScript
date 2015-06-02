package mo.cm.lang
{
   //============================================================
   // <T>属性列表。</T>
   //============================================================
   public class FAttributes extends FAbsMap
   {   
      // 内容数组
      public var values:Vector.<String> = new Vector.<String>(); 
      
      //============================================================
      // <T>创建实例对象。</T>
      //
      // @return 实例对象
      //============================================================
      public function FAttributes(){
      }
      
      //============================================================
      // <T>是否含有指定内容。</T>
      //
      // @param value 内容
      // @return 是否含有
      //============================================================
      public function containsValue(p:String):Boolean{
         return (-1 == values.indexOf(p));
      }
      
      //============================================================
      // <T>查找内容出现的索引位置。</T>
      //
      // @param value 内容
      // @param offset 查找位置
      // @return 索引位置
      //============================================================
      public function indexOfValue(pv:String, pi:int=0):int{
         return values.indexOf(pv, pi);
      }
      
      //============================================================
      // <T>和指定的属性列表是否相等。</T>
      //
      // @param attributes 属性列表
      // @return 是否相等
      //============================================================
      public function equals(p:FAttributes):Boolean{
         // 先判断数量是否相等
         var count:int = names.length;
         if(p.names.length != count){
            return false;
         }
         // 内容相等就是相等的，与顺序无关
         for(var n:int = 0; n < count; n++){
            var name:String = names[n];
            if(values[n] != p.get(name)){
               return false;
            }
         }
         return true;
      }
      
      //============================================================
      // <T>获得指定索引位置的内容。</T>
      //
      // @param p:index 索引位置
      // @return 内容
      //============================================================
      public function value(p:int):String{
         return (p >= 0 && p < values.length) ? values[p] : null;
      }
      
      //============================================================
      // <T>设定指定索引位置的内容。</T>
      //
      // @param index_ 索引位置
      // @param value_ 内容
      //============================================================
      public function setValue(pi:int, pv:String):void{
         if((pi >= 0) && (pi < values.length)){
            values[pi] = pv;
         }
      }
      
      //============================================================
      // <T>获得指定名称的内容。</T>
      //
      // @param p:name 名称
      // @return 内容
      //============================================================
      [Inline]
      public final function get(p:String):String{
         var i:String = storage[p];
         return (null != i) ? values[parseInt(i)] : null;
      }
      
      //============================================================
      // <T>设置指定名称的内容。</T>
      //
      // @param pn:name 名称
      // @param pv:value 内容
      //============================================================
      [Inline]
      public final function set(pn:String, pv:String):void{
         var i:String = storage[pn];
         if(null != i){
            values[parseInt(i)] = pv;
         }else{
            storage[pn] = names.length;
            names.push(pn);
            values.push(pv);
         }
      }
      
      //============================================================
      // <T>追加一个属性列表。</T>
      //
      // @param attributes 属性列表
      //============================================================
      public function append(attributes:FAttributes):void{
         var count:int = attributes.count;
         for(var n:int = 0; n < count; n++){
            set(attributes.names[n], attributes.values[n]);
         }
      }
      
      //============================================================
      // <T>擦除指定索引位置的内容。</T>
      //
      // @param index 索引位置
      // @return 索引位置的内容
      //============================================================
      public function erase(index:int):String{
         var value:String = null;
         var count:int = names.length;
         if(index >= 0 && index < count){
            var name:String = names[index];
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
      // <T>移除指定名称的内容。</T>
      //
      // @param name 名称
      //============================================================
      public function remove(name:String):String{
         var ptr:String = storage[name];
         return (null != ptr) ? erase(parseInt(ptr)) : null;
      }
      
      //============================================================
      // <T>清空属性列表。</T>
      //============================================================
      public function clear():void{
         // 清空对照表
         for(var name:Object in storage){
            storage[name] = null;
         }
         // 清空名称和内容数组
         names.splice(0, names.length);
         values.splice(0, values.length);
      }
      
      //============================================================
      // <T>按指定格式打包字符串。</T>
      //
      // @return 打包字符串
      //============================================================
      public function pack():String{
         var pack:FString = new FString();
         var count:int = names.length;
         for(var n:int = 0; n<count; n++){
            // 每一项按“长度的长度+长度+值”的格式打包
            var nl:int = names[n].length;
            pack.append(nl.toString().length + nl + names[n]);
            // 如果值为空，则为0
            if(null != values[n]){
               var vl:int = values[n].length;
               pack.append(vl.toString().length + vl + values[n]);
            }else{
               pack.append('0');
            }
         }
         return null;
      }
      
      //============================================================
      // <T>解压打包字符串。</T>
      //
      // @params pack:String 打包字符串
      // @return 处理结果
      //============================================================
      public function unpack(pack:String):Boolean{
         if(null != pack && pack.length){
            var n:String = null;
            var v:String = null;
            var f:int = 0;
            // 清空当前对象？
            clear();
            var pl:int = pack.length;
            while(f < pl){
               // 解析名称
               var ll:int = parseInt(pack.substr(f++, 1));
               var l:int = parseInt(pack.substr(f, ll));
               n = pack.substr(f + ll, l);
               f += ll + l;
               // 解析内容
               ll = parseInt(pack.substr(f++, 1));
               if(0 == ll){
                  v = null;
               }else{
                  l = parseInt(pack.substr(f, ll));
                  v = pack.substr(f + ll, l);
                  f += ll + l;
               }
               // 设置分解后的内容
               set(n, v);
            }
            return true;
         }
         return false;
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
      // <T>释放。</T>
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