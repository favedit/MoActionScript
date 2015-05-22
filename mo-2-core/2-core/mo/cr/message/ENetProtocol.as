package mo.cr.message
{
   //============================================================
   // <T>网络协议定义。</T>
   //
   // @enum
   //============================================================
   public class ENetProtocol
   {
      // 未设置
      public static var Unknown:int = 0x00;
      
      // 数据消息
      public static var Data:int = 0x01;
      
      // 标准消息
      public static var Message:int = 0x03;
   }
}