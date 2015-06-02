package mo.cm.core.ui
{
   import flash.display.Graphics;
   import flash.text.TextField;
   
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;

   //============================================================
   public class FProgressBar extends FControl{
      protected var _width:uint;
      
      protected var _height:uint;
      
      protected var _groundColor:uint;
      
      protected var _fillColor:uint;
      
      protected var _text:TextField = new TextField();
      
      //============================================================
      public function FProgressBar(g:Graphics, width:uint = 200, height:uint = 15, groundColor:uint = 0x000000ff, fillColor:uint = 0x00ff0000, name:String = null){
         super(name);
         display = _text;
         canvas = RAllocator.create(FGraphics);
         canvas.graphics = g;
         setValue(width, height, groundColor, fillColor);
      }
      
      //============================================================
      public function setValue(width:uint = 200, height:uint = 15, groundColor:uint = 0x000000ff, fillColor:uint = 0x00ff0000):void{
         _width = width;
         _height = height;
         _groundColor = groundColor;
         _fillColor = fillColor;
         setTextFormat();
         setTextPosition();
      }
      
      //============================================================
      public function begin(cent:uint):void{
         _text.text = " " + int(cent/100) + "%";
         canvas.fillRectangle(position.x - 1, position.y, position.x + _width, position.y + _height, _groundColor);
         canvas.fillRectangle(position.x, position.y + 1, position.x + (cent/10000)*_width - 1, position.y + _height - 1, _fillColor);
      }
      
      //============================================================
      private function setTextPosition():void{
         _text.x = position.x;
         _text.y = position.y;
      }
      
      //============================================================
      private function setTextFormat():void{
         _text.border = false;
         _text.width = _width;
         _text.height = _height;
         _text.textColor = 0x00ff00;
         _text.defaultTextFormat = RStyle.LabelMidleFormat;
      }
      
      //============================================================
      // 加载配置文件
      public override function loadConfig(config:FXmlNode):void{
         position.parse(config.get("position"));
         size.parse(config.get("size"));
         var noId:int = config.getInt("");
      }
      
      //============================================================
      public function set width(width:uint):void{
         _width = width;
      }
      
      //============================================================
      public function set height(height:uint):void{
         _height = height;
      }
   }
}