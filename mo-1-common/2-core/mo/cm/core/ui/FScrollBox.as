package mo.cm.core.ui
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.logger.RLogger;
   import mo.cm.system.FEvent;
   import mo.cm.system.ILogger;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   
   //============================================================================
   // <T>带滚动条的sprite</T>
   //
   // @class[FSprite]
   // @author HYKUN
   // @Date 2010
   // @version 1.0.1
   //============================================================================
   public class FScrollBox extends FSprite
   {
      // @ 打印日志
      private static var _logger:ILogger = RLogger.find(FScrollBox);
      
      // @structure 结构变量
      //============================================================
      // @structure 绘制精灵
      protected var _content:FSprite = new FSprite();
      // @structure 遮罩
      protected var _mask:Shape = new Shape();
      // @structure 滚动条矩形    
      protected var _scrollRectangle:Rectangle = new Rectangle();
      // @structure 表示滚动的矩形
      protected var _scrollButton:FScrollButton = RAllocator.create(FScrollButton);
      // @structure 向上键
      protected var _upButton:FBox = RAllocator.create(FBox);
      // @structure 向下键
      protected var _downButton:FBox = RAllocator.create(FBox);
      // @structure 置顶键
      protected var _headButton:FBox = RAllocator.create(FBox);
      // @structure 置地键
      protected var _tailButton:FBox = RAllocator.create(FBox);
      
      
      // @property 属性变量
      //============================================================
      // @property 位置
      protected var _position:SIntPoint2 = new SIntPoint2();
      // @property 背景色
      protected var _backgroundColor:uint = 0x45716f;
      // @property 背景透明度
      protected var _backgroundAlpha:Number = 1;
      // @property 背景边框色
      protected var _backgroundBorderColor:uint = 0x45716f;
      // @property 滚动条透明度
      protected var _scrollAlpha:Number = 1;
      // @property 滚动条颜色
      protected var _scrollColor:uint = 0x1f2f30;
      // @property 滚动条宽度
      protected var _scrollWidth:uint = 16;
      // @property 内容高度
      protected var _contentHeight:uint;
      // @property 初始BUTTON的对齐方式（沉底|置顶）
      protected var _scrollAlign:uint;
      // @property 鼠标按下
      protected var _isMouseDown:Boolean = false;
      // @property 滚动条位置（左还是右）
      protected var _isScrollLeft:Boolean = false;
      // @property 按钮和滚动条的X偏移量
      protected var _xOffset:int = 0;
      // @property 是否拖拽
      protected var _isDrag:Boolean = false;
      // @property 拖拽方向
      protected var _dragDirect:int = 0;
      
      
      
      //============================================================
      public function FScrollBox(){
         // 响应按钮按下事件
         _scrollButton.lsnMouseDown.register(onScrollDown);
         addEventListener(MouseEvent.MOUSE_MOVE, onScrollMove);
         addEventListener(MouseEvent.MOUSE_UP, onScrollUp);
         
//         _headButton.lsnClick.register(goTop);
//         _tailButton.lsnClick.register(goTail);
//         _upButton.lsnClick.register(up);
//         _downButton.lsnClick.register(down);
         //_sprite.addEventListener(MouseEvent.MOUSE_OUT, onScrollLeave);
      }
      
      //============================================================
      public function setup():void{
         // 设置滑动按钮  
         _scrollButton.size.set(_scrollWidth, size.height/5);   
         if(!_isScrollLeft){
            _xOffset = size.width - _scrollWidth - 1;
         }   
         _scrollButton.size.height = 140;
         _scrollButton.setPosition(_xOffset,30);
         _scrollButton.setup();

         // 增加对象
         addChild(_content);
         addChild(_mask);
         addChild(_scrollButton);
         addChild(_upButton.display);
         addChild(_downButton.display);
         addChild(_headButton.display);
         addChild(_tailButton.display);
         // 基础信息
         _content.x = 2;
         _content.y = 2;
         //_mask.width = _size.width;
         //_mask.height = _size.width;
         _content.mask = _mask;
         //mask = _mask;
         //按钮信息
         //up
         _upButton.setPosition(_xOffset,15);
         _upButton.size.width = 15;
         _upButton.size.height = 15;
         //down
         _downButton.setPosition(_xOffset,size.height - 30);
         _downButton.size.width = 15;
         _downButton.size.height = 15;
         //head
         _headButton.setPosition(_xOffset,0);
         _headButton.size.width = 15;
         _headButton.size.height = 15;
         //tail
         _tailButton.setPosition(_xOffset,size.height - 15);
         _tailButton.size.width = 15;
         _tailButton.size.height = 15;
         // 绘制
         draw();
      }
      
      //============================================================================
      // <T>赋值</T>
      //
      // @params 一个XML节点      
      // @Date 5.24 新建 HANZH
      //============================================================================
      public function loadConfig(node:FXmlNode):void{
      }
      


      public function get position():SIntPoint2{
         return _position;
      }

      //============================================================
      public function parsePosition(value:String):void{
         _position.parse(value);
         y = _position.y;
         x = _position.x;
      }

      public function get content():DisplayObjectContainer{
         return _content;
      }
      
      //============================================================================
      // <T>获取向上按钮</T>
      //
      // @return 向上按钮<UL>
      //     		</UL>
      // @Date 5.25 新建 HANZH
      //============================================================================
      public function get upButton():FBox{
         return _upButton;
      }
      //============================================================================
      // <T>获取置底按钮</T>
      //
      // @return 置底按钮<UL>
      //     		</UL>
      // @Date 5.25 新建 HANZH
      //============================================================================
      public function get tailButton():FBox{
         return _tailButton;
      }
      
      //============================================================================
      // <T>获取向下按钮</T>
      //
      // @return 向下按钮<UL>
      //     		</UL>
      // @Date 5.25 新建 HANZH
      //============================================================================
      public function get downButton():FBox{
         return _downButton;
      }
      
      //============================================================================
      // <T>获取置顶按钮</T>
      //
      // @return 向上按钮<UL>
      //     		</UL>
      // @Date 5.25 新建 HANZH
      //============================================================================
      public function get headButton():FBox{
         return _headButton;
      }
      
      //============================================================
      public function set scrollAlign(value:uint):void{
         _scrollAlign = value;
      }
      
      
      //============================================================================
      // <T>获取位置</T>
      //
      // @params name type 参数说明
      // @return 表示位置的SIntPoint对象 <UL>
      //     		</UL>
      // @Date 2010 新建 HYKUN
      //============================================================================
      public function set isScrollLeft(isleft:Boolean):void{
         _isScrollLeft = isleft;
      }
      
      //============================================================================
      // <T>设置背景色</T>
      //
      // @params name type 参数说明
      // @Date 2010 新建 HYKUN
      //============================================================================
      public function setBackgroundColor(color:uint, borderColor:uint, alpha:Number):void {
         _backgroundColor = color;
         _backgroundBorderColor = borderColor;
         _backgroundAlpha = alpha;
      }
      
      //============================================================================
      // <T>设置滚动条颜色</T>
      //
      // @params name type 参数说明
      // @Date 2010 新建 HYKUN
      //============================================================================
      public function setScrollColor(color:uint, alpha:Number):void {
         _scrollAlpha = alpha;
         _scrollColor = color;
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
      public function draw():void {
         var g:Graphics = graphics; 
         g.clear();
         // 绘制底层
         g.lineStyle(1, 0xD5F0F5);
         g.beginFill(_backgroundColor, 0.2);
         g.drawRoundRect(0, 0, size.width, size.height, 5, 5);
         g.endFill();
         // 绘制滑动区
         g.beginFill(_scrollColor);
         g.drawRoundRect(_xOffset, 30, _scrollWidth, size.height - 60, 5, 5);
         g.endFill();
         // 绘制边框
         var cg:Graphics = _mask.graphics; 
         cg.lineStyle(1, _backgroundBorderColor);
         cg.drawRoundRect(0, 0, size.width, size.height, 5, 5);
         // 绘制遮挡区
         cg.clear();
         cg.beginFill(0x000000);
         cg.drawRoundRect(0, 0, _xOffset - 1, size.height, 5, 5);
         cg.endFill();
         // 为内容添加遮罩
         //         _mask.graphics.clear();
         //         _mask.graphics.beginFill(0x000000);
         //         _mask.graphics.drawRect(0, 0, size.width, size.height);
         //         _mask.graphics.endFill();
         // 设置内容的位置
         //_content.y = -(_scrollButton.y / size.height) * _contentHeight;
      }
      
      //============================================================================
      // <T>鼠标按下时，开始拖动滚动条。</T>
      //
      //============================================================================
      private function onScrollDown(e:FEvent):void {
//         _logger.debug("onScrollDown","press the scrollButton({1})",e);
//         if(_scrollButton.y <= 30){
//            return;
//         }
         _isMouseDown = true;
         _scrollRectangle.left = _xOffset;
         _scrollRectangle.top = 30;
         _scrollRectangle.width = 0;
         _scrollRectangle.height = 140;
         _scrollButton.startDrag(false, _scrollRectangle);  
      }
      
      //============================================================================
      // <T>鼠标移动时，重新计算内容的位置，内容的移动应该与button的移动是反方向的。</T>
      //
      //============================================================================
      private function onScrollMove(e:MouseEvent):void {
         if(_isMouseDown){
            if(_scrollButton.y <= 30){
               _scrollButton.y = 30;
               _isMouseDown = false;
               stopDrag();
               return;
            }else if(_scrollButton.y >= 170-_scrollButton.height){
               _scrollButton.y = 170 - _scrollButton.height;
               _isMouseDown = false;
               stopDrag();
               return;
            }
            _content.y  = -_scrollButton.y/size.height*42*15;
         }
      }
      
      //============================================================================
      // <T>鼠标松开时，停止响应异动事件。</T>
      //
      //============================================================================
      private function onScrollUp(e:MouseEvent):void {
         _isMouseDown = false;
         _scrollButton.stopDrag();
      }
      
      public function resize(x:int, y:int):void {
         size.set(x,y);
         draw();
      }
      
      //============================================================================
      // <T>鼠标离开指定范围时，停止响应移动事件。</T>
      //
      //============================================================================
      private function onScrollLeave(e:MouseEvent):void {
         _isMouseDown = false;
         _scrollButton.stopDrag();
      }
      
//      //============================================================================
//      // <T>置顶事件</T>
//      //
//      // @params 点击事件
//      // @Date 5.26 新建 HANZH
//      //============================================================================
//      public function goTop(event:FEvent):void{
//         _scrollButton.y  = 32;
//         _content.y  = -_scrollButton.y/size.height*630;
//      }
//      
//      //============================================================================
//      // <T>置底事件</T>
//      //
//      // @params 点击事件
//      // @Date 5.26 新建 HANZH
//      //============================================================================
//      public function goTail(event:FEvent):void{
//         _scrollButton.y  = size.height - 30 - _scrollButton.height;
//         _content.y  = -_scrollButton.y/size.height*630;
//      }
//      
//      //============================================================================
//      // <T>向下按钮事件</T>
//      //
//      // @params 点击事件
//      // @Date 5.26 新建 HANZH
//      //============================================================================
//      public function up(event:FEvent):void{
//         if(_scrollButton.y >= 34){
//         _scrollButton.y  -=5;     
//         _content.y  = -_scrollButton.y/size.height*630;
//         //_content.y += 15;
//         }
//      }     
//      
//      //============================================================================
//      // <T>向上按钮事件</T>
//      //
//      // @params 点击事件
//      // @Date 5.26 新建 HANZH
//      //============================================================================
//      public function down(event:FEvent):void{
//         if(_scrollButton.y <= size.height - 30 - _scrollButton.height){
//         _scrollButton.y +=5;     
//        // _content.y  = -_scrollButton.y/size.height*630;
//         _content.y += 15;
//         }
//      }
//      
//      //============================================================================
//      // <T>下移一条消息的距离</T>
//      //
//      // @Date 5.26 新建 HANZH
//      //============================================================================
//      public function scrollDown():void{
//         _content.y -= 15;
//      }
   }
}