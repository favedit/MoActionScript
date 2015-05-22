package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RScreen;
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.RCrConsole;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FDragEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.IUiDockable;
   import mo.cr.ui.IUiDragable;
   import mo.cr.ui.RUiConsole;
   import mo.cr.ui.layout.FUiBorder;
   
   //==========================================================
   // <T> 插槽</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiSlot extends FUiControl3d implements IUiDockable
   {
      public var _dragable:FUiDrag;
      
      public var contentContainer:FSprite = new FSprite();
      
      // 边框容器
      public var border:FUiBorder = new FUiBorder();
      
      // 背景图
      public var _backgroundBit:Bitmap = new Bitmap();
      
      // 背景图id
      public var groundRid:int;
      
      // 背景图
      public var resourcesPic:FCrPictureResource;
      
      public var itemStartLocation:SIntPoint2 = new SIntPoint2();
      
      // 当标识相同时可以发生交换
      public var _grouperName:String;
      
      public var isBorder:Boolean;
      
      public var context:FUiContext;
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function FUiSlot(){
         type = EUiControlType.Slot;
         display = contentContainer;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function paint(p:FUiContext = null):void{
         _backgroundBit.bitmapData = resourcesPic.bitmapData;
         _backgroundBit.width = size.width;
         _backgroundBit.height = size.height;
      }
      
      //============================================================
      // <T>在插槽上填加组件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function addUiDrag(drag:FUiDrag):void{
         _dragable = drag;
         _dragable.dockControl = this;
         _dragable.isDrag = false;
         contentContainer.addChild(_dragable.display);
         _dragable.display.x = itemStartLocation.x;
         _dragable.display.y = itemStartLocation.y;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         groundRid = p.getInt("ground_rid");
         itemStartLocation.parse(p.get("itemStartLocation"));
         var xb:FXmlNode = p.findNode("Border");
         if(xb){
            isBorder = true
            border.loadConfig(xb);
         }
         setup();
      }
      
      //============================================================
      // <T>保存配置信息。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid", groundRid.toString());
         p.set("itemStartLocation", itemStartLocation.toString());
         if(isBorder){
            var xb:FXmlNode = p.create("Border");
            border.saveConfig(xb);
         }
      }
      
      //============================================================
      // <T>初始化组件。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function setup():void{
         contentContainer.addChild(border.display);
         contentContainer.addChild(_backgroundBit);
         contentContainer.addEventListener(MouseEvent.CLICK, dragClick);
      }
      
      //============================================================
      // <T>鼠标点击插槽。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function dragClick(e:MouseEvent):void{
         // 鼠标拖拽的组件
         var event:FDragEvent = new FDragEvent();
         var mouseDrag:FUiDrag = RUiConsole.focusConsole.controlDrag as FUiDrag;
         if(mouseDrag){
            // 当前插槽上显示拖拽对象
            var currDrag:FUiDrag = _dragable;
            // 是否可以互换
            event.sourceDock = mouseDrag.dockControl;
            event.targetDock = this;
            mouseDrag.onDragEnd(event);
            if(testDragable(mouseDrag)){
               var slot:FUiSlot = mouseDrag.dockControl as FUiSlot;
               if(currDrag){
                  removeDrag();
                  slot.addUiDrag(currDrag);
               }
               addUiDrag(mouseDrag)
            }else{
               mouseDrag.cancle();
            }
            RUiConsole.focusConsole.controlDrag = null;
         }else{
            if(_dragable){
               // 开始拖拽
               event.sourceDock = this;
               _dragable.onDragBegin(event);
               contentContainer.removeChild(_dragable.display);
               RUiConsole.focusConsole.controlDrag = _dragable;
               var stage:Stage = RScreen.stage;
               stage.addChild(_dragable.display);
               _dragable.setLocation(stage.mouseX, stage.mouseY);
               _dragable.isDrag = true;
               _dragable = null;
            }
         }
      }
      
      //============================================================
      // <T>移除当前插槽上的元素。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function removeDrag():void{
         if(_dragable){
            contentContainer.removeChild(_dragable.display);
            _dragable = null;
         }
      }
      
      //============================================================
      // <T>资源是否加载完成</T>
      //
      // @return 资源是否加载完成
      // @author HECNG 20120227
      //============================================================
      public override function testReady():Boolean{
         if(resourcesPic){
            ready = resourcesPic.ready;
         }
         return ready;
      } 
      
      //============================================================
      // <T>获得可拖拽对象。</T>
      //
      // @return 可拖拽对象
      // @author HECNG 20120227
      //============================================================
      public function get dragControl():IUiDragable{
         return _dragable;
      }
      
      //============================================================
      // <T>设置可拖拽对象。</T>
      //
      // @param p:drag 可拖拽对象
      // @author HECNG 20120227
      //============================================================
      public function set dragControl(p:IUiDragable):void{
         _dragable = p as FUiDrag;
      }
      
      //============================================================
      // <T>测试是否可以提供拖拽对象。</T>
      //
      // @param p:drag 拖拽对象
      // @return 是否可以互换对象
      // @author HECNG 20120227
      //============================================================
      public function testDragable(p:IUiDragable):Boolean{
         return true;
      }
      
      //============================================================
      // <T>测试目标对象是否可以停留。</T>
      //
      // @param p:drag 拖拽对象
      // @return 是否可以停留
      // @author HECNG 20120227
      //============================================================
      public function testDockable(p:IUiDragable):Boolean{
         return false
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         resourcesPic = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         super.process(p);
         if(groundRid && !resourcesPic){
            resourcesPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
         }
         if(isBorder){
            border.process();
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