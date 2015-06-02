package mo.cm.lang
{
   import mo.cm.core.device.RFatal;
   
   //============================================================
   // <T>循环链表。</T>
   //============================================================
   public class FLooper extends FObject
   {
      // 链表元素的总个数
      public var count:int;
      
      // 当前元素
      public var entryCurrent:SListEntry; 
      
      // 移除后的元素
      public var entryUnused:SListEntry; 
      
      // 刻点个数
      public var recordCount:int = -1;
      
      //===========================================================
      // <T>构造循环链表。</T>
      //============================================================
      public function FLooper(){
      }
      
      //===========================================================
      // <T>插入当前列表</T>
      //
      // @params p:entry 值
      //===========================================================
      protected function innerPush(p:SListEntry):void{
         if(entryCurrent){
            var l:SListEntry = entryCurrent.prior;
            p.prior = l;
            p.next = entryCurrent;
            l.next = p;
            entryCurrent.prior = p;
         }else{
            p.prior = p;
            p.next = p;
            entryCurrent = p;
         }
      }
      
      //===========================================================
      // <T>当前链表是否为空</T>
      //
      // @return 当前链表是否为空
      //===========================================================
      public function isEmpty():Boolean{
         return (0 == count);
      }
      
      //============================================================
      // <T>判断是否包含指定名称的值。</T>
      //
      // @param p:name 名称
      // @return 是否包含
      //============================================================
      public function contains(p:*):Boolean{
         if(entryCurrent){
            var e:SListEntry = entryCurrent;
            for(var n:int = 0; n < count; n++){
               if(e.value == p){
                  return true;
               }
               e = e.next;
            }
         }
         return false;
      }
      
      //===========================================================
      // <T>返回链表的当前位置元素的值。</T>
      //
      // @return 当前元素所对应值
      //===========================================================
      public function current():*{
         return entryCurrent ? entryCurrent.value : null;
      }
      
      //===========================================================
      // <T>获得链表的下一个元素。</T>
      //
      // @return 下一个链表元素
      //===========================================================
      public function next():*{
         // 移动当前点
         if(entryCurrent){
            entryCurrent = entryCurrent.next;
         }
         // 检查刻录点（当只有一个元素时，刻录点无效）
         if(recordCount > 0){
            recordCount--;
         }else if(recordCount == 0){
            return null;
         }
         // 返回内容
         return entryCurrent ? entryCurrent.value : null;
      }
      
      //===========================================================
      // <T>对元素进行权重排序，将当前权重最高的元素设置为当前元素。</T>
      //
      // @param p:function 比较函数
      //===========================================================
      public function nextSort(p:Function):*{
         if(entryCurrent){
            var m:int = 0;
            var e:SListEntry = entryCurrent = entryCurrent.next;
            for(var n:int = count - 1; n >= 0; n--){
               var f:int = p(e.value);
               if(f > m){
                  entryCurrent = e;
                  m = f;
               }
               e = e.next;
            }
            return entryCurrent.value;
         }
         return null;
      }
      
      //===========================================================
      // <T>插入尾元素</T>
      //
      // @params p:value 值
      //===========================================================
      public function push(p:*):void{
         if(p){
            var e:SListEntry = entryUnused;
            if(e){
               entryUnused = entryUnused.next;
            }else{
               e = new SListEntry();
            }
            e.value = p;
            innerPush(e);
            count++;
         }
      }
      
      //===========================================================
      // <T>插入唯一元素</T>
      //
      // @params p:value 值
      //===========================================================
      public function pushUnique(p:*):void{
         if(p){
            if(contains(p)){
               RFatal.throwFatal("Value is already exists in looper.");
               return;
            }
            push(p);
         }
      }
      
      //===========================================================
      // <T>移除一个元素。</T>
      //
      // @param p:value要移除的元素
      //===========================================================
      public function erase(p:*):*{
         if(count > 0){
            if(entryCurrent.value == p){
               return remove();
            }
            var c:SListEntry = entryCurrent; 
            var e:SListEntry = entryCurrent.next;
            while(e != entryCurrent){
               if(e.value == p){
                  e.prior.next = e.next;
                  e.next.prior = e.prior;
                  count--;
                  entryCurrent = count ? e.next : null;
                  e.next = entryUnused;
                  entryUnused = e;
                  var v:* = e.value;
                  e.value = null;
                  // 将位置重置到原始位置
                  entryCurrent = c;
                  return v;
               }
               e = e.next;
            }
         }
         return null;
      }
      
      //===========================================================
      // <T>移除当前的元素，并返回该元素的值</T>
      //
      // @return 移除内容
      //===========================================================
      public function remove():*{
         var e:SListEntry = entryCurrent;
         if(e){
            e.prior.next = e.next;
            e.next.prior = e.prior;
            count--;
            entryCurrent = count ? e.next : null;
            e.next = entryUnused;
            entryUnused = e;
            var v:* = e.value;
            e.value = null;
            return v;
         }
         return null;
      }
      
      //===========================================================
      // <T>清除循环链表所有元素。</T>
      //===========================================================
      public function clear():void{
         if(entryCurrent){
            entryCurrent.prior.next = null;
            entryCurrent.prior = entryUnused;
            entryUnused = entryCurrent;
            entryCurrent = null;
         }
         count = 0;
      }
      
      //===========================================================
      // <T>记录当前刻录点。</T>
      //===========================================================
      public function record():void{
         recordCount = count;
      }
      
      //===========================================================
      // <T>消除当前刻录点。</T>
      //===========================================================
      public function unrecord():void{
         recordCount = -1;
      }
      
      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public override function get runtimeInfo():String{
         var s:FString = new FString();
         s.appendLine(super.runtimeInfo);
         s.appendLine("count=" + count);
         if(entryCurrent){
            var e:SListEntry = entryCurrent;
            for(var n:int = 0; n < count; n++){
               s.appendLine(RInteger.lpad(n, 4) + " - " + e.value);
               e = e.next;
            }
         }
         return s.toString();
      }
   }
}