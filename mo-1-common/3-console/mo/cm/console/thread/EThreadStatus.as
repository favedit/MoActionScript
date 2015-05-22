package mo.cm.console.thread
{
   //============================================================
   // <T>线程处理状态。</T>
   //============================================================
   public class EThreadStatus
   {
      // 执行状态定义：停止
      public static const Stop:int = 0;
      
      // 执行状态定义：运行
      public static const Processing:int = 1;

      // 执行状态定义：空闲
      public static const Idle:int = 2;
   }
}