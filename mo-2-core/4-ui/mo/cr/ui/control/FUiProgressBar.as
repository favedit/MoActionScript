package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.RCrConsole;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   
   //==========================================================
   // <T> 进度条</T>
   //
   // @author HECNG 20120427
   //==========================================================
   public class FUiProgressBar extends FUiControl3d
   {
      // 背景容器
      public var contentContainer:FSprite = new FSprite();
      
      // 背景图编号
      public var groundRid:uint = 0;
      
      // 进度条图片编号
      public var progressRid:uint = 0;
      
      // 标签图片
      public var markRid:uint = 0;
      
      // 标签位图
      public var markbit:Bitmap = new Bitmap();
      
      // 背景图
      public var groundPic:FCrPictureResource;
      
      // 进度条图
      public var progressPic:FCrPictureResource;
      
      // 标签图片
      public var markPic:FCrPictureResource;
      
      // 进度条容器
      public var progressShape:Shape = new Shape();
      
      // 遮罩层
      public var mask:Shape  = new Shape();
      
      // 总值
      public var count:uint = 0;
      
      // 当前值
      public var currRate:uint = 0;
      
      // 内容
      public var context:FUiContext;
      
      // 标签图片的y坐标
      public var markY:Number;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120427
      //==========================================================
      public function FUiProgressBar(){
         display = contentContainer;
         type = EUiControlType.ProgressBar;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function mouseEnable(bool:Boolean):void{
         contentContainer.mouseChildren = bool;
         contentContainer.mouseEnabled = bool;
      }
      
      //===========================================================
      // <T> 初始化组件。 <T>
      //
      // @author HECNG 20120427
      //===========================================================
      public override function setup():void{
         contentContainer.addChild(progressShape);
         contentContainer.addChild(mask);
         contentContainer.addChild(markbit);
         reset();
         progressShape.mask = mask;
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(groundPic && progressPic){
            if(groundPic.ready && progressPic.ready){
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>更新进度条。</T>
      //
      // @param count 总进度
      // @param curr 当前进度
      // @param p:context 环境
      //============================================================
      public function updateProgress(c:int, curr:int):void{
         count = c;
         currRate = curr;
         setupEnd();
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         groundPic = null;
         progressPic = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120428
      //============================================================
      public override function paint(p:FUiContext = null):void{
         if(ready){
            var g:Graphics = mask.graphics;
            g.beginFill(0x000000);
            g.drawRect(0, 0, size.width, size.height);
            g.endFill();
            graphics(contentContainer.graphics, groundPic.bitmapData);
            graphics(progressShape.graphics, progressPic.bitmapData);
            if(markPic){
               if(markPic.ready){
                  var b:BitmapData = markPic.bitmapData;
                  markbit.bitmapData = b;
                  markbit.width = b.width;
                  markbit.height = b.height;
               }
            }
            reset();
            updatePosition();
         }
      }
      
      //============================================================
      // <T>更新坐标</T>
      //
      // @author HECNG 20120428
      //============================================================
      public function updatePosition():void{
//         progressShape.x += getProgressWidth();
//         markbit.x += progressShape.x + progressShape.width;
         mask.x += getProgressWidth();
         markbit.x += mask.x + progressShape.width;
      }
      
      //============================================================
      // <T>重置坐标</T>
      //
      // @author HECNG 20120428
      //============================================================
      public function reset():void{
         mask.y = 0;
         mask.x = -size.width;
         markbit.x = - markbit.width / 2;
         markbit.y = markY;
//         progressShape.y = 0;
//         progressShape.x = 0;
//         markbit.x = - markbit.width / 2;
//         markbit.y = markY;
      }
      
      //============================================================
      // <T>复制图片</T>
      //
      // @params g 绘制对象
      // @params b 位图数据
      // @author HECNG 20120428
      //============================================================
      public function graphics(g:Graphics, b:BitmapData):void{
         g.clear();
         g.beginBitmapFill(b);
         g.drawRect(0, 0, size.width, size.height);
         g.endFill();
      }
      
      //============================================================
      // <T>计算进度条的宽度</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function getProgressWidth():Number{
         var num:Number = currRate * size.width / count;
         return num;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         count = p.getUint("count");
         currRate = p.getUint("currrate");
         groundRid = p.getUint("ground_rid");
         progressRid = p.getUint("progress_rid");
         markRid = p.getUint("mark_rid");
         markY = p.getNumber("mark_y");
         setup();
      }
      
      //============================================================
      // <T>保存组件。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("count", count.toString());
         p.set("currrate", currRate.toString());
         p.set("ground_rid", groundRid.toString());
         p.set("progress_rid", progressRid.toString());
         p.set("mark_rid", markRid.toString());
         p.set("mark_y", markY.toString());
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         if(groundRid && !groundPic){
            groundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
         }
         if(progressRid && !progressPic){
            progressPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, progressRid.toString());
         }
         if(markRid && !markPic){
            markPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, markRid.toString());
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
   }
}