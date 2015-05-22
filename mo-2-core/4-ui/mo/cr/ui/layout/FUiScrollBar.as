package mo.cr.ui.layout
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RScreen;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FScrollEvent;
   import mo.cr.ui.IUiScrollable;

   //==========================================================
   // <T> 滑动条</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiScrollBar extends FObject implements IUiScrollable
   {
      public static var PicId:Array = ["button_up_rid", "button_down_rid", "ground_rid", "button_drag_up_rid",
         "button_drag_middle_rid", "button_drag_bottom_rid"];
      
      // 边框显示图片 
      protected var resourcePictures:Vector.<FCrPictureResource> = new Vector.<FCrPictureResource>(6, true);
      
      // 背景图片id
      public var resourceIds:Vector.<uint> = new Vector.<uint>(6, true);
      
      // 当滚动条发生滚动时触发该事件
      public var scrollListener:FListeners = new FListeners();
      
      // 滚动条方向 
      public var direction:String = EUiScrollBar.HORIZONTAL;
      
      // 表示最大滚动位置的数值。
      public var maxScrollPosition:Number = 0;
      
      // 表示最小滚动位置的数值。
      public var minScrollPosition:Number = 0;
      
      // 按下滚动条轨道时滚动滑块的移动量（以像素为单位）。
      public var pageScrollSize:Number = 50;
      
      // 当前滚动位置
      public var scrollPosition:uint = 0;
      
      // 向上按钮
      protected var upBotton:Sprite = new Sprite();
      
      // 拖拽按钮
      protected var dragBotton:Sprite = new Sprite();
      
      // 向下
      protected var downBotton:Sprite = new Sprite();
      
      // 拖拽按钮中间平铺背景
      protected var dragBitUp:Bitmap = new Bitmap();
      
      // 拖拽按钮中间平铺背景
      protected var dragBitDown:Bitmap = new Bitmap();
      
      // 滑动条中间背景
      public var display:Sprite = new Sprite();
      
      // 资源是否加载完成
      protected var ready:Boolean;

      // 宽高
      public var size:SIntSize2 = new SIntSize2();
      
      // 坐标
      public var location:SIntPoint2 = new SIntPoint2();
      
      // 名称
      public var name:String;
      
      // 是否被绘制
      public var isDrawed:Boolean;
      
      // 是否被拖拽
      public var isDrag:Boolean;

      // 拖拽范围矩形
      public var dragRect:Rectangle = new Rectangle(0,0,0,0);
      
      // 拖动按钮相对与整个区域宽高的百分比
      public var scale:Number;
      
      // 拖动按钮坐标所处位置
      public var cPoint:Number;
      
      //===========================================================
      // <T> 构造函数。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function FUiScrollBar(){
      }
      
      //===========================================================
      // <T>改变组件大小</T>
      //
      // @param pw:int, ph:int 组件宽高
      // @author HECNG 20120227
      //===========================================================
      public function setSize(pw:int, ph:int):void{
         switch(direction){
            case EUiScrollBar.VERTICAL:
               size.height = ph;
               break;
            case EUiScrollBar.HORIZONTAL:
               size.width = pw;
               break;
         }
         paint();
      }
      
      //===========================================================
      // <T>修改坐标</T>
      //
      // @param x:Number, y:Number 坐标位置
      // @author HECNG 20120227
      //===========================================================
      public function setLoaction(hx:Number, hy:Number):void{
         location.set(hx, hy);
         display.x = location.x;
         display.y = location.y;
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public function setupEnd():void{
         for each(var n:FCrPictureResource in resourcePictures){
           n = null;
         }
         ready = false;
         isDrawed = false;
      }
      
      //===========================================================
      // <T>初始化组件</T>
      //
      // @author HECNG 20120227 
      //===========================================================
      public function setup():void{ 
         display.addChild(upBotton);
         display.addChild(downBotton);
         display.addChild(dragBotton);
         dragBotton.addChild(dragBitDown);
         dragBotton.addChild(dragBitUp);
         upBotton.addEventListener(MouseEvent.CLICK, scrollUp);
         downBotton.addEventListener(MouseEvent.CLICK, scrollDown);
         RScreen.stage.addEventListener(MouseEvent.MOUSE_UP, dragUp);
//         dragBotton.addEventListener(MouseEvent.MOUSE_OUT, dragUp);
         dragBotton.addEventListener(MouseEvent.MOUSE_DOWN, dragDown);
         RScreen.stage.addEventListener(MouseEvent.MOUSE_MOVE,drag);
//		   size.set(18, 18);
      }
      
      //============================================================
      // <T>资源是否加载完成</T>
      //
      // @return 资源是否加载完成
      // @author HECNG 20120227
      //============================================================
      public function testReady():Boolean{
         for each(var n:FCrPictureResource in resourcePictures){
            if(!n){
              return false;  
            }
            if(!n.ready){
               return false;
            }
         }
         ready = true;
         return ready;
      }
      
      //===========================================================
      // <T>清除当前画布显示元素</T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function clear():void{
         display.graphics.clear();
      }
      
      //===========================================================
      // <T>改变显示对象的位置(只在初始化和改变大小是调用)</T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function setPosition():void{
         upBotton.x = upBotton.y = 0;
         switch(direction){
            case EUiScrollBar.VERTICAL:
               downBotton.y = size.height - downBotton.height;
               downBotton.x = dragBitUp.x = dragBitDown.x = dragBitUp.y = 0;
			      dragBotton.x = (size.width - dragBotton.width) / 2;
               move(cPoint, 0);
               dragBitDown.y = dragBotton.height - dragBitDown.height;
               dragRect = new Rectangle(0, upBotton.height, 0,  size.height - 2 * downBotton.height - dragBotton.height);
               break;
            case EUiScrollBar.HORIZONTAL:
               downBotton.y = dragBitDown.y = dragBitUp.x = 0;
			      dragBotton.y = (size.height - dragBotton.height) / 2;
               downBotton.x = size.width - downBotton.width;
               move(cPoint, 0);
               dragBitDown.x = dragBotton.width - dragBitDown.width;
               dragRect = new Rectangle(upBotton.width, 0, size.width - 2 * downBotton.width - dragBotton.width,  0);
               break;
         } 
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function process():void{
         for(var n:int = 0; n < resourceIds.length; n++){
            if(!resourcePictures[n]){
               if(resourceIds[n] != 0){
                  resourcePictures[n] = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, resourceIds[n].toString());
               }
            }
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !isDrawed){
            paint();
            isDrawed = true;
         }
      }
      
      //============================================================
      // <T>以某种颜色填充board</T>
      // 
      // @param data:BitmapData 被清楚位图信息
      // @param color:uint 填充颜色
      // @author HECNG 20120227
      //============================================================
      private function fillRect(data:BitmapData, color:uint = 0xffffff):void{
         data.fillRect(new Rectangle(0, 0, data.width, data.height), color);
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function paint():void{
         if(ready){
            var upBit:BitmapData = resourcePictures[0].bitmapData;
            var downBit:BitmapData = resourcePictures[1].bitmapData;
            var disBit:BitmapData = resourcePictures[2].bitmapData;
            graphics(upBotton.graphics, upBit.width, upBit.height, upBit);
            graphics(downBotton.graphics, downBit.width, downBit.height, downBit);
            graphics(display.graphics, size.width, size.height, disBit);
            dragBitUp.bitmapData = resourcePictures[3].bitmapData;
            dragBitDown.bitmapData = resourcePictures[5].bitmapData;
            dragBotton.graphics.clear();
            dragBotton.graphics.beginBitmapFill(resourcePictures[4].bitmapData);		
			   drawDragButton();
			   dragBotton.graphics.endFill();
            setPosition();
         }
      }
      
      //============================================================
      // <T>绘制拖拽按钮</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function drawDragButton():void{
         var w:int;
         var h:int;
         var distance:int;
         switch(direction){
            case EUiScrollBar.VERTICAL:
               distance = size.height - 2 * upBotton.height;
               w = size.width;
               h = distance * scale;
               break;
            case EUiScrollBar.HORIZONTAL:
               distance = size.width - 2 * upBotton.width;
               w = distance * scale;
               h = size.height;
               break;
         }
         dragBotton.graphics.drawRect(0, 0, w, h);
         dragBotton.width = w;
         dragBotton.height = h;
      }
      
      //============================================================
      // <T>复制图形</T>
      //
      // @params g:Graphic 绘制对象
      // @params w:int, h:int 宽高
      // @params d:BitmapData 图形数据
      // @author HECNG 20120227
      //============================================================
      private function copyPilex(data:BitmapData, copy:BitmapData, x:int, y:int):void{
         data.copyPixels(copy,new Rectangle(0, 0, copy.width, copy.height), new Point(x, y));
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @params g:Graphic 绘制对象
      // @params w:int, h:int 宽高
      // @params d:BitmapData 图形数据
      // @author HECNG 20120227
      //============================================================
      private function graphics(g:Graphics, w:int, h:int, d:BitmapData):void{
         g.clear();
         g.beginBitmapFill(d);
         g.drawRect(0, 0, w, h);
         g.endFill();
      }
      
      
      //===========================================================
      // <T> 鼠标拖动<T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function drag(e:MouseEvent):void{
         if(isDrag){
            mousePoint(new Point(dragBotton.x, dragBotton.y));
         }
      }
      
      //===========================================================
      // <T> 点击向上滚动<T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function scrollUp(e:MouseEvent = null):void{
         mousePoint(new Point(dragBotton.x - pageScrollSize, dragBotton.y - pageScrollSize));
      }
      
      //===========================================================
      // <T> 点击向下滚动<T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function scrollDown(e:MouseEvent = null):void{
         mousePoint(new Point(dragBotton.x + pageScrollSize, dragBotton.y + pageScrollSize));
      }
      
      //===========================================================
      // <T> 点击滑动条开始拖动<T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function dragDown(e:MouseEvent):void{
         isDrag = true;
         dragBotton.startDrag(false, dragRect);
      }
      
      //===========================================================
      // <T> 松开滑动条，停止拖拽<T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function dragUp(e:MouseEvent):void{
         isDrag = false;
         dragBotton.stopDrag();
      }
      
      //===========================================================
      // <T> 发生事件时鼠标的位置<T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function mousePoint(p:Point):void{
         switch(direction){
            case EUiScrollBar.VERTICAL:
               move(p.y);
               break;
            case EUiScrollBar.HORIZONTAL:
               move(p.x);
               break;
         }
      }
      
      //===========================================================
      // <T> 滑块移动<T>
      //
      // @param currNumber:Number    滑块滑动后的位置()
      // @param type （-1）根据鼠标位置求滚动位置（0）根据滚动位置求拖拽按钮坐标
      // @author HECNG 20120227
      //===========================================================
      public function move(p:Number, type:int = -1):void{
         var start:Number;
         var end:Number;
         var distance:Number;
         var dragButtonPoint:Number;
         switch(direction){
            case EUiScrollBar.VERTICAL:
               start = upBotton.height;
               end = size.height - start - dragBotton.height;
               break;
            case EUiScrollBar.HORIZONTAL:
               start = upBotton.width;
               end = size.width - start - dragBotton.width;
               break;
         }
         distance = end - start;
         if(type == -1){
            if(p >= end){
               p = end;
            }
            if(p <= start){
               p = start;
            }
            scrollPosition =  (p - start) * maxScrollPosition / distance;
            dragButtonPoint = p;
         }else{
            scrollPosition = p;
            dragButtonPoint = distance * scrollPosition / maxScrollPosition + start;
         }
         if(direction == EUiScrollBar.VERTICAL){
            dragBotton.y = dragButtonPoint;
         }else{
             dragBotton.x = dragButtonPoint;
         }
         var e:FScrollEvent = RAllocator.create(FScrollEvent);
         e.scrollPosition = scrollPosition;
         scrollListener.process(e);
      }
      
      //===========================================================
      // <T> 获取滚动对象 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function  get scroll():FUiScrollBar{
         return this;
      }
      
      //============================================================
      // <T> 加载配置文件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         name = p.get("name");
         direction = p.get("direction");
         size.parse(p.get("size"));
         pageScrollSize = p.getInt("page_scroll_size");
         var length:int = resourceIds.length;
         for(var n:int = 0; n < length; n++ ){
            resourceIds[n] = p.getInt(PicId[n].toString());
         }
         setup();
      }
      
      //============================================================
      // <T> 保存配置文件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function saveConfig(p:FXmlNode):void{
        p.set("name", name);
        p.set("direction", direction);
        p.set("size", size.toString());
        p.set("page_scroll_size", pageScrollSize.toString());
        var length:int = resourcePictures.length;
        for(var n:int = 0; n < length; n++ ){
           p.set(PicId[n].toString(),  resourceIds[n].toString());
        }
      }
      
      //===========================================================
      // <T> 设置 FUiScroll的范围和视口大小。FUiScroll会相应地更新箭头按钮的状态和滚动滑块的大小。 <T>
      //  
      // @params max:Number, min:Number 滚动范围
      // @params pageScrollSize:Number 鼠标点击时移动的范围
      // @params s:number 比例系数
      // @params p:number 拖动按钮坐标所处位置
      // @author HECNG 20120227
      //===========================================================
      public function setScrollProperties(max:Number, min:Number, pageScrollSize:Number, s:Number, p:Number):void{
         maxScrollPosition = max;
         minScrollPosition = min;
         pageScrollSize = pageScrollSize;
         scale = s;
         cPoint = Math.abs(p);
      }
   }
}