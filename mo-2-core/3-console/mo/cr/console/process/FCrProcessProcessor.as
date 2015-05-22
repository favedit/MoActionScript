package mo.cr.console.process
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.FSet;
   
   //============================================================
   // <T>进程处理器。</T>
   //============================================================
   public class FCrProcessProcessor extends FObject
   {
      // 句柄集合列表
      public var handlesSet:FSet = new FSet();
      
      //============================================================
      // <T>构造进程处理器。</T>
      //============================================================
      public function FCrProcessProcessor(){
      }
      
      //============================================================
      // <T>注册处理函数。</T>
      //
      // @param pd:code 代码
      // @param pc:callback 回调函数
      // @param po:owner 拥有者
      //============================================================
      public function register(pd:int, pc:Function, po:Object = null):void{
         var hs:FCrProcessHandles = handlesSet.get(pd) as FCrProcessHandles;
         if(!hs){
            hs = new FCrProcessHandles();
            handlesSet.set(pd, hs);
         }
         hs.register(pc, po);
      }
      
      //============================================================
      // <T>执行处理函数。</T>
      //
      // @param p:event 事件
      //============================================================
      public function process(e:FCrProcessEvent):void{
         var hs:FCrProcessHandles = handlesSet.get(e.code) as FCrProcessHandles;
         if(null != hs){
            hs.process(e);
         }
      }
   }
}