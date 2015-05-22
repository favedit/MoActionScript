package mo.cr.physical
{
   import mo.cm.core.device.RTimer;
   import mo.cm.geom.SFloatPoint3;
   import mo.cm.geom.SFloatVector3;
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>三维跟踪对象。</T>
   //============================================================
   public class FCrTrack3 extends FObject
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
      public function FCrTrack3(){
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
            var d:Number = speedMovie * t;
            locationCurrent.x = locationSource.x + direction.x * d;
            locationCurrent.y = locationSource.y + direction.y * d;
            locationCurrent.z = locationSource.z + direction.z * d;
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