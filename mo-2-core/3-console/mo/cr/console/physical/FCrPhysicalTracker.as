package mo.cr.console.physical
{
   import flash.display.DisplayObject;
   
   import mo.cm.geom.SFloatPoint3;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;

   //============================================================
   // <T>物理跟踪器。</T>
   //============================================================
   public class FCrPhysicalTracker extends FCrPhysical
   {
      // 日志
      private static var _logger:ILogger = RLogger.find(FCrPhysicalTracker);

      // 位置
      public var position:SFloatPoint3 = new SFloatPoint3();

      // 开始时刻
      public var startTick:Number;

      // 结束时刻
      public var endTick:Number;

      // 项目集合
      public var items:Vector.<FCrPhysicalItem> = new Vector.<FCrPhysicalItem>();

      // 显示对象
      public var display:DisplayObject;

      //============================================================
      // <T>构造物理跟踪器。</T>
      //============================================================
      public function FCrPhysicalTracker(){
      }

      //============================================================
      // <T>增加新项目。</T>
      //============================================================
      public function push(p:FCrPhysicalItem):void{
         items.push(p);
      }

      //============================================================
      // <T>增加新项目。</T>
      //============================================================
      public function linkDisplay(p:DisplayObject):void{
         position.x = p.x;
         position.y = p.y;
         display = p;
      }

      //============================================================
      // <T>更新处理。</T>
      //============================================================
      public function update():void{
         display.x = position.x;
         display.y = position.y;
      }

      //============================================================
      // <T>处理过程。</T>
      //============================================================
      public function process():Boolean{
         var r:Boolean = true;
         var c:int = items.length;
         for(var n:int = 0; n < c; n++){
            if(!items[n].update(this)){
               r = false;
            }
         }
         update();
         //_logger.debug("process", "process");
         return r;
      }
   }
}