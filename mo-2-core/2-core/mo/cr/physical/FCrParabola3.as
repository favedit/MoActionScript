package mo.cr.physical
{
   import mo.cm.core.device.RTimer;
   import mo.cm.geom.SFloatPoint3;
   import mo.cm.geom.SFloatVector3;
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>三维抛物线轨迹函数。</T>
   //============================================================
   public class FCrParabola3 extends FObject
   {
      // 时刻
      public var tick:Number = 0;
      
      // 是否停止
      public var stop:Boolean = false;

      // 距离
      public var distance:Number = 0;

      // [IN] 移动速度
      public var speedMovie:Number = 1.0;
      
      // 移动时刻
      public var speedTick:Number = 0;
      
      // 向上速度
      public var speedUp:Number = 1.0;

      // [IN] 重力
      public var gravity:Number = 9.80665;
      
      // 方向
      public var direction:SFloatVector3 = new SFloatVector3(); 

      // [IN] 开始位置
      public var locationSource:SFloatPoint3 = new SFloatPoint3(); 
      
      // [IN] 目标位置
      public var locationTarget:SFloatPoint3 = new SFloatPoint3(); 
      
      // [OUT] 当前位置
      public var locationCurrent:SFloatPoint3 = new SFloatPoint3(); 
      
      //============================================================
      // <T>构造函数。</T>
      //============================================================
      public function FCrParabola3(){
      }
      
      //============================================================
      // <T>开始。</T>
      //============================================================
      public function begin():void{
         tick = RTimer.currentTick;
         distance = locationSource.distance(locationTarget);
         direction.x = locationTarget.x - locationSource.x;
         direction.y = locationTarget.y - locationSource.y;
         direction.z = locationTarget.z - locationSource.z;
         direction.normalize();
         speedTick = distance / speedMovie * 1000;
         speedUp = gravity * (speedTick / 2000);
         stop = false;
      }
      
      //============================================================
      // <T>根据时间计算当前位置。</T>
      //============================================================
      public function calculate():void{
         var t:Number = (RTimer.currentTick - tick) / 1000;
         var cd:Number = speedMovie * t;
         if(cd > distance){
            // 到达目的地
            locationCurrent.assign(locationTarget);
            stop = true;
         }else{
            // 计算平面坐标
            var d:SFloatVector3 = new SFloatVector3();
            d.assign(direction);
            d.mul(speedMovie * t);
            locationCurrent.x = locationSource.x + d.x;
            locationCurrent.y = locationSource.y + d.y;
            locationCurrent.z = locationSource.z + d.z;
            // 计算高度
            var h:Number = locationCurrent.z + speedUp * t - gravity * t * t * 0.5;
            if(h <= locationTarget.z){
               h = locationTarget.z;
            }
            locationCurrent.z = h;
         }
      }

      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         direction = null;
         locationSource = null; 
         locationTarget = null; 
         locationCurrent = null; 
      }
   }
}