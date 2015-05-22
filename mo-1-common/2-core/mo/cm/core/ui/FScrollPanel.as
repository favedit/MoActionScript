package mo.cm.core.ui
{
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   
   import mo.cm.system.FEvent;
   import mo.cm.system.RAllocator;
   
   public class FScrollPanel extends FControl
   {
      protected var _sprite:FSprite = new FSprite();

      // 内容面板
      public var _content:FSprite = new FSprite();
      
      // 内容面板高度
      private var _contentHeight:uint;
      
      private var _scrollAlign:uint;
      
      private var _panel:FShape = new FShape();
      
      private var _scrollButton:FScrollButton = RAllocator.create(FScrollButton);
      
      private var _isMouseDown:Boolean = false;
      
      private var _mask:FShape = new FShape();
      
      //============================================================
      public function FScrollPanel(){
         display = _sprite;
         // 响应按钮按下事件
         _scrollButton.lsnMouseDown.register(onScrollDown);
         _sprite.addEventListener(MouseEvent.MOUSE_MOVE, onScrollMove);
         _sprite.addEventListener(MouseEvent.MOUSE_UP, onScrollUp);
      }
      
      //============================================================
      public function set scrollAlign(value:uint):void{
         _scrollAlign = value;
      }
      
      //============================================================
      public override function setup():void{
         if(RStyle.SCROLL_BOTTOM == _scrollAlign){
            _scrollButton.setPosition(size.width - 20, size.height*(2/3));
         }else{
            _scrollButton.setPosition(size.width - 20, 0);
         }
         _scrollButton.size.set(20, size.height/3);
         _scrollButton.setup();
         _sprite.addChild(_panel);
         _sprite.addChild(_content);
         _sprite.addChild(_mask);
         _sprite.addChild(_scrollButton);
         _content.mask = _mask;
         draw();
      }
      
      //============================================================
      public function get contentHeight():uint {
         return _contentHeight;
      }
      
      //============================================================
      public function set contentHeight(_height:uint):void {
         _contentHeight = _height;
      } 
      
      //============================================================
      public override function draw():void {
         _panel.graphics.clear();
         _panel.graphics.beginFill(0xcccccc, 1);
         _panel.graphics.drawRect(0,0,size.width,size.height);
         _panel.graphics.endFill();
         _panel.graphics.beginFill(0xffffff, 1);
         _panel.graphics.drawRect(size.width - 20,0,20,size.height);
         _panel.graphics.endFill();
         // 为内容添加遮罩
         _mask.graphics.clear();
         _mask.graphics.beginFill(0x000000, 1);
         _mask.graphics.drawRect(0,0,size.width,size.height);
         _mask.graphics.endFill();
         // 设置内容的位置
         _content.y = -(_scrollButton.y/size.height)*_contentHeight;
      }
      
      // ===================================================================
      // <T>鼠标按下时，开始拖动滚动条。</T>
      //
      // ===================================================================
      private function onScrollDown(e:FEvent):void {
         _isMouseDown = true;
         _scrollButton.startDrag(false, new Rectangle(size.width-20, 0, 0, size.height- _scrollButton.size.height));
      }
      
      // ===================================================================
      // <T>鼠标移动时，重新计算内容的位置，内容的移动应该与button的移动是反方向的。</T>
      //
      // ===================================================================
      private function onScrollMove(e:MouseEvent):void {
         if(_isMouseDown){
            _content.y = -(_scrollButton.y/size.height)*_contentHeight;
         }
      }
      
      // ===================================================================
      // <T>鼠标松开时，停止响应异动事件。</T>
      //
      // ===================================================================
      private function onScrollUp(e:MouseEvent):void {
         _isMouseDown = false;
         _scrollButton.stopDrag();
      }
      
      // ===================================================================
      // <T>鼠标离开指定范围时，停止响应移动事件。</T>
      //
      // ===================================================================
      private function onScrollLeave(e:MouseEvent):void {
         _isMouseDown = false;
         _scrollButton.stopDrag();
      }
   }
}