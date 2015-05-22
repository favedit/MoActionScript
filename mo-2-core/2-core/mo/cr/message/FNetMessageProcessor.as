package mo.cr.message
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.FSet;
   
   //============================================================
   // <T>消息处理器。</T>
   //============================================================
   public class FNetMessageProcessor extends FObject
   {
      // 句柄集合
      protected var _handlesSet:FSet = new FSet();
      
      // 消息统计机
      protected var _statisticsMachine:FNetMessageStatisticsMachine = new FNetMessageStatisticsMachine();
      
      //============================================================
      // <T>构造消息处理器。</T>
      //============================================================
      public function FNetMessageProcessor(){
      }
      
      //============================================================
      public function get handlesSet():FSet{
         return _handlesSet;
      }
      
      //============================================================
      public function get statisticsMachine():FNetMessageStatisticsMachine{
         return _statisticsMachine;
      }
      
      //============================================================
      public function syncCode(code:int):FNetMessageHandles{
         var handles:FNetMessageHandles = _handlesSet.get(code) as FNetMessageHandles;
         if(null == handles){
            handles = new FNetMessageHandles();
            _handlesSet.set(code, handles);
         }
         return handles;
      }
      
      //============================================================
      public function register(code:int, method:Function, owner:Object=null):void{
         var handles:FNetMessageHandles = syncCode(code);
         handles.register(method, owner);
      }
      
      //============================================================
      public function process(message:FNetMessage):void{
         var code:int = message.head.code;
         var handles:FNetMessageHandles = _handlesSet.get(code) as FNetMessageHandles;
         //         var statistics:SNetMessageStatistics = _statisticsMachine.get(code);
         if(null != handles){
            //            statistics.begin();
            handles.process(message);
            //            statistics.end();
         }
      }
   }
}