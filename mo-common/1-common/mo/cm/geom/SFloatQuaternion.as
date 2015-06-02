package mo.cm.geom
{
   //============================================================
   public class SFloatQuaternion
   {
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var w:Number;
      
      //============================================================
      public function SFloatQuaternion(px:Number = 0.0, py:Number = 0.0, pz:Number = 0.0, pw:Number = 0.0){
         x = px;
         y = py;
         z = pz;
         w = pw;
      }
      
      //============================================================
      public function setAll(pv:Number):void{
         x = pv;
         y = pv;
         z = pv;
         w = pv;
      }
      
      //============================================================
      public function set(px:Number = 0.0, py:Number = 0.0, pz:Number = 0.0, pw:Number = 0.0):void{
         x = px;
         y = py;
         z = pz;
         w = pw;
      }
      
      //============================================================
      public function get length() : Number{
         return Math.sqrt(w * w + x * x + y * y + z * z);
      }
      
      //============================================================
      public function normalize(pv:Number = 1.0):void{
         var r:Number = pv / Math.sqrt((x * x) + (y * y) + (z * z) + (w * w));
         x *= r;
         y *= r;
         z *= r;
         w *= r;
      }
      
      //============================================================
      public function fromAngles(ax:Number, ay:Number, az:Number):void{
         var sinPitch:Number = Math.sin(ax * 0.5);
         var cosPitch:Number = Math.cos(ax * 0.5);
         var sinYaw:Number = Math.sin(ay * 0.5);
         var cosYaw:Number = Math.cos(ay * 0.5);
         var sinRoll:Number = Math.sin(az * 0.5);
         var cosRoll:Number = Math.cos(az * 0.5);
         var cosPitchCosYaw:Number = cosPitch * cosYaw;
         var sinPitchSinYaw:Number = sinPitch * sinYaw;         
         x = sinRoll * cosPitchCosYaw    - cosRoll * sinPitchSinYaw;
         y = cosRoll * sinPitch * cosYaw + sinRoll * cosPitch * sinYaw;
         z = cosRoll * cosPitch * sinYaw - sinRoll * sinPitch * cosYaw;
         w = cosRoll * cosPitchCosYaw    + sinRoll * sinPitchSinYaw;
      }
      
      //============================================================
      public function toAngles(angle:SFloatVector3):void{
         angle.x = Math.atan2(((x * w) + (y * z)) * 2, 1 - 2 * ((x * x) + (y * y)));
         angle.y = Math.asin(((y * w) - (x * z)) * 2);
         angle.z = Math.atan2(((z * w) + (x * y)) * 2, 1 - 2 * ((y * y) + (z * z)));
      }
      
   }
}