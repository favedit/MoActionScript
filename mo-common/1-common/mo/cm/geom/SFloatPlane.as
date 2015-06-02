package mo.cm.geom
{
   //============================================================
   //<T>浮点数平面。</T>
   //============================================================
   public class SFloatPlane
   {
		// 浮点类型a
      public var a:Number;
      
		// 浮点类型b
      public var b:Number;
      
		// 浮点类型c
      public var c:Number;
      
		// 浮点类型d
      public var d:Number;
      
      //============================================================
      //<T>构造浮点数平面。</T>
      //============================================================
      public function SFloatPlane(){
      }
      
      //============================================================
      //<T>单位标准化处理。</T>
		//
		// @return void
		// @Date 20111230 YUFAL 标注
      //============================================================
      public function normalize():void{
         var r:Number = 1 / Math.sqrt((a * a) + (b * b) + (c * c));
         a *= r;
         b *= r;
         c *= r;
         d *= r;
      }
      
      //============================================================
      //<T>点乘处理。</T>
		//
		// @params x Number
		// @params y Number
		// @params z Number
		// @return Number
		// @Date 20111230 YUFAL 标注
      //============================================================
      public function dot(x:Number, y:Number, z:Number):Number{
         return (x * a) + (y * b) + (z * c ) + d;
      }
      
      //============================================================
      //<T>获得信息字符串。</T>
		//
		// @return String
		// @Date 20111230 YUFAL 标注
      //============================================================
      public function toString():String{
         return "Plane[a=" + a + ",b=" + b + ",c=" + c + ",d=" + d + "]";
      }
   }
}