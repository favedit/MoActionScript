package mo.cm.core.ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mo.cm.lang.IObject;
   import mo.cm.lang.RObject;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>位图对象。</T>
   //============================================================
   public class FBitmap extends Bitmap implements IObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FBitmap);
      
      // 唯一哈希标识
      public var hashCode:int = RObject.next();
      
      // 坐标点
      public var location:Point = new Point(0, 0);

      // 释放标识
      public var disposed:Boolean;
      
      //============================================================
      // <T>构造位图对象。</T>
      //
      // @param pd:bitmapData 位图数据
      // @param ps:pixelSnapping 像素处理
      // @param pm:smoothing 圆滑处理
      //============================================================
      public function FBitmap(pd:BitmapData = null, ps:String = "auto", pm:Boolean = false){
         super(pd, ps, pm);
      }
      
      //============================================================
      // <T>构造资源。</T>
      //============================================================
      public function construct():void{
         disposed = false;
      }
      
      //============================================================
      // <T>设置坐标位置。</T>
      //
      // @param px:x 横坐标
      // @param py:y 纵坐标
      //============================================================
      public function setLocation(px:int, py:int):void{
         if(location.x != px){
            location.x = px;
            x = px;
         }
         if(location.y != py){
            location.y = py;
            y = py;
         }
      }
      
      //============================================================
      // <T>复制来源位图到指定坐标位置。</T>
      //
      // @param psd:sourceBitmapData 来源位图数据
      // @param psr:sourceRect 来源矩形
      // @param pdp:destPoint 目标坐标
      // @param pad:alphaBitmapData 透明位图数据
      // @param pap:alphaPoint 透明坐标
      // @param pma:mergeAlpha 透明合并
      //============================================================
      public function copyPixels(psd:BitmapData, psr:Rectangle, pdp:Point, pad:BitmapData = null, pap:Point = null, pma:Boolean = false):void{
         bitmapData.copyPixels(psd, psr, pdp, pad, pap, pma);
      }
      
      //============================================================
      // <T>绘制来源位图到指定坐标位置。</T>
      //
      // @param pb:source 来源位图数据
      // @param pm:matrix 矩阵
      // @param pt:colorTransform 颜色变换
      // @param pl:blendMode 变换模式
      // @param pc:clipRect 剪辑矩形
      // @param ps:smoothing 圆滑处理
      //============================================================
      public function draw(pb:IBitmapDrawable, pm:Matrix = null, pt:ColorTransform = null, pl:String = null, pc:Rectangle = null, ps:Boolean = false):void{
         bitmapData.draw(pb, pm, pt, pl, pc, ps);
      }

      //============================================================
      // <T>滚动处理。</T>
      //
      // @param px:x 横向滚动量
      // @param py:y 纵向滚动量
      //============================================================
      public function scroll(px:int, py:int):void{
         if((0 != px) || (0 != py)){
            bitmapData.scroll(px, py);
         }
      }

      //============================================================
      // <T>更改大小处理。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      //============================================================
      public function resize(pw:int, ph:int):void{
         var d:BitmapData = bitmapData;
         if(null != d){
            if((d.width == pw) && (d.height == ph)){
               return;
            }
            d.dispose();
            d = null;
         }
         d = new BitmapData(pw, ph, true, 0);
         bitmapData = d;
      }
      
      //============================================================
      // <T>更新处理。</T>
      //============================================================
      public function update():void{
      }

      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function dispose():void{
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
         disposed = false;
      }
   }
}