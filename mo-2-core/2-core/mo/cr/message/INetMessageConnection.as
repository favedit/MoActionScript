package mo.cr.message
{
   //============================================================
   // <T>消息链接。</T>
   //============================================================
   public interface INetMessageConnection
   {
      //============================================================
      // <T>处理消息函数。</T>
      //============================================================
      function process():Boolean;
   }
}