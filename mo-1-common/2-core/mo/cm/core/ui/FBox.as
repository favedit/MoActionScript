package mo.cm.core.ui
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.text.TextField;
   
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   //==========================================================
   // <T>按钮控件类</T>
   // @class [FContorl]
   // @author HANZH
   // @Date 5月14日
   // @version 1.0.1
   //==========================================================
   public class FBox extends FControl
   {
      // @structure 结构变量
      //============================================================
      // @structure 绘制精灵
      protected var _sprite:FSprite = new FSprite();
      // @structure 背景图
      protected var _bitmap:Bitmap = new Bitmap();
      // @structure 加载器
      protected var _loader:Loader = new Loader();
      // @structure 标签
      protected var _labelText:TextField = new TextField();
      
      //============================================================
      // @listener 监听器
      //============================================================
      // @listener 监听enter键按下事件
      protected var _lsnClick:FListeners = RAllocator.create(FListeners);

      //============================================================
      public function FBox()
      {
         super(name);
         display = _sprite;
         _sprite.addEventListener(MouseEvent.CLICK, onClick);

      }
      
      //==========================================================
      // <T>组建</T>
      //
      // @ Date date name 5.31新建  HANZH
      //==========================================================
      public override function setup():void{
         _sprite.addChild(_labelText);
         _labelText.width = size.width;
         _labelText.height = size.height;
         _labelText.setTextFormat(RStyle.TextFieldFormat);
         
      }
      
      //==========================================================
      // <T>获取FListeners</T>
      // @ Date date name 5月14日 新建  HANZH
      //==========================================================
      public function get lsnClick():FListeners{
         if(null == _lsnClick){
            _lsnClick = RAllocator.create(FListeners);
            _lsnClick.sender = this;
         }
         return _lsnClick;
      }
      
      //==========================================================
      // <T>设置标签</T>
      //
      // @ params 标签内容
      // @ Date date name 5.31 新建  HANZH
      //==========================================================
      public function get labelText():String{
         return _labelText.text;
      }
      
      //==========================================================
      // <T>设置标签</T>
      //
      // @ params 标签内容
      // @ Date date name 5.31 新建  HANZH
      //==========================================================
      public function set labelText(label:String):void{
         _labelText.text = label;
     
      }
      
      //==========================================================
      public function onComplete(enent:Event):void{		
         _bitmap = Bitmap(_loader.content);		
         _sprite.addChild(_bitmap);						
         
      }
      
      //============================================================
      public override function draw():void{
         var s:Graphics = _sprite.graphics;
         s.beginBitmapFill(_bitmap.bitmapData);
         s.drawRect(0,0,size.width,size.height);
         s.endFill();
      }
      
      //============================================================
      public function onClick(event:MouseEvent):void{
         var fevent:FEvent = RAllocator.create(FEvent);
         fevent.event = event;
         fevent.sender = this;
         _lsnClick.process(fevent);
      }
      
      //============================================================
      public function onResourceLoaded(event:Event):void{
         _bitmap = LoaderInfo(event.target).content as Bitmap;
         draw();
      }
      
      //============================================================
      // 加载配置文件
      public function loadPath(path:String):void{
         _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onResourceLoaded);
         _loader.load(new URLRequest(path));
      }
      
      //============================================================
      public function setSize(width:int,height:int):void{
         size.width = width;
         size.height = height;
      }

   }
}