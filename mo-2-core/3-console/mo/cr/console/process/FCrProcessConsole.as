package mo.cr.console.process
{
   import mo.cm.console.loader.FLoaderEvent;
   import mo.cm.core.common.FConsole;
   import mo.cm.lang.FLooper;
   
   //============================================================
   // <T>进程管理器。</T>
   //============================================================
   public class FCrProcessConsole extends FConsole
   {
      // 进程提供商
      public var vendor:FCrProcessVendor;
      
      // 事件处理器
      public var processor:FCrProcessProcessor
      
      // 进程集合
      public var processes:Vector.<FCrProcess> = new Vector.<FCrProcess>(); 
      
      // 输入事件集合
      public var inputEvents:FLooper = new FLooper(); 
      
      // 输出事件集合
      public var outputEvents:FLooper = new FLooper(); 
      
      //============================================================
      // <T>构造进程管理器。</T>
      //============================================================
      public function FCrProcessConsole(){
         name = "core.process.console";
      }
      
      //============================================================
      // <T>初始化信息。</T>
      //============================================================
      public function initialize():void{
      }
      
      //============================================================
      // <T>加入队列。</T>
      //============================================================
      public function push(p:FCrProcess):void{
      }
      
      //============================================================
      // <T>创建完成处理函数。</T>
      //
      // @param pu:url 网络地址
      // @param pc:count 总数
      //============================================================
      public function onCreateComplete(e:FLoaderEvent):void{
         var l:FProcessLoader = e.loader as FProcessLoader;
         // 创建进程集合
         var c:int = l.count;
         for(var n:int = 0; n < c; n++){
            // 创建新进程
            var p:FCrProcess = vendor.create(l.code, e.data);
            p.console = this;
            processes.push(p);
         }
         // 处理事件
         l.lsnsReady.process(null);
      }
      
      //============================================================
      // <T>创建处理函数。</T>
      //
      // @param pc:code 代码
      // @param pu:url 网络地址
      // @param pn:count 总数
      //============================================================
      public function createFromUrl(pc:String, pu:String, pn:int = 1):FProcessLoader{
         var l:FProcessLoader = new FProcessLoader();
         l.code = pc;
         l.count = pn;
         l.lsnsComplete.register(onCreateComplete, this);
         l.load(pu);
         return l;
      }
      
      //============================================================
      // <T>增加排序。</T>
      //
      // @param ps:event 事件
      // @param pt:event 事件
      // @return 排序大小
      //============================================================
      public function pushSort(ps:FCrProcess, pt:FCrProcess):int{
         var s:int = ps.sendCount - ps.receiveCount;
         var t:int = pt.sendCount - pt.receiveCount;
         return s - t;
      }
      
      //============================================================
      // <T>增加事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function pushEvent(e:FCrProcessEvent):void{
         inputEvents.push(e);
      }
      
      //============================================================
      // <T>处理事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function processEvent(e:FCrProcessEvent):void{
      }
      
      //============================================================
      // <T>查找一个事件。</T>
      //
      // @param p:groupName 组名称
      // @return 事件
      //============================================================
      public function findEvent(p:String):FCrProcessEvent{
         var c:int = inputEvents.count;
         for(var n:int = 0; n < c; n++){
            var e:FCrProcessEvent = inputEvents.next();
            if(e.group == p){
               return inputEvents.remove();
            }
         }
         return null;
      }
      
      //============================================================
      // <T>处理事件。</T>
      //============================================================
      public function process():void{
         // 线程排序（根据发送和收到个数只差排序）
         if(inputEvents.count){
            processes.sort(pushSort);
         }
         //............................................................
         // 放入进程
         var c:int = processes.length;
         for(var n:int = 0; n < c; n++){
            var p:FCrProcess = processes[n];
            // 进程处理
            p.process();
            // 处理事件队列
            if(p.ready){
               var e:FCrProcessEvent = findEvent(p.code);
               if(e){
                  p.send(e);
               }
            }
         }
      }
   }
}