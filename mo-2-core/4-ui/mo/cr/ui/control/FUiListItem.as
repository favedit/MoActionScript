package mo.cr.ui.control
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.geom.SIntSize2;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cr.ui.FItemEvent;
   import mo.cr.ui.FUiComponent3d;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.RGmStyle;

   
   //==========================================================
   // <T> 数据容器</T>
   //
   // @author HECNG 20120321
   //==========================================================
   public class FUiListItem extends FUiComponent3d
   {
      // 显示对象
      public var display:Sprite = new Sprite();
      
      // 绑定显示数据
      public var value:*;
      
      // 宽高
      public var size:SIntSize2 = new SIntSize2();
      
      // 点击事件
      public var itemFlistener:FListeners = RAllocator.create(FListeners);
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120321
      //==========================================================
      public function FUiListItem(){
      }
      
      //==========================================================
      // <T> 鼠标点击事件</T>
      //
      // @author HECNG 20120321
      //==========================================================
      private function mouseClick(e:MouseEvent):void{
         var f:FItemEvent = new FItemEvent();
         f.item = this;
         itemFlistener.process(f);
      }
      
      //==========================================================
      // <T> 鼠标划过</T>
      //
      // @author HECNG 20120321
      //==========================================================
      private function mouseMove(e:MouseEvent):void{
         display.filters = [RGmStyle.listStyle];
      }
      
      //==========================================================
      // <T> 鼠标离开</T>
      //
      // @author HECNG 20120321
      //==========================================================
      private function mouseOut(e:MouseEvent):void{
         display.filters = [];
      }
      
      //==========================================================
      // <T> 设置坐标</T>
      //
      // @params hx:int, hy:int 坐标
      // @author HECNG 20120327
      //==========================================================
      public function setLocation(hx:int, hy:int):void{
         display.x = hx;
         display.y = hy;
      }
      
      //==========================================================
      // <T> 初始化组件</T>
      //
      // @params pw:width ph:height 宽高
      // @params v:valie 绑定数据
      // @author HECNG 20120321
      //==========================================================
      public function setup(pw:int, ph:int, v:*):void{
         value = v;
         size.set(pw, ph);
         display.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
         display.addEventListener(MouseEvent.MOUSE_OUT,mouseOut);
         display.addEventListener(MouseEvent.CLICK, mouseClick);
      }
      
      //==========================================================
      // <T>执行处理过程。</T>
      //
      // @param p:context 环境
      // @author HECNG 20120328
      //==========================================================
      public override function process(p:FUiContext):void{
         if(ready){
            paint();
         }
      }
      
      //==========================================================
      // <T>绘制图形。</T>
      //
      // @author HECNG 20120328
      //==========================================================
      public function paint():void{
      }
   }
}