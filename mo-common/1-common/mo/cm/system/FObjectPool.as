package mo.cm.system
{
   import mo.cm.lang.FList;
   import mo.cm.lang.FObject;
   import mo.cm.lang.IAllocator;
   
   //============================================================
   // <T>对象缓冲池。</T>
   //============================================================
   public class FObjectPool extends FObject implements IAllocator
   {
      // 对象类
      public var clazz:Class;
      
      // 创建次数
      public var createCount:int;
      
      // 收集次数
      public var allocCount:int;
      
      // 释放次数
      public var freeCount:int;
      
      // 擦除次数
      public var eraseCount:int;
      
      // 收集对象池
      public var items:FList = new FList();
      
      // 自由对象池
      public var frees:FList = new FList();
      
      // 自由对象池
      protected var _lastCount:int;
      
      //============================================================
      // <T>构造对象缓冲池。</T>
      //
      // @param clazz 类对象
      //============================================================
      public function FObjectPool(p:Class = null){
         clazz = p;
      }
      
      //============================================================
      // <T>测试是否发生改变。</T>
      //
      // @return 是否发生改变
      //============================================================
      public function testChanged():Boolean{
         if(_lastCount == items.count){
            return false;
         }
         _lastCount = items.count;
         return true;
      }
      
      //============================================================
      // <T>获得类对象。</T>
      //
      // @return 类对象
      //============================================================
      public function get count():int{
         return items.count;
      }
      
      //============================================================
      // <T>创建一个对象。</T>
      //
      // @return 对象
      //============================================================
      public function create(p:String):*{
         var r:* = new clazz();
         r.construct();
         createCount++;
         return r;
      }
      
      //============================================================
      // <T>收集一个对象。</T>
      //
      // @return 对象
      //============================================================
      public function alloc():*{
         var r:* = null;
         if(frees.isEmpty()){
            r = create(null);
         }else{
            r = frees.pop() as clazz;
         }
         r.construct();
         allocCount++;
         return r;
      }
      
      //============================================================
      // <T>擦除一个对象。</T>
      //
      // @param p:object 对象
      //============================================================
      public function erase(p:*):void{
         // 卸载处理
         p.free();
         // 释放处理
         frees.push(p);
         eraseCount++;
      }
      
      //============================================================
      // <T>释放一个对象。</T>
      //
      // @param p:object 对象
      //============================================================
      public function free(p:*):void{
         // 释放对象
         if(!p.disposed){
            p.dispose();
         }
         freeCount++;
      }
      
      //============================================================
      // <T>处理过程。</T>
      //============================================================
      public function process():void{
         // 释放对象
         items.reset();
         while(items.next()){
            var v:FObject = items.current() as FObject;
            if((null != v) && v.disposed){
               items.removeCurrent();
            }
         }
      }
   }
}