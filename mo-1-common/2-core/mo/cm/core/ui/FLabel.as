package mo.cm.core.ui
{
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   import mo.cm.xml.FXmlNode;
   
   //===========================================================
   // <T>文本标签控件。</T>
   //===========================================================
   public class FLabel extends FControl{
      
      protected var _sprite:FSprite = new FSprite();
      
      protected var _label:TextField = new TextField();
      
      protected var _labelFormat:TextFormat = new TextFormat();
      
      //============================================================
      public function FLabel(labelString:String = null, name:String=null)
      {
         super(name);
         display = _sprite;
         if(null != labelString){
            _label.text = labelString;
         }
         construct();
         _sprite.buttonMode = true;
         _sprite.useHandCursor = true;
      }
      
      //============================================================
      public override function construct():void{
         super.construct();
         //_label.defaultTextFormat = RStyle.LabelMidleFormat;
         _label.background = false;
         _label.wordWrap = true;
         _label.border = false;
         _label.selectable = false;
         _label.width = 60;
         _label.height = RStyle.ControlHeight;
         _label.textColor = 0x000000;
         _sprite.addChild(_label);
      }
      
      //============================================================
      public function get label():TextField{
         return _label;
      }
      
      //============================================================
      public function set textColor(color:uint):void{
         _label.textColor = color;
      }
      
      //============================================================
      public function set labelWidth(width:int):void{
         _label.width = width;
      }
      
      //============================================================
      public function set labelHeight(height:int):void{
         _label.height = height;
      }
      
      //============================================================
      public function set value(value:String):void{
         _label.text = value;
      }
      
      //============================================================
      public function get value():String{
         return _label.text;
      }
      
      //============================================================
      public function setLabelColor(color:uint=0x00ffffff):void{
         _label.background = true;
         _label.backgroundColor = color;
      }
      
      //============================================================
      public function setTextColor(color:uint=0x00ffffff):void{
         _label.textColor = color;
      }
      
      //============================================================
      public function setValueFormat(format:TextFormat, beginIndex:int = -1, endIndex:int = -1):void{
         _label.setTextFormat(format, beginIndex, endIndex);
      }
      
      //============================================================
      public function appendText(newText:String):void{
         _label.appendText(newText);
      }
      
      //============================================================
      public function replaceText(beginIndex:int, endIndex:int, newText:String):void{
         _label.replaceText(beginIndex, endIndex, newText);
      }
      
      //============================================================
      public function setDefaultFormat(format:TextFormat):void{
         _label.condenseWhite = true;
         _label.setTextFormat(format);
      }
      
      //============================================================
      // 加载配置文件
      public override function loadConfig(node:FXmlNode):void{
         //         position.parse(config.get("position"));
         //         size.parse(config.get("size"));
         //         var noId:int = config.getAsInt("");
         var messagesize : String = node.get("size");
         labelWidth = messagesize.split(',')[0];
         labelHeight = messagesize.split(',')[1];
         var messageposition : String = node.get("position");
         var messagepositionX :Number = messageposition.split(',')[0]; 
         var messagepositionY :Number = messageposition.split(',')[1];
         setPosition(messagepositionX,messagepositionY);
         value = node.get("default");
      }
   }
}