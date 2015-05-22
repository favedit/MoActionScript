package mo.cm.system
{
   import mo.cm.core.device.RFatal;
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FString;
   
   //============================================================
   // <T>收集管理器。</T>
   //============================================================
   public class RAllocator
   {
      // 哈希序列
      public static var code:int = 0;
      
      // 构造器缓冲池
      public static var pools:FDictionary = new FDictionary();
      
      //============================================================
      // <T>获得下个序列。</T>
      //
      // @return 下个序列
      //============================================================
      public static function nextCode():int{
         return ++code;
      }
      
      //============================================================
      // <T>注册一个类的创建函数。</T>
      // <P>如果请求创建来源类，则创建目标类。</P>
      //
      // @param ps:source 来源类
      // @param pt:target 目标类
      //============================================================
      public static function register(ps:Class, pt:Class):void{
         var n:String = ps + "";
         var r:FObjectPool = pools.get(n);
         if(!r){
            r = new FObjectPool(pt);
            pools.set(n, r);
         }
      }
      
      //============================================================
      // <T>创建一个实体类。</T>
      // <P>函数内创建使用。</P>
      //
      // @param p:class 类对象
      // @return 实例
      //============================================================
      public static function create(p:Class):*{
         var n:String = p + "";
         var op:FObjectPool = pools.get(n);
         if(null == op){
            op = new FObjectPool(p);
            pools.set(n, op);
         }
         return op.create(n);
      }
      
      //============================================================
      // <T>创建一个实体类。</T>
      // <P>函数内创建使用。</P>
      //
      // @param p:class 类对象
      // @return 实例
      //============================================================
      public static function alloc(p:Class):*{
         var n:String = p + "";
         var op:FObjectPool = pools.get(n);
         if(null == op){
            op = new FObjectPool(p);
            pools.set(n, op);
         }
         return op.alloc();
      }
      
      //============================================================
      // <T>释放一个实体类。</T>
      //
      // @param pc:class 类对象
      // @param pv:value 类对象
      //============================================================
      public static function erase(pc:Class, pv:Object):void{
         // 获得类名
         var n:String = pc + "";
         // 获得对象缓冲池
         var op:FObjectPool = pools.get(n);
         // 释放对象
         if(null == op){
            RFatal.throwFatal("Object allocator is not exists.");
         }else{
            op.erase(pv);
         }
      }
      
      //============================================================
      // <T>释放一个实体类。</T>
      //
      // @param pc:class 类对象
      // @param pv:value 类对象
      //============================================================
      public static function free(pc:Class, pv:Object):void{
         // 获得类名
         var n:String = pc + "";
         // 获得对象缓冲池
         var op:FObjectPool = pools.get(n);
         // 释放对象
         if(null == op){
            RFatal.throwFatal("Object allocator is not exists.");
         }else{
            op.free(pv);
         }
      }
      
      //============================================================
      // <T>释放一个实体类。</T>
      //
      // @param p:value 类对象
      //============================================================
      public static function release(p:Object):void{
         // 获得类名
         var n:String = p.constructor.toString();
         // 获得对象缓冲池
         var o:FObjectPool = pools.get(n);
         if(!o){
            RFatal.throwFatal("Object is not alloc by allocator.");
         }
         // 释放对象
         o.free(p);
      }
      
      //============================================================
      // <T>输出调试信息。</T>
      //============================================================
      public static function dump():void{
         var s:FString = new FString();
         var c:int = pools.count;
         for(var n:int = 0; n < c; n++){
            var p:FObjectPool = pools.values[n] as FObjectPool;
            s.append("Class=" + p.clazz);
            s.append(", reate=" + p.createCount);
            s.append(", alloc=" + p.allocCount);
            s.append(", erase=" + p.eraseCount);
            s.append(", free=" + p.freeCount);
            s.append(", buffer=" + p.frees.count);
            s.appendLine();
         }
         var r:String = s.toString();
         trace(r);
      }
   }  
}