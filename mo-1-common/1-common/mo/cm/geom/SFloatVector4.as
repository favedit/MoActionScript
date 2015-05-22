package mo.cm.geom
{
   import mo.cm.lang.RFloat;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   public class SFloatVector4
   {
      public var x:Number;
      
      public var y:Number;
      
      public var z:Number;
      
      public var w:Number;
      
      //============================================================
      public function SFloatVector4(px:Number = 0, py:Number = 0, pz:Number = 0, pw:Number = 0){
         x = px;
         y = py;
         z = pz;
         w = pw;
      }
      
      //============================================================
      public function assign3(p:SFloatVector3):void{
         x = p.x;
         y = p.y;
         z = p.z;
      }
      
      //============================================================
      public function assign3Neg(p:SFloatVector3):void{
         x = -p.x;
         y = -p.y;
         z = -p.z;
      }
      
      //============================================================
      public function assign(p:SFloatVector4):void{
         x = p.x;
         y = p.y;
         z = p.z;
         w = p.w;
      }
      
      //============================================================
      public function setAll(pv:Number):void{
         x = pv;
         y = pv;
         z = pv;
         w = pv;
      }
      
      //============================================================
      public function set(px:Number = 0, py:Number = 0, pz:Number = 0, pw:Number = 0):void{
         x = px;
         y = py;
         z = pz;
         w = pw;
      }
      
      //============================================================
      public function transform3x3(matrix:SFloatMatrix):void{
      }
      
      //============================================================
      public function transform4x3(matrix:SFloatMatrix):void{
      }
      
      //============================================================
      public function transform4x4(matrix:SFloatMatrix):void{
         x = (x * matrix.data[0]) + (y * matrix.data[4]) + (z * matrix.data[ 8]) + matrix.data[12];
         y = (x * matrix.data[1]) + (y * matrix.data[5]) + (z * matrix.data[ 9]) + matrix.data[13];
         z = (x * matrix.data[2]) + (y * matrix.data[6]) + (z * matrix.data[10]) + matrix.data[14];
      }
      
      //============================================================
      public function normalize():void{
         var r:Number = Math.sqrt((x * x) + (y * y) + (z * z) + (w * w));
         x /= r;
         y /= r;
         z /= r;
         w /= r;
      }
      
      //============================================================
      public function format():String{
         return RFloat.format(x) + "," + RFloat.format(y) + "," + RFloat.format(z) + "," + RFloat.format(w); 
      }
      
      //============================================================
      // <T>加载设置信息</T>
      //
      // @param config 设置信息
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         x = config.getNumber("x");
         y = config.getNumber("y");
         z = config.getNumber("z");
         w = config.getNumber("w");
      }
      
      //============================================================
      // <T>存储设置信息</T>
      //
      // @param config 设置信息
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.setNumber("x", x);
         config.setNumber("y", y);
         config.setNumber("z", z);
         config.setNumber("w", w);
      }
   }
}