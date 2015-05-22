package mo.cr.message
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>网络消息处理句柄集合。</T>
   //============================================================
   public class FNetMessageHandles extends FObject
   {
      // 句柄集合
      public var handles:Vector.<FNetMessageHandle> = new Vector.<FNetMessageHandle>();
      
      //============================================================
      // <T>构造网络消息处理句柄集合。</T>
      //============================================================
      public function FNetMessageHandles(){
      }

      //============================================================
      // <T>注册函数调用。</T>
      //
      // @param pm:method 函数
      // @param po:owner 拥有者
      // @param pc:command 命令
      //============================================================
      public function register(pm:Function, po:Object=null, pc:int=-1):void{
         var h:FNetMessageHandle = new FNetMessageHandle(pm, po, pc);
         handles.push(h);
      }

      //============================================================
      // <T>执行消息事件。</T>
      //
      // @param p:message 消息
      //============================================================
      public function process(p:FNetMessage):void{
         var c:int = handles.length;
         for(var n:int = 0; n < c; n++){
            var h:FNetMessageHandle = handles[n];
            h.invoke(p);
         }
      }
   }
}