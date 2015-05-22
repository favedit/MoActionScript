package mo.cr.ui.layout
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FScrollEvent;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.control.EUiControlType;
 
   //==========================================================
   // <T> 滑动盒子</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiScrollBox extends FObject
   {
      // 容器
      public var display:FSprite = new FSprite();
      
      // 纵向滚动条
      public var verticalBar:FUiScrollBar = new FUiScrollBar();
      
      // 横向滚动条
      public var horizontalBar:FUiScrollBar = new FUiScrollBar();
      
      // 宽高
      public var size:SIntSize2 = new SIntSize2();
      
      // 坐标
      public var location:SIntPoint2 = new SIntPoint2();
      
      // 显示内容
      public var contentScroll:Sprite = new Sprite();
      
      // 遮罩层
      public var _mask:Shape = new Shape();
      
      // 背景图id
      public var groundRid:int = 0;;
      
      // 背景图
      public var groundPic:FCrPictureResource;
      
      // 是否显示竖向拖动条
      public var isVertical:Boolean = true;
      
      // 是否像是横向拖动条
      public var isHorizontal:Boolean = true;
      
      // 每次滚动距离
      public var pageScrollSize:int = 10;
      
      // 资源是否加载完成
      public var ready:Boolean;
      
      // 是否绘制
      public var dirty:Boolean;
      
      public var name:String;
      
      //===========================================================
      // <T> 构造函数。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function FUiScrollBox(){ 
      }
      
      //===========================================================
      // <T> 初始化组件。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function setup():void{
         name = "scrollBox";
         verticalBar.name = "verticalBar";
		   verticalBar.direction = EUiScrollBar.VERTICAL;
         horizontalBar.name = "horizontalBar";
		   horizontalBar.direction = EUiScrollBar.HORIZONTAL;
         display.addChild(_mask);
         display.addChild(contentScroll);
         var v:Sprite = verticalBar.display;
         var h:Sprite = horizontalBar.display;
         display.addChild(v);
         display.addChild(h);
         v.visible = h.visible = false;
         contentScroll.mask = _mask;
         verticalBar.scrollListener.register(verticalScroll, this);
         horizontalBar.scrollListener.register(horizontalScroll, this);
         display.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public function setupEnd():void{
         groundPic = null;
         horizontalBar.setupEnd();
         verticalBar.setupEnd();
         ready = false;
         dirty = false;
      }
      
      //===========================================================
      // <T> 鼠标滚轮事件。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function mouseWheel(e:MouseEvent):void{
		  if(verticalBar.display.visible){
			  e.delta > 0 ? verticalBar.scrollUp() : verticalBar.scrollDown();
		  }
      }
      
      //===========================================================
      // <T> 设置坐标。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function setLoaction(hx:int, hy:int):void{
         location.set(hx, hy);
         display.x = location.x;
         display.y = location.y;
            
      }
      
      //===========================================================
      // <T> 纵向滚动<T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function verticalScroll(e:FScrollEvent):void{
         contentScroll.y = -verticalBar.scrollPosition;
      }
      
      //===========================================================
      // <T> 横向滚动<T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function horizontalScroll(e:FScrollEvent):void{
         contentScroll.x = -horizontalBar.scrollPosition;
      }
      
      //===========================================================
      // <T> 在BOX上添加显示对象<T>
      //
      // @param child:DisplayObject 显示对象
      // @param x:Number, y:Number 父容器坐标
      // @author HECNG 20120227
      //===========================================================
      public function addChild(child:DisplayObject, x:Number = 0, y:Number = 0):void{
         contentScroll.addChild(child);         
         child.x = x;
         child.y = y;
         paint();
      }
      
      //===========================================================
      // <T> 删除显示元素<T>
      //
      // @param child:DisplayObject 显示对象
      // @author HECNG 20120227
      //===========================================================
      public function removeChild(child:DisplayObject):void{
         contentScroll.removeChild(child);
         paint();
      }
      
      //===========================================================
      // <T> 设置显示列表坐标<T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function setPosition():void{
         _mask.x = _mask.y = 0;
         verticalBar.setLoaction((size.width - verticalBar.size.width), 0);
         horizontalBar.setLoaction(0, (size.height - horizontalBar.size.height));
		   if(!verticalBar.display.visible){
			  contentScroll.y = 0;
		   }
		   if(!horizontalBar.display.visible){
			  contentScroll.x = 0;
		   }
	  }
      
      //============================================================
      // <T>绘制此图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function paint():void{
         if(ready){
            groundPic != null ?  graphics(display.graphics, size.width, size.height, groundPic.bitmapData) :  graphics(display.graphics, size.width, size.height, null);
            var g:Graphics = _mask.graphics;
            g.clear();
            g.beginFill(0xffffff);
            g.drawRect(0, 0, size.width, size.height);
            g.endFill();
            setScroll();
            setBarSize();
			   setPosition();
         }
      }
      
      //============================================================
      // <T>设置滚动条宽高</T>
      //
      // @author HECNG 20120227
      //============================================================
      private function setBarSize():void{
         if(horizontalBar.display.visible && verticalBar.display.visible){
            horizontalBar.setSize(size.width - verticalBar.size.width, size.height);
            verticalBar.setSize(size.width, size.height - horizontalBar.size.height);
         }else{
            horizontalBar.setSize(size.width, size.height);
            verticalBar.setSize(size.width, size.height);
         }
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
         d ?  g.beginBitmapFill(d) : g.beginFill(0xffffff, 0);
         g.drawRect(0, 0, w, h);
         g.endFill();

      }
      
      //============================================================
      // <T>加载配置文件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         name = p.get("name");
         groundRid = p.getInt("ground_rid");
         isVertical = p.getBoolean("isVertical");
         isHorizontal = p.getBoolean("isHorizontal");
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            switch(x.get("direction")){
               case EUiScrollBar.HORIZONTAL:
                  horizontalBar.loadConfig(x);
                  break;
               case EUiScrollBar.VERTICAL:
                  verticalBar.loadConfig(x);
                  break;
            }
         }
      }
      
      //============================================================
      // <T>保存配置文件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function saveConfig(p:FXmlNode):void{
         p.set("name", name);
         p.set("ground_rid", groundRid.toString());
         p.setBoolean("isVertical", isVertical);
         p.setBoolean("isHorizontal", isHorizontal);
         var hb:FXmlNode = p.create(EUiControlType.ScrollBar);
         var vb:FXmlNode = p.create(EUiControlType.ScrollBar);
         horizontalBar.saveConfig(hb);
         verticalBar.saveConfig(vb);
      }
      
      //============================================================
      // <T>设置滚动条</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function setScroll():void{
         var vscale:Number = _mask.height / contentScroll.height;
         var hscale:Number = _mask.width / contentScroll.width;
         var v:Sprite = verticalBar.display;
         var h:Sprite = horizontalBar.display;
         var hp:Number;
         var vp:Number;
         var Hmax:Number;
         var Vmax:Number;
         v.visible = h.visible = false;
         if(vscale < 1 && isVertical){
            v.visible = true;
            Vmax = contentScroll.height - _mask.height;
            vp = -contentScroll.y > Vmax ? Vmax : -contentScroll.y;
            verticalBar.setScrollProperties(Vmax, 0, pageScrollSize, vscale, vp);
         }
         if(hscale < 1 && isHorizontal){
            h.visible = true;
            Hmax = contentScroll.width - _mask.width;
            hp = -contentScroll.x > Hmax ? Hmax : -contentScroll.x;
            horizontalBar.setScrollProperties(Hmax, 0, pageScrollSize, hscale, hp);
         } 
         if(vscale < 1 && hscale < 1){
            verticalBar.setScrollProperties(Vmax + horizontalBar.size.height, 0, pageScrollSize, vscale, vp);
            horizontalBar.setScrollProperties(Hmax + verticalBar.size.width, 0, pageScrollSize, hscale, hp);
         }
      }
      
      //============================================================
      // <T>数据是否加载完成。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function testReady():Boolean{
         if(groundPic){
            ready = groundPic.ready;
         }
         if(groundRid == 0){
            ready = true;
         }
         return ready;
      }
      
      //============================================================
      // <T>清楚显示数据。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function clear():void{
         while(contentScroll.numChildren > 0){
            contentScroll.removeChildAt(0);
         }
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public  function process():void{
         horizontalBar.process();
         verticalBar.process();
         if(!groundPic){
            if(groundRid){
               groundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
            }
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint();
            dirty = true;
         }
      }
   }
}