package mo.cm.system
{   
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   
   //============================================================
   // <T>监听器。</T>
   //============================================================
   public class FListener extends FObject
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FListener);
      
      // 处理函数
      public var method:Function;
      
      // 拥有对象
      public var owner:Object;
      
      // 调用次数
      public var count:int;
      
      // 调用总数
      public var total:int;
      
      // 调用总数
      public var isValid:Boolean = true;

      //============================================================
      // <T>构造监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      //============================================================
      public function FListener(pm:Function = null, po:Object = null){
         method = pm;
         owner = po;
      }
      
      //============================================================
      // <T>构造资源。</T>
      //============================================================
      public override function construct():void{
         super.construct();
         count = 0;
         total = -1;
      }

      //============================================================
      // <T>执行处理。</T>
      //
      // @param p:event 事件对象
      //============================================================
      public function process(p:FEvent):*{
         // 执行计数
         if(total){
            count--;
         }
         // 执行函数
         if(owner){
            if(p){
               p.owner = owner;
            }
            return method.call(owner, p);
         }
         return method(p);
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         method = null;
         owner = null;
      }
   }
}