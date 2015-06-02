package mo.cm.core.ui
{ 
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mo.cm.geom.SIntPadding;
   import mo.cm.geom.SIntSize2;
   import mo.cm.system.FFatalUnsupportError;
   
   //============================================================
   // <T>缩放九宫格图片。</T>
   //============================================================
   public class FScaleShape extends FShape
   {
      // 大小
      public var size:SIntSize2 = new SIntSize2();
      
      // 范围
      public var padding:SIntPadding = new SIntPadding();
      
      // 中间拉伸方式
      public var scaleCenter:String = EScale.Repeat;
      
      // 边缘拉伸方式
      public var scaleBorder:String = EScale.Stretch;
      
      // 图片数据
      public var bitmapData:BitmapData;
      
      // 图片边角数据
      public var bitmapConners:Vector.<BitmapData> = new Vector.<BitmapData>(9, true);
      
      //============================================================
      // <T>构造缩放九宫格图片。</T>
      //============================================================
      public function FScaleShape(){
      }
      
      //============================================================
      // <T>加载位图数据。</T>
      //
      // @param pd:bitmapData 位图数据
      // @param pl:left 左边距
      // @param pt:top 上边距
      // @param pr:right 右边距
      // @param pb:bottom 下边距
      //============================================================
      public function loadBitmap(pd:BitmapData, pl:int, pt:int, pr:int, pb:int):void{
         // 设置数据
         bitmapData = pd;
         padding.set(pl, pt, pr, pb);
         // 计算分割点
         var xs:Array = [0, pl, pd.width - pr, pd.width];
         var ys:Array = [0, pt, pd.height - pb, pd.height];
         // 分割图片
         clear();
         if(pd){
            for(var y:int = 0; y < 3; y++){
               for(var x:int = 0; x < 3; x++){
                  var dw:int = xs[x + 1] - xs[x];
                  var dh:int = ys[y + 1] - ys[y];
                  if((dw > 0) && (dh > 0)){
                     var n:int = 3 * y + x;
                     var dx:int = xs[x];
                     var dy:int = ys[y];
                     var d:BitmapData = new BitmapData(dw, dh, true, 0);
                     d.copyPixels(bitmapData, new Rectangle(dx, dy, dw, dh), new Point(0, 0));  
                     bitmapConners[n] = d;
                  }
               }
            }
         }
      }
      
      //============================================================
      // <T>绘制缩放处理。</T>
      //
      // @param pd:bitmapData 位图数据
      // @param px:x 左位置
      // @param py:y 上位置
      // @param pw:width 宽度
      // @param ph:height 高度
      // @param ps:scale 缩放方式
      //============================================================
      protected function drawScale(pd:BitmapData, px:int, py:int, pw:int, ph:int, ps:String):void{
         if(ps == EScale.None){
            graphics.beginBitmapFill(pd, new Matrix(1, 0, 0, 1, px, py), false, false);
            graphics.drawRect(px, py, pw, ph);
            graphics.endFill();
         }else if(ps == EScale.Repeat){
            graphics.beginBitmapFill(pd, new Matrix(1, 0, 0, 1, px, py), true, false);
            graphics.drawRect(px, py, pw, ph);
            graphics.endFill();
         }else if(ps == EScale.Stretch){
            graphics.beginBitmapFill(pd, new Matrix(pw / pd.width, 0, 0, ph / pd.height, px, py), false, true);
            graphics.drawRect(px, py, pw, ph);
            graphics.endFill();
         }else{
            throw new FFatalUnsupportError();
         }
      }
      
      //============================================================
      // <T>绘制处理。</T>
      //============================================================
      public function draw():void{
         // 清空画板
         graphics.clear();
         // 绘制图像
         if(bitmapData){
            // 计算分割点
            var xs:Array = [0, padding.left, size.width - padding.right, size.width];
            var ys:Array = [0, padding.top, size.height - padding.bottom, size.height];
            // 绘制分割
            for(var y:int = 0; y < 3; y++){
               for(var x:int = 0; x < 3; x++){
                  var dw:int = xs[x + 1] - xs[x];
                  var dh:int = ys[y + 1] - ys[y];
                  if((dw > 0) && (dh > 0)){
                     var n:int = 3 * y + x;
                     var d:BitmapData = bitmapConners[n];
                     if(d){
                        var dx:int = xs[x];
                        var dy:int = ys[y];
                        if(n == 4){
                           drawScale(d, dx, dy, dw, dh, scaleCenter);
                        }else if((n == 1) || (n == 3) || (n == 5) || (n == 7)){
                           drawScale(d, dx, dy, dw, dh, scaleBorder);
                        }else{
                           drawScale(d, dx, dy, dw, dh, EScale.None);
                        }
                     }
                  }
               }
            }
         }
      }
      
      //============================================================
      // <T>改变大小处理。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      //============================================================
      public function resize(pw:Number, ph:Number):void{
         if(!size.equalsValue(pw, ph)){
            size.set(pw, ph);
            draw();
         }
      }
      
      //============================================================
      // <T>设置宽度。</T>
      //
      // @param p:width 宽度
      //============================================================
      public override function set width(p:Number):void{
         if(width != p){
            size.width = p;
            draw();
         }
      }
      
      //============================================================
      // <T>设置高度。</T>
      //
      // @param p:height 高度
      //============================================================
      public override function set height(p:Number):void{
         if(height != p){
            size.height = p;
            draw();
         }
      }
      
      //============================================================
      // <T>清空资源。</T>
      //============================================================
      public function clear():void{
         var c:int = bitmapConners.length;
         for(var n:int = 0; n < c; n++){
            var d:BitmapData = bitmapConners[n];
            if(d){
               d.dispose();
               d = null;
               bitmapConners[n] = null;
            }
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         clear();
         size = null;
         padding = null;
         bitmapData = null;
         bitmapConners = null;
         graphics.clear();
         super.dispose();
      }
   }
}