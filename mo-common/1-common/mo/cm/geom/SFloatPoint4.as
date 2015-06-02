package mo.cm.geom
{
   import mo.cm.lang.RFloat;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>四维浮点数。</T>
   //============================================================
   public class SFloatPoint4
   {
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var w:Number;
      
      //============================================================
      // <T>构造四维浮点数。</T>
      //============================================================
      public function SFloatPoint4(px:Number = 0.0, py:Number = 0.0, pz:Number = 0.0, pw:Number = 1.0){
         x = px;
         y = py;
         z = pz;
         w = pw;
      }
      
      //============================================================
      // <T>设置全部数据。</T>
      //============================================================
      public function setAll(pv:Number):void{
         x = pv;
         y = pv;
         z = pv;
         w = pv;
      }
      
      //============================================================
      // <T>设置数据。</T>
      //============================================================
      public function set(px:Number = 0.0, py:Number = 0.0, pz:Number = 0.0, pw:Number = 1.0):void{
         x = px;
         y = py;
         z = pz;
         w = pw;
      }
      
      //============================================================
      public function assign3(p:SFloatPoint3):void{
         x = p.x;
         y = p.y;
         z = p.z;
         w = 1.0;
      }

      //============================================================
      public function assign(p:SFloatPoint4):void{
         x = p.x;
         y = p.y;
         z = p.z;
         w = p.w;
      }
      
      //============================================================
      public function length():Number{
         return Math.sqrt((x * x) + (y * y) + (z * z) + (w * w));
      }

      //============================================================
      public function length2():Number{
         return (x * x) + (y * y) + (z * z) + (w * w);
      }

      //============================================================
      public function align():void{
         var r:Number = 1 / w;
         x *= r;
         y *= r;
         z *= r;
         w  = 1;
      }

      //============================================================
      public function mul(p:Number):void{
         x *= p;
         y *= p;
         z *= p;
         w *= p;
      }
      
      //============================================================
      public function twoSub(p1:SFloatPoint4, p2:SFloatPoint4):void{
         x = p1.x - p2.x;
         y = p1.y - p2.y;
         z = p1.z - p2.z;
         w = p1.w - p2.w;
      }

      //============================================================
      public function twoSub43(p1:SFloatPoint4, p2:SFloatPoint3):void{
         x = p1.x - p2.x;
         y = p1.y - p2.y;
         z = p1.z - p2.z;
         w = 1.0;
      }

      //============================================================
      public function transform3x3(matrix:SFloatMatrix):void{
      }
      
      //============================================================
      public function transform4x3(matrix:SFloatMatrix):void{
      }
      
      //============================================================
      public function transform4x4(m:SFloatMatrix):void{
         var tx:Number = (x * m.data[0]) + (y * m.data[4]) + (z * m.data[ 8]) + (w * m.data[12]);
         var ty:Number = (x * m.data[1]) + (y * m.data[5]) + (z * m.data[ 9]) + (w * m.data[13]);
         var tz:Number = (x * m.data[2]) + (y * m.data[6]) + (z * m.data[10]) + (w * m.data[14]);
         var tw:Number = (x * m.data[3]) + (y * m.data[7]) + (z * m.data[11]) + (w * m.data[15]);
         x = tx;
         y = ty;
         z = tz;
         w = tw;
      }
      
      //============================================================
      public function format():String{
         return RFloat.format(x) + "," + RFloat.format(y) + "," + RFloat.format(z) + "," + RFloat.format(w); 
      }
   
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         x = p.getNumber("x");
         y = p.getNumber("y");
         z = p.getNumber("z");
         w = p.getNumber("w");
      }

      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.setNumber("x", x);
         config.setNumber("y", y);
         config.setNumber("z", z);
         config.setNumber("w", w);
      }
   }
} 