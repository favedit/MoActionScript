package mo.cm.core.ui
{
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.system.FEvent;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>按键控件。</T>
   //============================================================
   public class FButton extends FControl
   {
      protected var colormatrix:Matrix = new Matrix();
      
      protected var colorarray:Array = new Array();
      
      protected var _sprite:FSprite = new FSprite();
      
      protected var _button:TextField = new TextField();
      
      //============================================================
      public function FButton(name:String = null){
         super(name);
         display = _sprite;
         construct();
      }
      
      //============================================================
      public override function construct():void{
         super.construct();
         // 为按钮添加事件
         _sprite.addEventListener(MouseEvent.CLICK, onButtonClick);
      }
      
      //============================================================
      public function setButtonSize(width:int = 30, height:int = 20):void{
         _button.width = width;
         _button.height = height;
      }
      
      //============================================================
      public function setCaptionPosition(x:int = 5, y:int = 5):void{
      }
      
      //============================================================
      // 渐变样式填充
      public function refresh():void{
         _button.defaultTextFormat = RStyle.LabelMidleFormat;
         _button.selectable = false;
         _button.wordWrap = false;
         _button.mouseEnabled = false;
         _button.width = size.width;
         _button.height = RStyle.ControlHeight;
         _sprite.addChild(_button);
         _button.autoSize = TextFieldAutoSize.CENTER;
         //colorarray = [0,148,148,255];
         //colormatrix.createGradientBox(_sprite.width,_sprite.height,Math.PI/2,0,0);
         _sprite.buttonMode = true;
         _sprite.graphics.lineStyle(2,0xffffff);
         _sprite.graphics.beginFill(0xcccccc);
         _sprite.graphics.drawRoundRect(0, 0, size.width-2, size.height-2, 5, 5);
         _sprite.graphics.endFill();
      }
      
      //============================================================
      // 位图填充
      public function setButtonImageStyle(bimap:BitmapData):void{
         _sprite.buttonMode = true;
         _sprite.graphics.beginBitmapFill(bimap, null, true);
         _sprite.graphics.drawRoundRect(4,4,_sprite.width-2,_sprite.height-2,3,3);
         _sprite.graphics.endFill();
      }
      
      //============================================================
      public function onButtonClick(e:MouseEvent):void{
         if(null != lsnsClick){
            var ec:FEvent = RAllocator.create(FEvent);
            ec.event = e;
            lsnsClick.process(ec);
            ec.dispose();
         }
      }
      //============================================================
      public function get label():String{
         return _button.text;
      }
      
      //============================================================
      public function set label(value:String):void{
         _button.text = value;
      }
      
      //============================================================
      public function setBtnPosition(x:int, y:int):void{
         setPosition(x, y);
      }
      
      //============================================================
      public function setBtnSize(width:int, height:int):void{
         size.width = width;
         size.height = height;
      }
      
      //============================================================
      public override function loadConfig(node:FXmlNode):void{
         label = node.get("label");
         var _btnSubmitPosition : String = node.get("position");
         var _btnSubmitPositionX : Number = _btnSubmitPosition.split(',')[0];
         var _btnSubmitPositionY : Number = _btnSubmitPosition.split(',')[1];
         size.parse(node.get("size"));
         setPosition(_btnSubmitPositionX, _btnSubmitPositionY);
         refresh();
      }
   }
}