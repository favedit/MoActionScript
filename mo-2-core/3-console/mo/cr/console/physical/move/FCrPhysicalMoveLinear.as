package mo.cr.console.physical.move
{
   import mo.cm.core.device.RTimer;
   import mo.cm.geom.SFloatPoint3;
   import mo.cm.geom.SFloatVector3;
   import mo.cr.console.physical.FCrPhysicalItem;
   import mo.cr.console.physical.FCrPhysicalTracker;

   //============================================================
   // <T>物理动画线性运动。</T>
   //============================================================
   public class FCrPhysicalMoveLinear extends FCrPhysicalItem
   {
      // 速度
      public var speed:Number = 1;
      
      // 加速度
      public var acceleration:Number = 1;
      
      // 方向
      public var direction:SFloatVector3 = new SFloatVector3();
      
      // 源位置
      public var sourcePosition:SFloatPoint3 = new SFloatPoint3();
      
      // 目标位置
      public var targetPosition:SFloatPoint3 = new SFloatPoint3();

      //============================================================
      // <T>构造物理动画线性运动。</T>
      //============================================================
      public function FCrPhysicalMoveLinear(){
      }
   
      //============================================================
      // <T>更新处理。</T>
      //
      // @param p:track 跟踪器
      //============================================================
      public override function update(p:FCrPhysicalTracker):Boolean{
         var m:Number = RTimer.frameTick / 1000 * speed;
         speed *= acceleration;
         direction.assignDirection(p.position, targetPosition);
         var l:Number = direction.absolute();
         if(m >= l){
            // 直接到达目标点
            p.position.assign(targetPosition);
            return true;
         }else{
            // 计算移动
            direction.normalize();
            p.position.move(direction, m);
         }
         return false;
      }
   }
}