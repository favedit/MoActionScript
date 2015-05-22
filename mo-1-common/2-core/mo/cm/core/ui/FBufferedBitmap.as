package mo.cm.core.ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.lang.IObject;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>缓冲位图对象。</T>
   //============================================================
   public class FBufferedBitmap extends FSprite implements IObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FBufferedBitmap);
      
      // 世界坐标点
      public var position:SIntPoint2 = new SIntPoint2();
      
      // 图片宽度
      public var pictureWidth:int;
      
      // 图片高度
      public var pictureHeight:int;
      
      // 瓦片宽度
      public var tileWidth:int;
      
      // 瓦片高度
      public var tileHeight:int;
      
      // 位图
      public var bitmap:Bitmap = new Bitmap();
      
      // 位图数据
      public var bitmapData:BitmapData;
      
      // 预览位图
      public var previewData:BitmapData;
      
      //============================================================
      // <T>构造缓冲位图对象。</T>
      //============================================================
      public function FBufferedBitmap(){
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function setup():void{
         addChild(bitmap);
      }
      
      //============================================================
      // <T>设置信息。</T>
      //
      // @param pd:previewData 预览数据
      // @param ptw:pictureWidth 图片宽度
      // @param pth:pictureHeight 图片高度 
      // @param ptw:tileWidth 瓦片宽度
      // @param pth:tileHeight 瓦片高度 
      //============================================================
      public function setInfo(pd:BitmapData, ppw:int, pph:int, ptw:int, pth:int):void{
         previewData = pd;
         pictureWidth = ppw;
         pictureHeight = pph;
         tileWidth = ptw;
         tileHeight = pth;
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
            bitmap.x = px;
         }
         if(location.y != py){
            location.y = py;
            bitmap.y = py;
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
         bitmapData.lock();
         bitmapData.copyPixels(psd, psr, pdp, pad, pap, pma);
         bitmapData.unlock();
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
         bitmapData.lock();
         bitmapData.draw(pb, pm, pt, pl, pc, ps);
         bitmapData.unlock();
      }
      
      //============================================================
      // <T>滚动处理。</T>
      //
      // @param px:x 横向滚动量
      // @param py:y 纵向滚动量
      //============================================================
      public function scroll(px:int, py:int):void{
         if((0 != px) || (0 != py)){
            bitmapData.lock();
            bitmapData.scroll(px, py);
            bitmapData.unlock();
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
         bitmap.bitmapData = d;
      }
      
      //============================================================
      // <T>更新处理。</T>
      //============================================================
      public function update():void{
      }
      
      //============================================================
      // <T>卸载处理。</T>
      //============================================================
      public function unload():void{
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
         bitmap.bitmapData = null;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
         if(null != bitmap){
            bitmap.bitmapData = null;
            bitmap = null;
         }
         super.dispose();
      }
   }
}
