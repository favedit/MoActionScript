package mo.cm.console.synchronizer
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.RVector;

   //============================================================
   // <T>同步分组。</T>
   //============================================================
   public class FSynchronizerGroup extends FObject
   {
      // 参数集合
      public var args:SSynchronizerArgs = new SSynchronizerArgs();

      // 同步器集合
      public var synchronizers:Vector.<ISynchronizer>;
      
      // 同步组集合
      public var groups:Vector.<FSynchronizerGroup>;

      //============================================================
      // <T>同步分组。</T>
      //============================================================
      public function FSynchronizerGroup(){
      }
      
      //============================================================
      // <T>测试同步器集合是否完毕。</T>
      //
      // @param p:args 参数集合
      // @return 是否完毕
      //============================================================
      protected function testSynchronizersReady(p:SSynchronizerArgs):Boolean{
         if(null != synchronizers){
            var c:int = synchronizers.length;
            for(var n:int = 0; n < c; n++){
               var s:ISynchronizer = synchronizers[n];
               if(null != s){
                  if(!s.synchronizerReady(p)){
                     return false;
                  }
               }
            }
         }
         return true;
      }

      //============================================================
      // <T>测试同步组集合是否完毕。</T>
      //
      // @param p:args 参数集合
      // @return 是否完毕
      //============================================================
      protected function testGroupsReady(p:SSynchronizerArgs):Boolean{
         if(null != groups){
            var c:int = groups.length;
            for(var n:int = 0; n < c; n++){
               var g:FSynchronizerGroup = groups[n];
               if(null != g){
                  if(!g.testSynchronizersReady(args)){
                     return false;
                  }
                  if(!g.testGroupsReady(args)){
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      //============================================================
      // <T>测试是否完毕。</T>
      //
      // @return 是否完毕
      //============================================================
      public function testReady():Boolean{
         var r:Boolean = testSynchronizersReady(args);
         if(r){
            r = testGroupsReady(args);
         }
         return r;
      }

      //============================================================
      // <T>计算同步器集合比率。</T>
      //
      // @param p:args 参数集合
      // @return 处理结果
      //============================================================
      protected function calculateSynchronizersRate(p:SSynchronizerArgs):Boolean{
         if(null != synchronizers){
            var c:int = synchronizers.length;
            for(var n:int = 0; n < c; n++){
               var s:ISynchronizer = synchronizers[n];
               if(null != s){
                  if(!s.synchronizerRate(p)){
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      //============================================================
      // <T>计算同步组集合比率。</T>
      //
      // @param p:args 参数集合
      // @return 处理结果
      //============================================================
      protected function calculateGroupsRate(p:SSynchronizerArgs):Boolean{
         if(null != groups){
            var c:int = groups.length;
            for(var n:int = 0; n < c; n++){
               var g:FSynchronizerGroup = groups[n];
               if(null != g){
                  if(!g.calculateSynchronizersRate(p)){
                     return false;
                  }
                  if(!g.calculateGroupsRate(p)){
                     return false;
                  }
               }
            }
         }
         return true;
      }
      
      //============================================================
      // <T>计算同步组集合比率。</T>
      //
      // @param p:args 参数集合
      // @return 处理结果
      //============================================================
      public function calculateRate():Boolean{
         // 重置数据
         args.reset();
         // 计算比率
         var r:Boolean = calculateSynchronizersRate(args);
         if(r){
            r = calculateGroupsRate(args);
         }
         return r;
      }

      //============================================================
      // <T>增加一个同步器。</T>
      //
      // @param p:synchronizer 同步器
      //============================================================
      public function pushSynchronizer(p:ISynchronizer):void{
         // 创建对象
         if(null == synchronizers){
            synchronizers = new Vector.<ISynchronizer>();
         }
         // 推入同步器
         if(-1 == synchronizers.indexOf(p)){
            synchronizers.push(p);
         }
      }
      
      //============================================================
      // <T>增加一个同步组。</T>
      //
      // @param p:group 同步组
      //============================================================
      public function pushGroup(p:FSynchronizerGroup):void{
         // 创建对象
         if(null == groups){
            groups = new Vector.<FSynchronizerGroup>();
         }
         // 推入同步器
         if(-1 == groups.indexOf(p)){
            groups.push(p);
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         synchronizers = RVector.clear(synchronizers);
         groups = RVector.clear(groups);
         super.dispose();
      }
   }
}