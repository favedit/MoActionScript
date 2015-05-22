package mo.cr.console.physical
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.xml.FXmlNode;

   //============================================================
   // <T>物理控制台。</T>
   //============================================================
   public class FCrPhysicalConsole extends FConsole
   {
      // 跟踪器集合
      public var trackerFinish:Vector.<FCrPhysicalTracker> = new Vector.<FCrPhysicalTracker>();

      // 跟踪器集合
      public var trackers:Vector.<FCrPhysicalTracker> = new Vector.<FCrPhysicalTracker>();
      
      // 处理线程
      public var thread:FCrPhysicalThread = new FCrPhysicalThread();
      
      //============================================================
      // <T>构造效果控制台。</T>
      //============================================================
      public function FCrPhysicalConsole(){
         name = "core.physical.console"
      }

      //============================================================
      // <T>开始跟踪器。</T>
      //============================================================
      public function start(p:FCrPhysicalTracker):void{
         thread.push(p);
      }
   
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 启动资源线程
         RCmConsole.threadConsole.start(thread);
      }
      
      //============================================================
      // <T>处理过程。</T>
      //============================================================
      public function process():void{
         // 处理所有跟踪器
         trackerFinish.length = 0;
         var c:int = trackers.length;
         for(var n:int = 0; n < c; n++){
            var t:FCrPhysicalTracker = trackers[n];
            if(t.process()){
               trackerFinish.push(t);
            }
         }
         // 删除过期的跟踪器
         c = trackerFinish.length;
         for(n = 0; n < c; n++){
            t = trackerFinish[n];
            trackers.splice(trackers.indexOf(t), 1);
         }
      }
   }
}