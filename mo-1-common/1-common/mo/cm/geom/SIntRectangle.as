package mo.cm.geom
{
   //============================================================
   // <T>整形矩阵。</T>
   //
   // @version 1.0.1
   //============================================================
   public class SIntRectangle
   {
      // 左位置
      public var left:int;
      
      // 上位置
      public var top:int;
      
      // 右位置
      public var right:int;
      
      // 下位置
      public var bottom:int;
      
      //============================================================
      // <T>构造整形矩阵。</T>
      //============================================================
      public function SIntRectangle(){
      }
      
      //============================================================
      // <T>获取矩阵的宽度</T>
      //
      //============================================================
      [Inline]
      public final function get width():int{
         return right - left + 1;
      }
      
      //============================================================
      // <T>矩阵的宽度</T>
      //
      //============================================================
      [Inline]
      public final function set width(width:int):void{
         right = left + width;
      }
      
      //============================================================
      // <T>获取矩阵的高度</T>
      //
      //============================================================
      [Inline]
      public final function get height():int{
         return bottom - top + 1;
      }
      
      //============================================================
      // <T>矩阵的高度</T>
      //
      //============================================================
      [Inline]
      public final function set height(height:int):void{
         bottom = top + height;
      }
      
      //============================================================
      // <T>矩阵的高度和宽度</T>
      //
      //============================================================
      [Inline]
      public final function set(left:int, top:int, right:int, bottom:int):void{
         left = left;
         top = top;
         right = right;
         bottom = bottom;
      }
      
      //============================================================
      // <T>判断是否包含指定范围。</T>
      //
      // @param p:size 范围
      // @return 是否包含
      //============================================================
      public function containsSize(p:SIntSize2):Boolean{
         if(left > 0){
            return false;
         }
         if(right < p.width){
            return false;
         }
         if(top > 0){
            return false;
         }
         if(bottom < p.height){
            return false;
         }
         return true;
      }
      
      //============================================================
      // <T>判断是否包含指定矩形。</T>
      //
      // @param p:rectangle 矩形
      // @return 是否包含
      //============================================================
      public function containsRectangle(p:SIntRectangle):Boolean{
         return false;
      }
      
      //============================================================
      // <T>设置矩阵的宽高最大值和最小值</T>
      //
      //============================================================
      public function testIn(point:SIntPoint2):Boolean{
         if(point.x < left + width && point.x > left &&  point.y < top + height && point.y > top){
            return true;
         }
         return false;
      }
      
      //============================================================
      // <T>设置矩阵的宽高最大值和最小值</T>
      //
      // @param p 
      //============================================================
      public function testOverlapRectangle(p:SIntRectangle):Boolean{
         var l:int = (p.left < left) ? p.left : left;
         var t:int = (p.top < top) ? p.top : top;
         var r:int = (p.right > right) ? p.right : right;
         var b:int = (p.bottom > bottom) ? p.bottom : bottom;
         var maxW:int = r - l;
         var maxH:int = b - t;
         if((width + p.width > maxW) && (height + p.height > maxH)){
            return true;
         }
         return false;
      }
      
      //============================================================
      // <T>设置椭圆宽高的最大值和最小值</T>
      //
      //============================================================
      public function testOverlapEllipse(ellipse:SIntRectangle):Boolean{
         var l:int = Math.min(ellipse.left, left);
         var t:int = Math.min(ellipse.top, top);
         var r:int = Math.max(ellipse.right, right);
         var b:int = Math.max(ellipse.bottom, bottom);
         var maxW:int = r - l;
         var maxH:int = b - t;
         if((width + ellipse.width > maxW) && (height + ellipse.height > maxH)){
            return true;
         }
         return false;
      }
      
      //============================================================
      // <T>矩阵的高度和宽度赋值</T>
      //
      //============================================================
      public function assign(value:SIntRectangle):void{
         left = value.left;
         top = value.top;
         right = value.right;
         bottom = value.bottom;
      }
      
      //============================================================
      // <T>构造宽高的toString方法</T>
      //
      //============================================================
      public function toString():String{
         return left + "," + top + ":" + right + "," + bottom; 
      }
   }
}