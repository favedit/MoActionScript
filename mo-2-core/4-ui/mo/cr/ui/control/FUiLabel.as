package mo.cr.ui.control
{
   import flash.display.Graphics;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.RGmStyle;
   import mo.cr.ui.RUiUtil;
   
   //==========================================================
   // <T> 文本</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiLabel extends FUiControl3d
   {
      public static var Center:String = TextFieldAutoSize.CENTER;
      
      public static var Left:String = TextFieldAutoSize.LEFT;
      
      public static var None:String = TextFieldAutoSize.NONE;
      
      public static var Right:String = TextFieldAutoSize.RIGHT;
      
      // 显示文本
      public var content:TextField = new TextField();
      
      // 容器
      public var contentContainer:FSprite;
      
      // 背景图编号
      public var groundRid:int;
      
      // 背景图片
      public var groundPic:FCrPictureResource;
      
      // 是否支持多行文本
      public var _multiline:Boolean = false;
      
      // 样式名称
      private var _styleNname:String;
      
      //
      public var context:FUiContext;
      
      // 内容文本
      public var labelText:String = "";
      
      // 样式
      public var tf:TextFormat = new TextFormat();
      
      // 样式文本
      public var text_Format:String = "[FONT color='#FFFFFF']{1}[/FONT]";
      
      public var isMark:Boolean = false;
      
      //===========================================================
      // <T> 构造函数。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function FUiLabel(){
         type = EUiControlType.Label;
         contentContainer = new FSprite();
         contentContainer.mouseEnabled = false;
         contentContainer.tag = this;
         display = contentContainer;
         //controls = new Vector.<FUiControl3d>();
      }
      
      public function get styleNname():String{
         return _styleNname;
      }
      
      public function set styleNname(value:String):void{
         _styleNname = value;
      }

      
      //===========================================================
      // <T> 设置文字。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         textAlign = p.get("autosize");
         groundRid = p.getUint("ground_rid");
         text_Format = p.get("textformat", "[FONT color='#FFFFFF']{1}[/FONT]");
         htmlText(p.get("text"));
         styleNname = p.get("style_name");
         isMark = p.getBoolean("ismark");
         _multiline = p.getBoolean("multiline");
         setup();
      }
      
      public function updateMark():void{
         if(isMark){
            content.filters = [RGmStyle.SpriteHeroTextGlowFilter]; 
         }
      }
      
      //============================================================
      // <T>保存组件。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid", groundRid.toString());
         p.set("text", text);
         p.set("style_name", styleNname);
         p.set("textformat", text_Format);
         p.set("autosize", textAlign);
         p.set("ismark",  isMark.toString());
         p.set("multiline", _multiline.toString());
      }
      
      //===========================================================
      // <T>  对齐方式。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function set textAlign(str:String):void{
         if(str){
            tf.align = str; 
         }
      }
      
      //===========================================================
      // <T>  对齐方式。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function get textAlign():String{
         return tf.align;
      }
      
      //===========================================================
      // <T> 初始化 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function multiline(b:Boolean):void{
         content.multiline = b;
      }
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function mouseEnable(bool:Boolean):void{
         contentContainer.mouseChildren = bool;
         contentContainer.mouseEnabled = bool;
      }
      
      //===========================================================
      // <T> 初始化 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function setup():void{
         contentContainer.addChild(content);
         content.x = content.y = 0;
         content.width = size.width;
         content.height = size.height;
         content.multiline = _multiline;
         content.mouseEnabled = false;
         updateMark();
      }
      
      //===========================================================
      // <T> 绘制。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function paint(p:FUiContext=null):void{
         // 绘制底框
         var g:Graphics = contentContainer.graphics;
         g.clear();
         g.drawRect(0, 0, size.width, size.height);
         // 设置容器
         content.width = size.width;
         content.height = size.height;
         // 绘制位图
         if(groundPic){
            g.beginBitmapFill(groundPic.bitmapData);
            g.drawRect(0, 0, size.width, size.height);
            g.endFill();
         }
      }
      
      //===========================================================
      // <T> 设置文字。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function get text():String{
         return labelText;
      }
      
      //===========================================================
      // <T> 获取文字。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function set text(str:String):void{
         if(str){
            content.defaultTextFormat = tf;
            var t:String = text_Format.replace("{1}", str);
            if(t.length > 0){
               labelText = str;
               content.htmlText = RUiUtil.fromatHtml(t);
            }
         }
      }
      
      //===========================================================
      // <T> 追加文字。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function appendText(str:String):void{
         content.appendText(str);
      }
      
      //===========================================================
      // <T>设置文本大小。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function setSize(pw:Number, ph:Number):void{
         super.setSize(pw, ph);
         content.width = pw;
         content.height = ph;
      }
      
      //===========================================================
      // <T>设置Html文字。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function htmlText(p:String):void{
         content.defaultTextFormat = tf;
         content.multiline = true;
			labelText = p;
         var t:String = text_Format.replace("{1}",p);
         if(t.length > 0){
            if(_multiline){
               content.wordWrap = true;
               content.text = RUiUtil.fromatHtml(t);
            }else{
               content.htmlText = RUiUtil.fromatHtml(t);
            }
         }
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(groundRid){
            if(groundPic){
               ready = groundPic.ready;
            }
         }else{
            ready = true;
         }
         return ready;
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         groundPic = null;
         ready = false;
         dirty = false;
         paint();
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         // 准备数据
         if(groundRid && !groundPic){
            groundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
         }
         // 测试准备
         if(!ready){
            ready = testReady();
         }
         // 绘制处理
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
   }
}