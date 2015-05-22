package mo.cm.core.ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.IBitmapDrawable;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   
   //===========================================================
   // <T>画板。</T>
   //===========================================================
   public class FCanvas extends FObject
   {
      // 尺寸
      public var size:SIntSize2 = new SIntSize2();
      
      // 显示容器
      public var container:DisplayObjectContainer;

      // 图片
      public var bitmap:Bitmap;
      
      // 图片数据
      public var bitmapData:BitmapData;
      
      //===========================================================
      // <T>构造画板。</T>
      //===========================================================
      public function FCanvas(){
         bitmap = new Bitmap();
      }
      
      //============================================================
      // <T>设置坐标。</T>
      //
      // @param x 横坐标
      // @param y 纵坐标
      //============================================================
      public function setLocation(x:int, y:int):void{
         if(bitmap.x != x){
            bitmap.x = x;
         }
         if(bitmap.y != y){
            bitmap.y = y;
         }
      }
      
      //============================================================
      // <T>重建改变画板大小。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      //============================================================
      public function resize(pw:int, ph:int):void{
         if(((size.width != pw) || (size.height != ph)) && ((pw > 0) || (ph > 0))){
            // 断掉关联
            bitmap.bitmapData = null; 
            // 释放绘图数据
            if(bitmapData){
               bitmapData.dispose();
               bitmapData = null;
            }
            // 重建绘图数据
            bitmapData = new BitmapData(pw, ph, true, 0x00000000);
            bitmap.bitmapData = bitmapData; 
            size.set(pw, ph);
         }
      }
      
      //============================================================
      // <T>锁定图像。</T>
      //============================================================
      public function lock():void{
         if(null != bitmapData){
            bitmapData.lock();
         }
      }
      
      //============================================================
      // <T>解锁图像。</T>
      //============================================================
      public function unlock():void{
         if(null != bitmapData){
            bitmapData.unlock();
         }
      }
      
      //============================================================
      // <T>调整位图颜色值。</T>
      // <P>位图变色接口。</P>
      //
      // @params transform 变色参数
      //============================================================
      public function colorTransform(transform:ColorTransform):void{
         if(bitmap){
            bitmap.transform.colorTransform = transform;
         }
      }
      
      //============================================================
      // <T>调整位图颜色值。</T>
      // <P>据指定的阈值测试图像中的像素值，并将通过测试的像素设置为新的颜色值。</P>
      //
      // @return 更改像素的数目
      //============================================================
      public function threshold(srcRect:Rectangle, destPoint:Point, operation:String, threshold:uint, color:uint = 0, mask:uint = 0xFFFFFFFF, copySource:Boolean = false):uint{
         if(bitmapData){
            return bitmapData.threshold(bitmapData, srcRect, destPoint, operation, threshold, color, mask, copySource);
         }
         return 0;
      }
      
      
      //============================================================
      // <T>拷贝位图像素。</T>
      //
      // @param pd:bitmapData 位图数据
      // @param px:x 横坐标
      // @param py:y 纵坐标
      //============================================================
      [Inline]
      public final function copyPixels(pd:BitmapData, x:int, y:int):void{
         bitmapData.copyPixels(pd, pd.rect, new Point(x, y), null, null, true);
      }
      
      //============================================================
      // <T>拷贝位图指定区域像素。</T>
      //============================================================
      [Inline]
      public final function copyRectangle(date:BitmapData, x:int, y:int, width:int, height:int, px:int, py:int, mergeAlpha:Boolean = true):void{
         bitmapData.copyPixels(date, new Rectangle(x, y, width, height), new Point(px, py), null, null, mergeAlpha);
      }
      
      //============================================================
      // <T>绘制显示对象。</T>
      //============================================================
      [Inline]
      public final function draw(source:IBitmapDrawable, matrix:Matrix = null, sourceRect:Rectangle = null, colorTransform:ColorTransform = null, blendMode:String = null, smoothing:Boolean = false):void{
         if(colorTransform){
            bitmapData.colorTransform(bitmapData.rect, colorTransform);
         }
         bitmapData.draw(source, matrix, colorTransform, blendMode, sourceRect, smoothing);
      }
      
      //============================================================
      // <T>显示处理。</T>
      //============================================================
      public function show():void{
         bitmap.visible = true;
      }
      
      //============================================================
      // <T>隐藏处理。</T>
      //============================================================
      public function hide():void{
         bitmap.visible = false;
      }
      
      //============================================================
      // <T>清空画板。</T>
      //============================================================
      public function clear():void{
         if(null != bitmapData){
            bitmapData.fillRect(bitmapData.rect, 0);
         }
      }
      
      //============================================================
      // <T>卸载数据。</T>
      //============================================================
      public function unload():void{
         size.reset();
         if(null != bitmap){
            bitmap.bitmapData = null;
         }
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         size = null;
         if(null != bitmap){
            bitmap.bitmapData = null;
            bitmap = null;
         }
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
         super.dispose();
      }
   }
}