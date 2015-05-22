package mo.cr.message
{
   import mo.cm.lang.FSet;
   import mo.cm.lang.FString;

   //============================================================
   public class FNetMessageStatisticsMachine
   {
      protected var _statisticsSet:FSet = new FSet();
      
      //============================================================
      public function FNetMessageStatisticsMachine(){
      }
      
      //============================================================
      public function get(p:int):SNetMessageStatistics{
         var statistics:SNetMessageStatistics = _statisticsSet.get(p);
         if(null == statistics){
            statistics = new SNetMessageStatistics(p);
            _statisticsSet.set(p, statistics);
         }
         return statistics;
      }
      
      //============================================================
      public function runtime():String{
         var r:FString = new FString();
         var c:int = _statisticsSet.count;
         for(var n:int = 0; n < c; n++){
            if(n > 0){
               r.appendLine();
            }
            var s:SNetMessageStatistics = _statisticsSet.value(n);
            r.append(s.format());
         }
         return r.toString();
      }
   }
}