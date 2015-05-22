package mo.cr.ui.layout
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FScaleShape;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   
   //==========================================================
   // <T> UI容器 </T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiBorder extends FObject
   {
      // 父容器对象
      public var display:Sprite = new Sprite();
      
      // 图片资源
      public var picResource:FCrPictureResource;
      
      // 九宫格
      public var scale:FScaleShape = new FScaleShape();
      
      // 九宫格资源编号
      public var scaleRid:String;
      
      // 宽高
      public var size:SIntSize2 = new SIntSize2();
      
      // 是否准备完成
      public var isReady:Boolean = false;
      
      // 是否绘制      
      public var isDrawed:Boolean = false;
      
      // 左
      public var left:Number = 0;
      
      // 上
      public var top:Number = 0;
      
      // 右
      public var right:Number = 0;
      
      // 下
      public var bottom:Number = 0;
      
      //============================================================
      // <T> 构造函数。 <T>
      //
      // @author HECNG 20120227
      //============================================================
      public function FUiBorder(){
      }
      
      //============================================================
      // <T>初始化组件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function setup():void{
         display.addChild(scale);
      }

      //============================================================
      // <T>改变组件大小</T>
      //
      // @param pw:int, ph:int 改变后的宽高
      // @author HECNG 20120227
      //============================================================
      public function resize(pw:int, ph:int):void{
         size.set(pw, ph);
         scale.resize(size.width, size.height); 
      }
      
      //============================================================
      // <T>添加显示对象</T>
      //
      // @param child:DisplayObject 子对象
      // @param x:Number, y:Number 坐标
      // @author HECNG 20120227
      //============================================================
      public function addChild(child:DisplayObject, x:Number, y:Number):void{
         display.addChild(child);
         child.x = x;
         child.y = y;
      }
      
      //============================================================
      // <T>移除显示对象</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function removeChild(child:DisplayObject):void{
         display.removeChild(child);
      }

      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         scaleRid = p.get("scale_rid");
         left = p.getNumber("left");
         top = p.getNumber("top");
         right = p.getNumber("right");
         bottom = p.getNumber("bottom");
         setup();
      }
      
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public function saveConfig(p:FXmlNode):void{
         p.set("name", "Border");
         p.set("scale_rid", scaleRid);
         p.set("left", left.toString());
         p.set("top", top.toString());
         p.set("right", right.toString());
         p.set("bottom", bottom.toString());
      }
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function process():void{
         // 准备数据
         if(scaleRid && !picResource){
            picResource = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, scaleRid);
         }
         // 测试准备
         if(!isReady){
            isReady = testReady();
         }
         // 绘制处理
         if(isReady && !isDrawed){
            onPaint();
            resize(size.width, size.height);
            isDrawed = true;
         }
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function testReady():Boolean{
         if(picResource){
            isReady = picResource.ready;
         }
         return isReady;
      }
      
      //============================================================
      // <T>绘制此图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function onPaint():void{
         if(isReady){
            scale.loadBitmap(picResource.bitmapData, left, top, right, bottom);
         }
      }
      
      //============================================================
      // <T>填充此矩形</T>
      //
      // @param container:Sprite 被填充矩形
      // @param data:BitmapData 数据源
      // @param hw:int, hg:int 数据宽高
      // @author HECNG 20120227
      //============================================================
      private function bitMapFill(container:Shape, data:BitmapData, hw:int, hg:int):void{
         // 绘制底框
         var g:Graphics = container.graphics;
         g.clear();
         g.beginBitmapFill(data);
         g.drawRect(0, 0, hw, hg);
         g.endFill();
      }
   }
}