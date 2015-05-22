package mo.cr.console.process
{
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>处理句柄集合。</T>
   //============================================================
   public class FCrProcessHandles extends FObject
   {
      // 处理句柄集合
      public var handles:Vector.<FCrProcessHandle> = new Vector.<FCrProcessHandle>();
      
      //============================================================
      // <T>构造处理句柄集合。</T>
      //============================================================
      public function FCrProcessHandles(){
      }
      
      //============================================================
      // <T>注册处理函数。</T>
      //
      // @param pc:callback 回调函数
      // @param po:owner 拥有者
      //============================================================
      public function register(pc:Function, po:Object = null):void{
         handles.push(new FCrProcessHandle(pc, po));
      }
      
      //============================================================
      // <T>执行处理函数。</T>
      //
      // @param p:event 事件
      //============================================================
      public function process(e:FCrProcessEvent):void{
         var c:int = handles.length;
         for(var n:int = 0; n < c; n++){
            handles[n].invoke(e);
         }
      }
   }
}