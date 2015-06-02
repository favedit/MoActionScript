package mo.cm.geom
{
   //============================================================
   // <T>数学函数处理</T>
   //============================================================
   public class RMath
   {
      // 2PI
      public static const PI2:Number = Math.PI * 2;

      // 由弧度计算出度
      public static const RadianRate:Number = 180 / Math.PI;
      
      // 计算弧度值
      public static const DegreeRate:Number = Math.PI / 180;
      
      //============================================================
      // <T>求空间2点距离</T>
      //============================================================
      public static function length3(x1:Number, y1:Number, z1:Number, x2:Number, y2:Number, z2:Number):Number{
         var cx:Number = x2 - x1;
         var cy:Number = y2 - y1;
         var cz:Number = z2 - z1;
         var r2:Number = (cx * cx) + (cy * cy) + (cz * cz);
         return Math.sqrt(r2);
      }
      
      //============================================================
      // <T>判断该数值是否为偶数</T>
      //============================================================
      public static function isEven(num:int):Boolean{
         return !(num & 1);
      }
      
      //============================================================
      // <T>构造4*4矩阵</T>
      //============================================================
      public static function textureSpaceMatrix(ox:Number, oy:Number, bs:Number):void{
         var m:Vector.<Number> = new Vector.<Number>(16, true);
         m.push(0.5,  0.0, 0.0, 0.0);
         m.push(0.0, -0.5, 0.0, 0.0);
         m.push(0.0,  0.0, 1.0, 0.0);
         m.push(ox,   oy,  bs,  1.0);
      }
      
      //============================================================
      // <T>更具当前比率换算出是否命中</T>
      //
      // @param rate 比率
      // @param max 最大值
      // @parma min 最小值
      //============================================================
      public static function random(rate:int, max:int = 100, min:int = 0):Boolean{
         var num:int = getRandom(max, min);
         var r:int = (max - min) * rate / 100;
         var bool:Boolean = num <= r ? true : false;
         return bool;
      }
      
      //============================================================
      // <T>随机获取一个值</T>
      //
      // @param max 最大值
      // @parma min 最小值
      //============================================================
      public static function getRandom(max:int = 100, min:int = 0):int{
         return Math.random() * (max - min + 1) + min;
      }
      
      //============================================================
      // <T>随机获取一个值</T>
      //
      // @param max 最大值
      // @parma min 最小值
      //============================================================
      public static function getRandomRate(max:Number = 100, min:int = 0):Number{
         return Math.random() * (max - min + 1) + min;
      }
      
      //============================================================
      // <T>已知3点构成一个平面和平面上一点的X坐标和Y坐标，求Z坐标<T/>
      //
      // @params a:SIntPoint3, b:SIntPoint3, c:SIntPoint3 已知3点坐标
      // @params d:SIntPoint2 已知平面上一点的x,y坐标
      // @return z坐标
      //============================================================
      public static function calculateHeight(a:SFloatPoint3, b:SFloatPoint3, c:SFloatPoint3, d:SFloatPoint3):Number{
         var f:Number = (b.y - a.y) * (c.z - a.z) - (c.y - a.y) * (b.z - a.z);
         var g:Number = (b.z - a.z) * (c.x - a.x) - (b.x - a.x) * (c.z - a.z);
         var h:Number = (b.x - a.x) * (c.y - a.y) - (c.x - a.x) * (b.y - a.y);
         return  (f * d.x - a.x + b.y - a.y)/(b.x * c.y - c.x * b.y) + a.z;
      }
   }
}