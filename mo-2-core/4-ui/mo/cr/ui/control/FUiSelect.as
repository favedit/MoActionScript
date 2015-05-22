package mo.cr.ui.control
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FMap;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.RCrConsole;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FItemEvent;
   import mo.cr.ui.FScrollEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.RGmStyle;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.layout.FUiScrollBar;
   import mo.cr.ui.layout.FUiScrollBox;
   
   //==========================================================
   // <T> 下拉框</T>
   //
   // @author HECNG 20120320
   //==========================================================
   public class FUiSelect extends FUiControl3d
   {
      // 数据
      public var items:Vector.<FUiListItem> = new Vector.<FUiListItem>();
      
      // 背景图id
      public var groundRid:int;
      
      // 按钮id
      public var buttonRid:int;
      
      // 按钮背景
      protected var backpic:FCrPictureResource;
      
      // 下拉按钮图片
      protected var downpic:FCrPictureResource;
      
      // 下拉图片按钮
      protected var downSprite:Sprite = new Sprite();
      
      // 按钮背景图
      protected var backshape:Shape = new Shape();
      
      // 显示精灵
      protected var contentContainer:FSprite = new FSprite();
      
      // 显示行数
      public var rowCount:int = 5; 
      
      // 一行数据的默认高度；
      public var itemHeight:int = 22;
      
      // 显示文本
      private var text:TextField = new TextField();
      
      // 选中项
      public var selectedItem:FUiListItem;
      
      // 选中文本
      public var selectedLabel:String;
      
      // 选中项索引
      public var selectedIndex:int;
      
      // 边框
      public var scrollbox:FUiScrollBox = new FUiScrollBox();
      
      // 触发事件
      public var eventName:String;
      
      protected var context:FUiContext;
      
      //===========================================================
      // <T>构造函数</T>
      // @author HECNG 20120320
      //===========================================================
      public function FUiSelect(){ 
         type = EUiControlType.Select;
         display = contentContainer;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
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
      // <T>添加数据</T>
      //
      // @params i:FUiListItem 数据
      // @author HECNG 20120320
      //===========================================================
      public function addItem(i:FUiListItem):void{
         items.push(i);
         i.itemFlistener.register(itemClick, this);                                                                                                                             
         scrollbox.addChild(i.display);
      }
      
      //===========================================================
      // <T>添加完成数据后掉用此函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function endUpdate():void{
         updatePostion();
         scrollbox.paint();
      }
      
      //===========================================================
      // <T>更新显示列表坐标</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function updatePostion():void{
         var length:int = items.length;
         for(var i:int = 0; i < length; i++){
            var f:FUiListItem = items[i];
            f.setLocation(0, i * itemHeight);
         }
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function paint(p:FUiContext=null):void{
         if(ready){
            graphics(backshape.graphics, size.width, size.height, backpic.bitmapData);
            var b:BitmapData = downpic.bitmapData;
            graphics(downSprite.graphics, b.width, b.height, b);
            scrollbox.size.set(size.width, rowCount * itemHeight);
            scrollbox.paint();
            setpostion();
         } 
      }
      
      //============================================================
      // <T>设置文本。</T>
      //
      // @author HECNG 20120302
      //============================================================
      private function setlabel():void{
         text.selectable = false;
         text.wordWrap = false;
         text.mouseEnabled = false;
         text.width = size.width;
         text.height = size.height;
         text.autoSize = TextFieldAutoSize.CENTER;
      }
      
      //============================================================
      // <T>鼠标点击数据项</T>
      //
      // @author HECNG 20120320
      //============================================================
      private function itemClick(e:FItemEvent):void{
         var f:FUiListTextItem = e.item as FUiListTextItem;
         selectedItem = f;
         selectedIndex = findIndex(f);
         text.text = f.text;
         mouseClick();
         var form:FUiForm = this.findParent(FUiForm);
         var evet:FItemEvent = new FItemEvent();
         evet.sender = this;
         evet.item = f;
         var d:Object = form.eventDispatcher;
         var m:Function = d[eventName];
         m.call(d, evet);
      }
      
      //============================================================
      // <T>查询当前列的索引</T>
      //
      // @params f:FUiListItem 数据项
      // @author HECNG 20120320
      //============================================================
      private function findIndex(f:FUiListItem):int{
         return items.indexOf(f);
      }
      
      //============================================================
      // <T>遍历项执行函数</T>
      //
      // @author HECNG 20120321
      //============================================================
      private function itemProcess(p:FUiContext):void{
         var l:int = items.length;
         for(var i:int = 0; i < l; i++){
            items[i].process(p)
         }
      }
      
      //============================================================
      // <T>设置显示元素坐标。</T>
      //
      // @author HECNG 20120320
      //============================================================
      protected function setpostion():void{
         backshape.x = backshape.y = downSprite.y = 0;
         downSprite.x = size.width - downSprite.width;
         scrollbox.setLoaction(0, size.height);
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @params g:Graphic 绘制对象
      // @params w:int, h:int 宽高
      // @params d:BitmapData 图形数据
      // @author HECNG 20120320
      //============================================================
      private function graphics(g:Graphics, w:int, h:int, d:BitmapData):void{
         g.clear();
         g.beginBitmapFill(d);
         g.drawRect(0, 0, w, h);
         g.endFill();
      }
      
      //============================================================
      // <T>出事化组件</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function setup():void{
         contentContainer.addChild(backshape);
         contentContainer.addChild(downSprite);
         scrollbox.display.tag = this;
         contentContainer.addChild(scrollbox.display);
         contentContainer.addChild(text);
         setlabel();
         scrollbox.display.visible = false;
         downSprite.addEventListener(MouseEvent.CLICK, mouseClick);
         downSprite.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
         downSprite.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
         scrollbox.setup();
      }
      
      //============================================================
      // <T>鼠标点击</T>
      //
      // @author HECNG 20120320
      //============================================================
      private var isDisplay:Boolean;
      protected function mouseClick(e:MouseEvent = null):void{
         isDisplay = !isDisplay;  
         scrollbox.display.visible = isDisplay;
      }
      
      //============================================================
      // <T>鼠标离开</T>
      //
      // @author HECNG 20120320
      //============================================================
      protected function mouseOut(e:MouseEvent):void{
         downSprite.filters = [];
      }
      
      //============================================================
      // <T>鼠标划过</T>
      //
      // @author HECNG 20120320
      //============================================================
      protected function mouseOver(e:MouseEvent):void{
         downSprite.filters = [RGmStyle.ButtonGlowFilter, RGmStyle.DropEmptyFilter];
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120320
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         groundRid = p.getInt("ground_rid");
         buttonRid = p.getInt("down_rid");
         rowCount = p.getInt("row_count");
         itemHeight = p.getInt("item_height");
         eventName = p.get("onselect");
         var xb:FXmlNode = p.findNode(EUiControlType.ScrollBox);
         if(xb){
            scrollbox.loadConfig(xb);
         }
         setup();
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120320
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid", groundRid.toString());
         p.set("down_rid", buttonRid.toString());
         p.set("row_count", rowCount.toString());
         p.set("item_height", itemHeight.toString());
         p.set("onselect", eventName);
         var xb:FXmlNode = p.create(EUiControlType.ScrollBox);
         scrollbox.saveConfig(xb);
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         backpic = null;
         downpic = null;
         scrollbox.setupEnd();
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>数据是否加载完成。</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function testReady():Boolean{
         if(backpic && downpic){
            if(backpic.ready && downpic.ready){
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         scrollbox.process();
         itemProcess(p);
         if(groundRid && !backpic){
            backpic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
         }
         if(buttonRid && !downpic){
            downpic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, buttonRid.toString());
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
      // <T>清楚数据</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function clear():void{
         items.length = 0;
         scrollbox.clear();
      }
   }
}