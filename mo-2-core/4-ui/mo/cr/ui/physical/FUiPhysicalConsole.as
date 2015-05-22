package mo.cr.ui.physical
{
   import mo.cm.core.common.FConsole;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.RCrConsole;
   import mo.cr.console.physical.move.FCrPhysicalMoveLinear;
   import mo.cr.ui.FUiControl3d;
   
   //============================================================
   // <T>样式控制台。</T>
   //============================================================
   public class FUiPhysicalConsole extends FConsole
   {
      //============================================================
      // <T>构造样式控制台。</T>
      //============================================================
      public function FUiPhysicalConsole(){
         name = "core.ui.physical.console";
      }
      
      //============================================================
      // <T>启动线性方式。</T>
      //
      // @param pc:control 控件
      // @param ps:speed 速度
      // @param pa:acceleration 加速度
      //============================================================
      public function startLiner(p:FUiControl3d, px:Number, py:Number, ps:Number = 1, pa:Number = 1):FUiLinerTracker{
         var t:FUiLinerTracker = new FUiLinerTracker();
         var i:FCrPhysicalMoveLinear = new FCrPhysicalMoveLinear();
         i.speed = ps;
         i.acceleration = pa;
         i.targetPosition.set(p.location.x, p.location.y);
         t.items.push(i);
         p.setLocation(px, py);
         t.linkDisplay(p.display);
         RCrConsole.physicalConsole.start(t);
         return t;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
      }
   }
}