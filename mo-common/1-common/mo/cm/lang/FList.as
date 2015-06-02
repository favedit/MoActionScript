package mo.cm.lang
{
   //============================================================
   // <T>链表。</T>
   //============================================================
   public class FList extends FObject
   {
      // 总数
      public var count:uint;
      
      // 首入口对象
      protected var _first:SListEntry;
      
      // 尾入口对象
      protected var _last:SListEntry;
      
      // 当前入口对象
      protected var _current:SListEntry;
      
      // 释放入口对象
      protected var _freeEntry:SListEntry;
      
      //============================================================
      // <T>构造链表。</T>
      //
      // @param p:pool 链表缓冲
      //============================================================
      public function FList(){
      }
      
      //============================================================
      // <T>收集一个新入口对象。</T>
      //
      // @return 入口对象
      //============================================================
      protected function innerAlloc():SListEntry{
         var e:SListEntry = _freeEntry;
         if(null == e){
            e = new SListEntry();
         }else{
            _freeEntry = e.next;
         }
         return e;
      }
      
      //============================================================
      // <T>释放一个入口对象。</T>
      //
      // @param p:entry 入口对象
      //============================================================
      protected function innerFree(p:SListEntry):void{
         p.next = _freeEntry;
         p.value = null;
         _freeEntry = p;
      }
      
      //============================================================
      // <T>释放一个入口对象链表。</T>
      //
      // @param pf:firstEntry 开始入口对象
      // @param pl:lastEntry 结束入口对象
      //============================================================
      protected function innerFrees(pf:SListEntry, pl:SListEntry):void{
         pl.next = _freeEntry;
         _freeEntry = pf;
      }
      
      //============================================================
      // <T>插入尾元素。</T>
      //
      // @params p:entry 入口对象
      //============================================================
      protected function innerPush(p:SListEntry):void{
         if(null != _last){
            _last.next = p;
         }else{
            _first = p;
         }
         p.prior = _last;
         p.next = null;
         _last = p;
         count++;
      }
      
      //============================================================
      // <T>移除列表中指定对象。</T>
      //
      // @params p:entry 入口对象
      //============================================================
      protected function innerRemove(p:SListEntry):void{
         var ep:SListEntry = p.prior;
         var en:SListEntry = p.next;
         if(null != ep){
            ep.next = en;
         }else{
            _first = en;
         }
         if(null != en){
            en.prior = ep;
         }else{
            _last = ep;
         }
         innerFree(p);
         count--;
      }
      
      //============================================================
      // <T>列表是否为空。</T>
      //
      // @return 是否为空
      //============================================================
      public function isEmpty():Boolean{
         return (0 == count);
      }
      
      //============================================================
      // <T>列表是否包含指定内容。</T>
      //
      // @param p:value 指定内容
      // @return 是否包含
      //============================================================
      public function contains(p:*):Boolean{
         if(count > 0){
            var e:SListEntry = _first;
            while(null != e){
               if(e.value == p){
                  return true;
               }
               e = e.next;
            }
         }
         return false;
      }
      
      //===========================================================
      // <T>获得第一个对象。</T>
      //
      // @return 对象
      //===========================================================
      public function first():*{
         if(null == _first){
            return null;
         }
         return _first.value;
      }
      
      //===========================================================
      // <T>获得最后一个对象。</T>
      //
      // @return 对象
      //===========================================================
      public function last():*{
         if(null == _last){
            return null;
         }
         return _last.value;
      }
      
      //===========================================================
      // <T>返回链表的当前位置元素的值。</T>
      //
      // @return 对象
      //===========================================================
      public function current():*{
         if(null == _current){
            return null;
         }
         return _current.value;
      }
      
      //===========================================================
      // <T>重置链表的起始位置。</T>
      //===========================================================
      public function reset():void{
         _current = null;
      }
      
      //===========================================================
      // <T>获得链表的下一个元素。</T>
      //
      // @return 是否含有下一个元素
      //===========================================================
      public function next():Boolean{
         if(null != _current){
            _current = _current.next;
         }else{
            _current = _first;
         }
         return (null != _current);
      }
      
      //============================================================
      // <T>获得指定值的索引位置。</T>
      //
      // @return p:value 对象
      // @return 索引位置
      //============================================================
      public function indexOf(p:Object):int{
         var r:int = 0;
         if(count > 0){
            var e:SListEntry = _first;
            while(null != e){
               if(e.value == p){
                  return r;
               }
               e = e.next;
               r++;
            }
         }
         return -1;
      }
      
      //============================================================
      // <T>在头部压入内容对象。</T>
      //
      // @return p:value 内容对象
      //============================================================
      public function unshift(p:*):void{
         if(null != p){
            var e:SListEntry = innerAlloc();
            if(null != _first){
               _first.prior = e;
            }else{
               _last = e;
            }
            e.prior = null;
            e.next = _first;
            e.value = p;
            _first = e;
            count++;
         }
      }
      
      //============================================================
      // <T>在头部弹出内容对象。</T>
      //
      // @return 内容对象
      //============================================================
      public function shift():*{
         var r:* = null;
         var e:SListEntry = _first;
         if(null != e){
            r = e.value;
            var n:SListEntry = e.next;
            if(null != n){
               n.prior = null;
            }else{
               _last = null;
            }
            _first = n;
            count--;
            // 回收对象
            innerFree(e);
         }
         return r;
      }
      
      //============================================================
      // <T>在尾部插入内容对象。</T>
      //
      // @params p:value 内容对象
      //============================================================
      public function push(p:*):void{
         if(null != p){
            var e:SListEntry = innerAlloc();
            e.value = p;
            innerPush(e);
         }
      }
      
      //============================================================
      // <T>在尾部插入多个内容对象。</T>
      //
      // @return p:values 多个内容对象
      //============================================================
      public function pushs(...p):void{
         var c:int = p.length;
         for(var n:int = 0; n < c; n++){
            push(p[n]);
         }
      }
      
      //============================================================
      // <T>弹出尾内容对象。</T>
      //
      // @return 内容对象
      //============================================================
      public function pop():Object{
         var r:* = null;
         var e:SListEntry = _last;
         if(null != e){
            r = e.value;
            var p:SListEntry = e.prior;
            if(null != p){
               p.next = null;
            }else{
               _first = null;
            }
            _last = p;
            count--;
            // 回收对象
            innerFree(e);
         }
         return r;
      }
      
      //============================================================
      // <T>追加一个对象链表。</T>
      //
      // @params p:list 对象链表
      //============================================================
      public function append(p:FList):void{
         if(null != p){
            if(p.count > 0){
               var e:SListEntry = p._first;
               while(null != e){
                  push(e.value);
                  e = e.next;
               }
            }
         }
      }
      
      //============================================================
      // <T>清空指定索引位置的内容对象。</T>
      //
      // @params p:index 索引位置
      //============================================================
      public function erase(p:int):*{
         var i:int = 0;
         var r:* = null;
         if((p > 0) && (p < count)){
            var e:SListEntry = _first;
            while(null != e){
               if(p == i){
                  r = e.value;
                  e.value = p;
                  break;
               }
               e = e.next;
               i++;
            }
         }
         return r;
      }
      
      //===========================================================
      // <T>删除当前活动的元素。</T>
      //===========================================================
      public function removeCurrent():void{
         if(null != _current){
            var n:SListEntry = _current.next;
            innerRemove(_current);
            _current = n;
         }
      }
      
      //============================================================
      // <T>移除链表中的所有内容对象。</T>
      //
      // @params p:value 内容对象
      //============================================================
      public function remove(p:*):void{
         var e:SListEntry = _first;
         while(null != e){
            var n:SListEntry = e.next;
            if(e.value == p){
               innerRemove(e);
            }
            e = n;
         }
      }
      
      //============================================================
      // <T>清除所有内容对象。</T>
      //============================================================
      public function clear():void{
         if(count > 0){
            innerFrees(_first, _last);
            count = 0;
            _first = null;
            _last = null;
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         // 清空处理
         clear();
         // 释放所有入口对象
         var e:SListEntry = _freeEntry;
         while(null != e){
            var n:SListEntry = e.next;
            e.prior = null;
            e.next = null;
            e.value = null;
            e = n;
         }
         _freeEntry = null;
      }
   }
}