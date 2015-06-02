package mo.cm.geom
{
   //============================================================
   // <T>空间体大小。</T>
   //============================================================
   public class SFloatVolume
   {
      // 最小X
      public var xMin:Number;
      
      // 最大X
      public var xMax:Number;
      
      // 最小Y
      public var yMin:Number;
      
      // 最大Y
      public var yMax:Number;
      
      // 最小Z
      public var zMin:Number;
      
      // 最大Z
      public var zMax:Number;
      
      // 长度X
      public var xLength:Number;

      // 长度Y
      public var yLength:Number;

      // 长度Z
      public var zLength:Number;

      // 空间长度
      public var length:Number;

      //============================================================
      // <T>构造空间体大小。</T>
      //============================================================
      public function SFloatVolume(){
      }
      
      //============================================================
      public function min():void{
         xMin =  Number.MAX_VALUE;
         xMax = -Number.MAX_VALUE;
         yMin =  Number.MAX_VALUE;
         yMax = -Number.MAX_VALUE;
         zMin =  Number.MAX_VALUE;
         zMax = -Number.MAX_VALUE;
      }

      //============================================================
      public function innerMin(p:SFloatVolume):void{
         xMin = (xMin > p.xMin) ? xMin : p.xMin;
         xMax = (xMax < p.xMax) ? xMax : p.xMax;
         yMin = (yMin > p.yMin) ? yMin : p.yMin;
         yMax = (yMax < p.yMax) ? yMax : p.yMax;
         zMin = (zMin > p.zMin) ? zMin : p.zMin;
         zMax = (zMax < p.zMax) ? zMax : p.zMax;
      }

      //============================================================
      public function innerMax(p:SFloatVolume):void{
         xMin = (xMin < p.xMin) ? xMin : p.xMin;
         xMax = (xMax > p.xMax) ? xMax : p.xMax;
         yMin = (yMin < p.yMin) ? yMin : p.yMin;
         yMax = (yMax > p.yMax) ? yMax : p.yMax;
         zMin = (zMin < p.zMin) ? zMin : p.zMin;
         zMax = (zMax > p.zMax) ? zMax : p.zMax;
      }
      
      //============================================================
      public function updateLength():void{
         // 计算长度
         xLength = xMax - xMin;
         yLength = yMax - yMin;
         zLength = zMax - zMin;
         // 计算长度
         length = Math.sqrt(xLength * xLength + yLength * yLength + zLength * zLength);
      }
   }
}