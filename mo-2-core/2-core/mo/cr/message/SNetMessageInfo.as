package mo.cr.message
{
   import mo.cm.lang.RInteger;
   
   //============================================================
   // <T>消息信息。</T>
   //============================================================
   public class SNetMessageInfo
   {
      // 接收总数
      public var receiveTotal:int = 0;
      
      // 接收原始总数
      public var receiveOriginTotal:int = 0;

      // 接收次数
      public var receiveCount:int = 0;
      
      // 发送总数
      public var sendTotal:int = 0;
      
      // 发送原始总数
      public var sendOriginTotal:int = 0;

      // 发送次数
      public var sendCount:int = 0;
      
      //============================================================
      // <T>构造消息信息。</T>
      //============================================================
      public function SNetMessageInfo(){
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串 
      //============================================================
      public function toString():String{
         return "RT:" + RInteger.formatMemory(receiveTotal) + "/" +  RInteger.formatMemory(receiveOriginTotal) + " RC:" + receiveCount +
            " ST:" + RInteger.formatMemory(sendTotal) + "/" + RInteger.formatMemory(sendOriginTotal) +" SC:" + sendCount;
      } 
   }
}