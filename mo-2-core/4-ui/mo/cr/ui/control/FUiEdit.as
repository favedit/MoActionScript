package mo.cr.ui.control
{
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   
   //==========================================================
   // <T> 编辑文本框</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiEdit extends FUiControl3d
   {
      public var containerDisplay:FSprite = new FSprite();
      
      // 图片id
      public var groundRid:int;
      
      // 背景图片
      private var _backgroundPic:FCrPictureResource;
      
      // 文本对象
      public var _tf:TextField = new TextField();
      
      // 输入文本
      private var _text:String = "";
      
      // 是否可以编辑
      public var _editable:Boolean = true;
      
      // 是否选中
      public var _selectable:Boolean = true;
      
      // 字体样式
      public var _format:TextFormat;
      
      // 文本框输入模式
      public var isPassword:Boolean = false;
      
      public var textFormat:TextFormat = new TextFormat();
      
      // 是否启用正则
      public var isRegExp:Boolean = false;
      
      // 字数上线
      public var limlint:int = 1000;
      
      public var _lsnsChange:FListeners;
      
      //===========================================================
      // <T> 构造函数。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function FUiEdit(){
         this.type = EUiControlType.Edit;
         this.display = containerDisplay;
         containerDisplay.tag = this;
         controls = new Vector.<FUiControl3d>();
         setFont(12, 0xffffff);
      }
      
      //============================================================
      // <T>注册一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function registerChange(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == _lsnsChange){
            _lsnsChange = new FListeners(this);
         }
         return _lsnsChange.register(pm, po, pc);
      }
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function mouseEnable(bool:Boolean):void{
         containerDisplay.mouseChildren = bool;
         containerDisplay.mouseEnabled = bool;
      }
      
      //===========================================================
      // <T> 初始化背景 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function setup():void{
         containerDisplay.addChild(_tf);
         containerDisplay.buttonMode = false;
         _tf.type = TextFieldType.INPUT;
         _tf.addEventListener(Event.CHANGE, onChange);
         _tf.addEventListener(TextEvent.TEXT_INPUT, onInput);
         _tf.height = size.height;
         _tf.width = size.width; 
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         groundRid = p.getUint("ground_rid");
         setFont(p.getInt("label_size"), p.getUint("font_color"), p.get("font_family"));
         isPassword = p.getBoolean("ispassword");
         isRegExp = p.getBoolean("isregexp");
         if(isRegExp){
            _tf.restrict = "0-9";
         }
         _tf.displayAsPassword = isPassword;
         if(label){
            text = label;
         }
         setup();
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid",  groundRid.toString());
         p.set("label_size",  textFormat.size.toString());
         p.set("font_color",  textFormat.color.toString());
         p.set("font_family",  textFormat.font.toString());
         p.set("ispassword", isPassword.toString());
         p.set("isregexp", isRegExp.toString());
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         _backgroundPic = null;
         ready = false;
         dirty = false;
      }
      
      //===========================================================
      // <T> 文本框内容发生变化。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function onInput(e:TextEvent):void{
//         _tf.defaultTextFormat = textFormat;
      }
      
      //===========================================================
      // <T> 文本框内容发生变化。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      private function onChange(e:Event):void{
         if(_tf.text.length <= limlint){
            _text = _tf.text;
            _tf.text = _text;
            if(null != _lsnsChange){
               var ec:FEvent = new FEvent(e, this);
               ec.tag = _text;
               _lsnsChange.process(ec);
               ec.dispose();
            }
         }else{
            _tf.text = _text;
         }
         _tf.setTextFormat(textFormat);
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function process(p:FUiContext):void{
         if(groundRid && !_backgroundPic){
            _backgroundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
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
      // <T>设置字体的宽高大小</T>
      //
      // @param size:int 文本字体大小
      // @param color:uint 文本颜色
      // @param fontFaimly:string 字体
      // @author HECNG 20120227
      //============================================================
      public function setFont(size:int, color:uint, fontFamily:String = "SimSun"):void{
         textFormat.size = size;
         textFormat.color = 0xffffff;
         textFormat.font = fontFamily;
      }
      
      //============================================================
      // <T>清空文本框</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function clear():void{
         _tf.text = "";
         _text = "";
      }
      
      //============================================================
      // <T>资源是否加载完成</T>
      //
      // @return 资源是否加载完成
      // @author HECNG 20120227
      //============================================================
      public override function testReady():Boolean{
         if(_backgroundPic){
            ready = _backgroundPic.ready;
         }
         return ready;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function paint(p:FUiContext = null):void{
         // 绘制底框
         var g:Graphics = containerDisplay.graphics;
         g.clear();
         g.beginBitmapFill(_backgroundPic.bitmapData);
         g.drawRect(0, 0, size.width, size.height);
         g.endFill();
      }
      
      //===========================================================
      // <T> 获取文本输入内容。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function get text():String{
         return _text;
      }
      
      //===========================================================
      // <T> 获取文本输入内容。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function set text(str:String):void{
         _text = str;
         _tf.text = str;
         _tf.setTextFormat(textFormat);
      }
   }
}