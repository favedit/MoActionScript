package mo.cr.message
{
   //============================================================
   // <T>消息类型定义。</T>
   //
   // @enum
   //============================================================
   public class ENetMessageType
   {
      // 请求
      public static var Request:int = 0x01;

      // 应答
      public static var Response:int = 0x02;
      
      // 通知
      public static var Notify:int = 0x03;
   }
}