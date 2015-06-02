package mo.cm.core.ui
{
   import flash.display.Graphics;
   
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>图像绘制。</T>
   //============================================================
   public class FGraphics extends FObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FGraphics);
      
      // 图像绘制器
      public var graphics:Graphics;
      
      // 线宽度
      protected var _lineWidth:Number;
      
      // 线颜色
      protected var _lineColor:Number;
      
      // 填充颜色
      protected var _fillColor:uint;
      
      // 填充透明度
      protected var _fillAlpha:Number = 1;
      
      //============================================================
      // <T>构造图像绘制。</T>
      //============================================================
      public function FGraphics(g:Graphics) {
         graphics = g;
      }
      
      //============================================================
      // <T>设置线样式。</T>
      //
      // @param color 颜色
      // @param width 宽度
      //============================================================
      public function setLineStyle(color:uint = 0x000000, width:Number = 1):void {
         _lineColor = color;
         _lineWidth = width;
      }
      
      //============================================================
      // <T>设置填充样式。</T>
      //
      // @param color 颜色
      // @param alpha 透明
      //============================================================
      public function setFillStyle(color:uint = 0x000000, alpha:Number = 1):void {
         _fillColor = color;
         _fillAlpha = alpha;
      }
      
      //============================================================
      // <T>绘制一个圆形。</T>
      // 
      // @param x 横坐标
      // @param y 纵坐标
      // @param radius 半径
      //============================================================
      public function drawCircle(x:Number, y:Number, radius:Number):void {
         graphics.lineStyle(0, _lineColor);
         graphics.moveTo(x, y);
         graphics.drawCircle(x, y, radius)
      }
      
      //============================================================
      // <T>根据参数信息绘制一条弧线。</T>
      // 
      // @param x 中心点的横坐标
      // @param y 中心点的纵坐标
      // @param width 圆的横向宽度
      // @param height 圆的纵向高度
      // @param angleStart 开始角度
      // @param angleEnd 结束角度
      // @param order 绘制方向，默认为顺时针方向
      //    <L value='true'>顺时针方向</L>
      //    <L value='false'>逆时针方向</L>
      //============================================================
      public function drawEllipseArc(x:Number, y:Number, width:Number, height:Number, angleStart:Number, angleEnd:Number, order:Boolean = true):void{
         var step:Number = Math.PI / 180;
         var angle:Number;
         // 计算角度位置
         var start:Number = angleStart / 180 * Math.PI;
         var end:Number = angleEnd / 180 * Math.PI;
         while (start >= end){
            end += 2 * Math.PI;
         }
         // 根据方向绘制边线
         graphics.lineStyle(0, _lineColor);
         // 移动到开始点
         graphics.lineTo(Math.cos(start) * width + x, y - Math.sin(start) * height);
         if (order) {
            // 顺时针绘制边线
            for (angle = start; angle < end; angle += step ){
               graphics.lineTo(Math.cos(angle) * width + x, y - Math.sin(angle) * height);
            }
         }else if (order == 1) {
            // 逆时针绘制边线
            for (angle = end; angle > start; angle -= step ){
               graphics.lineTo(Math.cos(angle) * width + x, y - Math.sin(angle) * height);
            }
         }
         // 移动到结束点
         graphics.lineTo(Math.cos(end) * width + x, y - Math.sin(end) * height);
      }
      
      //============================================================
      // <T>绘制点绘线。</T>
      //
      // @param fromX 开始横坐标
      // @param fromY 开始纵坐标
      // @param toX 目标横坐标
      // @param toY 目标纵坐标
      // @param realviturl 数组
      //============================================================
      public function drawDottedLine(fromX:Number, fromY:Number, toX:Number, toY:Number, realviturl:Array):void{
         var x:Number = fromX; 
         var y:Number = fromY; 
         graphics.moveTo(fromX, fromY);
         var arraylength:int = realviturl.length;
         var curos:int=0;
         while(x < toX - 3) {
            if(curos >= arraylength) {
               curos = 0;
            }
            x = x + realviturl[curos] / (Math.sqrt((toY - fromY) * (toY - fromY) + (toX - fromX) * (toX - fromX))) * (toX - fromX); 
            y = y + realviturl[curos] / (Math.sqrt((toY - fromY) * (toY - fromY) + (toX - fromX) * (toX - fromX))) * (toY - fromY); 
            graphics.lineTo(x, y); 
            x = x + realviturl[curos + 1] / (Math.sqrt((toY - fromY) * (toY - fromY) + (toX - fromX) * (toX - fromX))) * (toX - fromX); 
            y = y + realviturl[curos + 1] / (Math.sqrt((toY - fromY) * (toY - fromY) + (toX - fromX) * (toX - fromX))) * (toY - fromY); 
            graphics.moveTo(x, y); 
            curos+=2;
         }
      }

      //============================================================
      // <T>填充一个矩形区域。</T>
      //
      // @param left 左坐标
      // @param top 顶坐标
      // @param right 右坐标
      // @param bottom 底坐标
      // @param color 填充颜色
      // @param alpha 填充透明度
      //============================================================
      public function fillRectangle(left:Number, top:Number, right:Number, bottom:Number, color:uint = 0xFFFFFF, alpha:Number = 1):void {
         graphics.beginFill(color, alpha);
         graphics.moveTo(left, top);
         graphics.lineTo(right, top);
         graphics.lineTo(right, bottom);
         graphics.lineTo(left, bottom);
         graphics.lineTo(left, top);
         graphics.endFill();
      }
      
      //============================================================
      // <T>填充一个圆形区域。</T>
      // 
      // @param x 横坐标
      // @param y 纵坐标
      // @param radius 半径
      //============================================================
      public function fillCircle(x:Number, y:Number, radius:Number):void {
         graphics.beginFill(_fillColor, _fillAlpha);
         drawCircle(x, y, radius);
         graphics.endFill();
      }
      
      //============================================================
      // <T>根据参数信息绘制一个扇形。</T>
      // 
      // @param x 中心点的横坐标
      // @param y 中心点的纵坐标
      // @param width 圆的横向宽度
      // @param height 圆的纵向高度
      // @param angleStart 开始角度
      // @param angleEnd 结束角度
      // @param order 绘制方向，默认为顺时针方向
      //    <L value='true'>顺时针方向</L>
      //    <L value='false'>逆时针方向</L>
      //============================================================
      public function drawSector(x:Number, y:Number, width:Number, height:Number, angleStart:Number, angleEnd:Number, order:Boolean = true):void{
         graphics.moveTo(x, y);
         drawEllipseArc(x, y, width, height, angleStart, angleEnd, order);
         graphics.lineTo(x, y);
      }
      
      //============================================================
      // <T>根据参数信息填充一个扇形。</T>
      // 
      // @param x 中心点的横坐标
      // @param y 中心点的纵坐标
      // @param width 圆的横向宽度
      // @param height 圆的纵向高度
      // @param angleStart 开始角度
      // @param angleEnd 结束角度
      // @param order 绘制方向，默认为顺时针方向
      //    <L value='true'>顺时针方向</L>
      //    <L value='false'>逆时针方向</L>
      //============================================================
      public function fillSector(x:Number, y:Number, width:Number, height:Number, angleStart:Number, angleEnd:Number, order:Boolean = true):void{
         graphics.beginFill(_fillColor, _fillAlpha);
         drawSector(x, y, width, height, angleStart, angleEnd, order);
         graphics.endFill();
      }
   }  
}