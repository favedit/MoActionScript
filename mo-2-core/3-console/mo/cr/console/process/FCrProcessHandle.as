package mo.cr.console.process
{
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>处理句柄。</T>
   //============================================================
   public class FCrProcessHandle extends FObject
   {
      // 函数
      public var callback:Function;
      
      // 拥有者
      public var owner:Object;
      
      //============================================================
      // <T>构造处理句柄。</T>
      //
      // @param pc:callback 回调函数
      // @param po:owner 拥有者
      //============================================================
      public function FCrProcessHandle(pc:Function, po:Object = null){
         callback = pc;
         owner = po;
      }
      
      //============================================================
      // <T>调用事件。</T>
      //============================================================
      public function invoke(e:FCrProcessEvent):void{
         if(owner){
            callback.call(owner, e);
         }else{
            callback(e);
         }
      }
   }
}
