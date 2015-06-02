package mo.cm.core.ui
{
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntRectangle;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FObject;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   public class FWindow extends FObject
   {
      public var location:SIntPoint2 = new SIntPoint2();
      
      public var size:SIntSize2 = new SIntSize2();
      
      protected var _sprite:FSprite = new FSprite();
      
      public var borderRound:int = 6;
      
      private var caption:TextField = new TextField();
      
      public var captionHeight:int = 8;
      
      public var bodyRectangle:SIntRectangle = new SIntRectangle();
      
      public var backgroundColor:uint;
      
      public var dragAble:Boolean = true;
      
      protected var _controls:FDictionary = RAllocator.create(FDictionary);
      
      protected var _loader:Loader = new Loader();
      
      private var _dropShadowFilter:DropShadowFilter = new DropShadowFilter();
      
      //============================================================
      public function FWindow(){
      }
      
      //============================================================

      public function get sprite():FSprite{
         return _sprite;
      }

      //============================================================
      public function setSize(width:int, height:int):void{
         size.set(width, height);
      }
      
      //============================================================
      public function get controls():FDictionary{
         return _controls;
      }
      
      //============================================================
      public function setLocation(x:int, y:int):void{
         _sprite.x = x;
         _sprite.y = y;
      }
      
      //============================================================
      protected function onMouseDown(event:MouseEvent):void{
         if(event.target == _sprite){
            if(dragAble){
               if(event.localY < captionHeight){
                  _sprite.filters =[_dropShadowFilter];
                  _sprite.parent.setChildIndex(_sprite, _sprite.parent.numChildren -1);
                  _sprite.startDrag();
               }
            }
         }
      }
      
      //============================================================
      protected function onMouseUp(event:MouseEvent):void{
         if(event.target == _sprite){
            if(dragAble){
               _sprite.stopDrag();
               _sprite.filters = [];
            }
         }
      }
      
      //============================================================
      protected function onClose(event:MouseEvent):void {
         _sprite.visible = false;
      }
      
      //============================================================
      public function push(control:FControl):void {
         _sprite.addChild(control.display);
         _controls.set(control.name, control);
      }
      
      //============================================================
      public function control(name:String):Object {
         return _controls.get(name);
      }
      
      //============================================================
      public function setCaptionText(title:String):void{
         caption.text = title;
      }
      
      //============================================================
      public function draw():void{
         var g:Graphics = _sprite.graphics;
         // 绘制标题
         g.beginFill(backgroundColor, 0.5);
         g.drawRoundRect(0, 0, size.width-1, captionHeight-1, borderRound, borderRound);
         g.endFill();
         // 绘制背景
         g.beginFill(backgroundColor, 0.3);
         g.drawRoundRect(0, 0, size.width-1, size.height-1, borderRound, borderRound);
         g.endFill();
         // 绘制边线
         g.lineStyle(2, 0x333333);
         g.drawRoundRect(0, 0, size.width-2, size.height-2, borderRound, borderRound);
      }
      
      //============================================================
      public function drawBitmap(bitmap:Bitmap):void{
         var g:Graphics = _sprite.graphics;
         // 绘制标题
         g.beginFill(backgroundColor, 0.5);
         g.drawRoundRect(0, 0, size.width-1, captionHeight-1, borderRound, borderRound);
         g.endFill();
         // 绘制背景
         g.beginBitmapFill(bitmap.bitmapData);
         g.drawRoundRect(0, 0, size.width-1, size.height-1, borderRound, borderRound);
         g.endFill();
         // 绘制边线
         g.lineStyle(2, 0x333333);
         g.drawRoundRect(0, 0, size.width-2, size.height-2, borderRound, borderRound);
      }
      
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         location.parse(config.get("location"));
         size.parse(config.get("size"));
         backgroundColor = config.getHexInt("bgcolor")
         // 绘制底板
         draw();
      }
      
      //============================================================
      public function setup():void{
         // 设置监听器
         _sprite.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
         _sprite.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
         // 设置位置
         _sprite.x = location.x;
         _sprite.y = location.y;
         // 设置数据
         bodyRectangle.left = 2;
         bodyRectangle.top = captionHeight;
         bodyRectangle.right = size.width - 2;
         bodyRectangle.bottom = size.height - 2;
         // 绘制底板
         draw();
      }
      
      //============================================================
      public function clear():void{
         // 设置监听器
         var g:Graphics = _sprite.graphics;
         g.clear();
      }
      
      //============================================================
      public function refresh():void{
         _sprite.x = location.x;
         _sprite.y = location.y;
         // 
         clear();
         draw();
      }
   }
}