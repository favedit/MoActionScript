package mo.cm.core.ui
{
   import flash.display.*;
   import flash.events.KeyboardEvent;
   import flash.text.*;
   import flash.ui.Keyboard;
   
   import mo.cm.geom.SIntSize2;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   public class FEdit extends FControl
   {
      //============================================================
      // @structure 结构变量
      //============================================================
      // @structure 绘制精灵
      protected var _sprite:FSprite = new FSprite();
      
      // @structure 标签文本对象
      protected var _label:TextField = new TextField();
      
      // @structure 编辑文本对象
      protected var _edit:TextField = new TextField();
      
      // @structure 标签样式
      protected var _labelFormat:TextFormat = new TextFormat();
      
      // @structure 编辑样式
      protected var _editFormat:TextFormat = new TextFormat();
      
      //============================================================
      // @property 属性变量
      //============================================================
      // @property 标签大小
      protected var _labelValue:String;
      
      // @property 标签大小
      protected var _labelSize:SIntSize2 = new SIntSize2();
      
      // @property 编辑大小
      protected var _editSize:SIntSize2 = new SIntSize2();
      
      // @property 编辑框背景色
      protected var _editBgColor:uint = 0xffffff;
      
      // @property 编辑框背景色
      protected var _editBorderColor:uint = 0xffffff;
      
      // @property 编辑框字体颜色
      protected var _editFontColor:uint = 0xffffff;
      
      // @property 编辑框字体颜色
      protected var _labelFontColor:uint = 0xffffff;
      
      // @property 编辑框背景色
      protected var _editFontSize:uint;
      
      // @property 编辑框背景色
      protected var _hideLabel:Boolean;
      
      //============================================================
      // @listener 监听器
      //============================================================
      // @listener 监听enter键按下事件
      protected var _lsnEnterDown:FListeners = RAllocator.create(FListeners);
      
      //============================================================
      // <T>构造函数.</T>
      //
      // @params label
      //============================================================
      public function FEdit(name:String = null, label:String = null){
         super(name);
         display = _sprite;
         setLabel(label);
      }
      
      //============================================================
      public function get edit():TextField{
         return _edit;
      }
      
      //============================================================
      public function setLabel(label:String = null):void{
         _labelValue = label;
         _labelFormat = RStyle.LabelMidleFormat;
         _editFormat = RStyle.EditFormat;
         _edit.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
      }
      
      //============================================================
      // <T>结构化控件。</T>
      //
      //============================================================
      public override function setup():void{
         // 创建标签部分,labelName是标签名
         buildLabel();
         // 创建输入部分,labelString是编辑框默认文字
         buildEdit();
         _sprite.addChild(_label);
         _sprite.addChild(_edit);
         if(_hideLabel){
            _label.visible = false;
            _edit.x = 0;
         }
      }
      
      //============================================================
      // <T>创建标签部分。</T>
      //
      //============================================================
      public function buildLabel():void{
         _label.type = TextFieldType.DYNAMIC;
         if(null != _labelValue){
            _label.text = _labelValue;
         }
         // 样式 
         _label.defaultTextFormat = _labelFormat;
         _label.selectable = false;
         _label.x = 0;
         _label.y = 0;
         _label.width = _labelSize.width;
         _label.height = _labelSize.height;
         _label.textColor = _labelFontColor;
      }
      
      //============================================================
      public function buildEdit(labelString:String = null):void{
         _edit.type = TextFieldType.INPUT;
         if(null != labelString){
            _edit.text = labelString;
         }
         // 样式
         _edit.defaultTextFormat = _editFormat;
         _edit.border = true;
         // 位置
         _edit.x = _labelSize.width + RStyle.ControlPadding;
         _edit.y = 0;
         // 大小及背景
         _edit.width = _editSize.width;
         _edit.height = _editSize.height;
         _edit.background = true;
         _edit.backgroundColor = _editBgColor;
         _edit.textColor = _editFontColor;
      }
      
      //============================================================      
      public function get labelSize():SIntSize2{
         return _labelSize;
      }
      
      //============================================================      
      public function get editSize():SIntSize2{
         return _editSize;
      }
      
      //============================================================
      public function set label(value:String):void{
         _label.text = value;
      }
      
      //============================================================
      public function get value():String{
         return _edit.text;
      }
      
      //============================================================
      public function set value(value:String):void{
         _edit.text = value;
      }
      
      //============================================================
      public function set editBgColor(value:uint):void{
         _editBgColor = value;
      }
      
      //============================================================
      public function editFontColor(color:uint=0x00000000):void{
         _editFontColor = color;
      }
      
      //============================================================
      public function get editFontSize():uint{
         return _editFontSize;
      }
      
      //============================================================
      public function set editFontSize(value:uint):void{
         _editFontSize = value;
      }
      
      //==========================================================
      // <T>获取FListeners</T>
      // 
      // @ Date 5.20  新建  HANZH
      //==========================================================
      public function get lsnEnterDown():FListeners{
         if(null == _lsnEnterDown){
            _lsnEnterDown = RAllocator.create(FListeners);
            _lsnEnterDown.sender = this;
         }
         return _lsnEnterDown;
      }
      
      //============================================================
      public function onKeyDown(event:KeyboardEvent):void{
         if(event.keyCode == Keyboard.ENTER){
            var fevent:FEvent = RAllocator.create(FEvent);
            fevent.event = event;
            _lsnEnterDown.process(fevent);
         }
      }
      
      //============================================================
      public override function loadConfig(node:FXmlNode):void{
         label = node.get("label");
         _labelSize.parse(node.get("label_size"));
         _editSize.parse(node.get("edit_size"));
         _hideLabel = node.getBoolean("hide_label");
         _editFontColor = node.getHexInt("font_color");
         _editBgColor = node.getHexInt("bg_color");
         position.parse(node.get("position"));
         _sprite.x = position.x;
         _sprite.y = position.y;
      }
      
      //============================================================
      // <T>编辑框最大字符数值。</T>
      //============================================================
      public function setEditMaxChar(maxChar:uint):void{
         _edit.maxChars = maxChar;
      }
   }
}