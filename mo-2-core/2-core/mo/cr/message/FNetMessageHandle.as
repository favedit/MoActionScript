package mo.cr.message
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>网络消息处理句柄。</T>
   //============================================================
   public class FNetMessageHandle extends FObject
   {
      // 调用函数
      public var method:Function;
      
      // 拥有者
      public var owner:Object;

      // 命令
      public var command:int;

      //============================================================
      // <T>构造网络消息处理句柄。</T>
      //
      // @param pm:method 函数
      // @param po:owner 拥有者
      // @param pc:command 命令
      //============================================================
      public function FNetMessageHandle(pm:Function, po:Object = null, pc:int = -1){
         method = pm;
         owner = po;
         command = pc;
      }

      //============================================================
      // <T>调用消息。</T>
      //
      // @param p:message 消息
      //============================================================
      public function invoke(p:FNetMessage):Boolean{
         if(command >= 0){
            if(command != p.head.command){
               return false;
            }
         }
         if(owner){
            method.call(owner, p);
         }else{
            method(p);
         }
         return true;
      }
   }
}