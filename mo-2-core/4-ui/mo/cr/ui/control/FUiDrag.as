package mo.cr.ui.control
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RScreen;
   import mo.cr.console.RCrConsole;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FDragEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.IUiDockable;
   import mo.cr.ui.IUiDragable;
   
   //==========================================================
   // <T> 可拖拽界面</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiDrag extends FUiControl3d implements IUiDragable
   {
      public var containerDisplay:Sprite = new Sprite();
      
      // 背景图
      public var resourcesPic:FCrPictureResource;
      
      // 背景图Id
      public var resourceId:uint;
      
      // 片插槽
      public var _slot:FUiSlot;
      
      // 当此组件被拖在空白处时点击，true此组件被销毁，false返回原处
      public var isDestroy:Boolean;
      
      // 是否被拖拽
      public var isDrag:Boolean;
      
      private var context:FUiContext;
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function FUiDrag(){
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function testReady():Boolean{
         if(resourcesPic){
            ready = resourcesPic.ready ? true : false;
         }
         return  ready;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         if(resourceId && !resourcesPic){
            resourcesPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, resourceId.toString());
         }
         if(isDrag){
            containerDisplay.x = RScreen.stage.mouseX + 1;
            containerDisplay.y = RScreen.stage.mouseY + 1;
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
      
      //============================================================
      // <T>初始化组件</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function setup():void{
         this.display = containerDisplay;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function paint(p:FUiContext = null):void{
         var g:Graphics = containerDisplay.graphics;
         var b:BitmapData = resourcesPic.bitmapData;
         g.clear();
         g.beginBitmapFill(b);
         g.drawRect(0, 0, b.width, b.height);
         g.endFill();
      }
      
      //============================================================
      // <T>鼠标点击空白处是销毁还是返回空白处。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function cancle():void{
         containerDisplay.parent.removeChild(containerDisplay);
         if(isDestroy){
            _slot.dragControl = null;
         }else{
            _slot.addUiDrag(this);
         }
      }
      
      //============================================================
      // <T>开始拖拽处理。</T>
      //
      // @param e:event 拖拽事件
      // @author HECNG 20120227
      //============================================================
      public function onDragBegin(e:FDragEvent):void{ 
      }
      
      //============================================================
      // <T>拖拽中处理。</T>
      //
      // @param e:event 拖拽事件
      // @author HECNG 20120227
      //============================================================
      public function onDraging(e:FDragEvent):void{
      }
      
      //============================================================
      // <T>结束拖拽处理。</T>
      //
      // @param e:event 拖拽事件
      // @author HECNG 20120227
      //============================================================
      public function onDragEnd(e:FDragEvent):void{
      }
      
      //============================================================
      // <T>获得可停泊对象。</T>
      //
      // @return 可停泊对象
      // @author HECNG 20120227
      //============================================================
      public function get dockControl():IUiDockable{
         return _slot;
      }
      
      //============================================================
      // <T>设置可停泊对象。</T>
      //
      // @param p:dock 可停泊对象
      // @author HECNG 20120227
      //============================================================
      public function set dockControl(p:IUiDockable):void{
         _slot = p as FUiSlot;
      }
   }
}