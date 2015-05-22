package mo.cr.message
{
   //============================================================
   // <T>网络消息处理器。</T>
   //============================================================
   public interface INetMessageProvider
   {
      // 根据代码获得消息
      function message(code:int):FNetMessage;
   }
}