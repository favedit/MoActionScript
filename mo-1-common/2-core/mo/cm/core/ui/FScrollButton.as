package mo.cm.core.ui
{
   import flash.display.CapsStyle;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.events.MouseEvent;
   
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   
   public class FScrollButton extends FSprite
   {
      // 监听鼠标按下事件
      public var lsnMouseDown:FListeners = new FListeners();
      
      protected var _event:FEvent = RAllocator.create(FEvent);

      //============================================================
      public function FScrollButton(){
         addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      }
      
      //============================================================
      protected function onMouseDown(e:MouseEvent):void {
         lsnMouseDown.process(_event);
      }

      //============================================================
      public function setup():void{
         var g:Graphics = graphics; 
         g.clear();
         g.beginFill(0x71a7a5);
         g.drawRoundRect(0, 0, size.width - 1, size.height-1, 5, 5);
         g.endFill();
      }
   }
}