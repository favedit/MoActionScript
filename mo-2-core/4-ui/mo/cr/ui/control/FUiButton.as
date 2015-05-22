package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RTimer;
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.IhintAble;
   import mo.cr.ui.RGmStyle;
   import mo.cr.ui.RUiUtil;
   import mo.cr.ui.common.FUiPlayer;
   import mo.cr.ui.common.SUiPlayerAction;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.layout.FUiBorder;
   
   //==========================================================
   // <T> 普通按钮</T>
   //
   // @author HECNG 20120302
   //==========================================================
   public class FUiButton extends FUiControl3d implements IhintAble
   {
      // 鼠标按下
      public static const MOUSE_DOWN:int = 0;
      
      // 鼠标弹起
      public static const MOUSE_UP:int = 1;
      
      // 鼠标划过
      public static const MOUSE_OVER:int = 2;
      
      // 鼠标离开
      public static const MOUSE_OUT:int = 3;
      
      // 状态有效
      public var statusEnable:Boolean = true;
      
      // 显示精灵
      public var contentContainer:FSprite = new FSprite();
      
      // 边框
      public var _border:FUiBorder = new FUiBorder();
      
      // 背景图容器
      public var backgroundBit:Bitmap = new Bitmap();
      
      // 按钮文字
      public var text:TextField = new TextField();
      
      // 激活图片id
      public var activatedRid:int;
      
      // 未激活图片id
      public var activateRid:int;
      
      // 激活图片
      public var activatedPic:FCrPictureResource;
      
      // 为激活图片
      public var activatePic:FCrPictureResource;
      
      // 点击事件名称
      public var eventMouseClick:String;
      
      // 弹起事件名称
      public var eventMouseUp:String;
      
      // 按下事件名称
      public var eventMouseDown:String;
      
      // 划过事件名称
      public var eventMouseOver:String;
      
      // 动画资源编号
      public var movieRid:String;
      
      // 离开事件名称
      public var eventMouseOut:String;
      
      // 是否显示边框
      public var isBorder:Boolean;
      
      // 鼠标状态
      public var buttonState:int = MOUSE_OUT;
      
      // 是否激活(默认为激活模式)
      private var _activated:Boolean = true;
      
      // 是否启动滤镜
      public var isFilters:Boolean = true;
      
      // 对齐方式
      public var align:String = "left.top";
      
      public var clickFlistener:FListeners = new FListeners();
      
      public var dock:String;
      
      private var context:FUiContext;
		
	  private var time:Number = 0;
		
      public var click_interval:int = 0;
      
      // 动画播放器
      public var player:FUiPlayer = new FUiPlayer();
      
      // 在闲置不动的情况下一直播放动画
      public var isAllwaysPlay:Boolean = false;
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function FUiButton(){
         this.type = EUiControlType.Button;
         controls = new Vector.<FUiControl3d>();
         display = contentContainer;
         contentContainer.tag = this;
      }
      
      //============================================================
      // <T>动画播放。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function playMovie():void{
         if(movieRid && _activated){
            backgroundBit.visible = false;
            player.play(new SUiPlayerAction("loop",movieRid, 1, 1));
         }
      }
      
      //============================================================
      // <T>是否显示说明文本。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function isHintAble():Boolean{
         return isHite;
      }
      
      //============================================================
      // <T>获取说明文本。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function get hintText():String{
         return hite;
      }
      
      //============================================================
      // <T>获取激活状态。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function get activated():Boolean{
         return _activated;
      }
      
      //============================================================
      // <T>设置激活状态。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function set activated(value:Boolean):void{
         _activated = value;
         if(ready){
            paint();
         }
      }
      
      //============================================================
      // <T>设置激活状态。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function setDisable(p:Boolean):void{
         statusEnable = p;
         contentContainer.filters = p ? [RGmStyle.ValidGrayFilter] : [];
      }
      
      //============================================================
      // <T>鼠标点下。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function onMouseDown(event:MouseEvent = null):void{
         sendEvent(eventMouseDown);
      }
      
      //============================================================
      // <T>鼠标松开。</T>
      //
      // @author HECNG 20120302
      //============================================================
      private function onMouseUp(event:MouseEvent):void{
         sendEvent(eventMouseUp);
      }
      
      //============================================================
      // <T>鼠标移入。</T>
      //
      // @author HECNG 20120302
      //============================================================
      private function onMouseOver(p:MouseEvent):void{ 
         playMovie();
         if(isFilters && _activated){
            contentContainer.filters = [RGmStyle.ButtonGlowFilter, RGmStyle.DropEmptyFilter];
         }
         sendEvent(eventMouseOver);
      }
      
      //============================================================
      // <T>鼠标移出。</T>
      //
      // @author HECNG 20120302
      //============================================================
      private function onMouseOut(event:MouseEvent):void{
         if(movieRid){
            player.close();
            backgroundBit.visible = true; 
         }
         if(_activated){
            contentContainer.filters = [];
         }
         sendEvent(eventMouseOut);
      }
      
      //============================================================
      // <T>鼠标单机。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function onMouseClick(event:MouseEvent = null):void{ 
         buttonState = MOUSE_DOWN;
         var f:FEvent = new FEvent();
			var s:String = name;
         f.sender = this;
         if(click_interval > 0){
            if((RTimer.currentTick - time >= click_interval * 1000) && activated){
               time = RTimer.currentTick;
               activated = false;
               setDisable(true); 
               clickFlistener.process(f);			
               sendEvent(eventMouseClick);
            }
         }else{
            clickFlistener.process(f);			
            sendEvent(eventMouseClick);
         }
      }
      
      //============================================================
      // <T>触发事件。</T>
      //
      // @param name 事件名称
      // @author HECNG 20120302
      //============================================================
      public function sendEvent(name:String):void{
         if(name){
            paint(context);
            var form:FUiForm = this.findParent(FUiForm);
            var f:FEvent = new FEvent();
            f.sender = this;
            var d:Object = form.eventDispatcher;
            if(d){
               var m:Function = d[name];
               m.call(d, f); 
            } 
         }
      }
 
      //============================================================
      // <T>绘制图形</T> 
      //
      // @author HECNG 20120302
      //============================================================
      public override function paint(p:FUiContext = null):void{
         if(ready){
            _border.size.set(size.width, size.height);
            setlabel();
            // 绘制底框
            var g:Graphics = contentContainer.graphics;
            g.clear();
            g.beginFill(0xFFFFFF, 0);
            g.drawRect(0, 0, size.width, size.height);
            g.endFill();
            // 设置位图
            backgroundBit.bitmapData = _activated ? activatedPic.bitmapData : activatePic.bitmapData;
            backgroundBit.width = backgroundBit.bitmapData.width;
            backgroundBit.height = backgroundBit.bitmapData.height;
            // 设置边框
            if(isBorder){
               _border.onPaint();
            }
            // 修正位置
            RUiUtil.calculateAlign(backgroundBit, align, size.width, size.height);
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
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function mouseEnable(bool:Boolean):void{
         contentContainer.mouseChildren = bool;
         contentContainer.mouseEnabled = bool;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120302
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 加载背景
         dock = p.get("dock");
         activatedRid = p.getUint("acticated_rid");
         activateRid = p.getUint("acticate_rid");
         eventMouseClick = p.get("onclick");
         eventMouseUp = p.get("onup");
         eventMouseDown = p.get("ondown");
         eventMouseOver = p.get("onover");
         eventMouseOut = p.get("onout");
         align = p.get("align");
         movieRid = p.get("movie_id"); 
         isFilters = p.getBoolean("isfitters");			
         click_interval = p.getInt("click_interval");
         if(label){
            text.text = label;
         }
         // 加载边框
         var xb:FXmlNode = p.findNode("Border");
         if(xb){
            isBorder = true;
            _border.loadConfig(xb);
         }
         setup();
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         activatedPic = null;
         activatePic = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120302
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         // 加载背景
         p.set("dock", dock);
         p.set("acticated_rid",  activatedRid.toString());
         p.set("acticate_rid",  activateRid.toString());
         p.set("onclick", eventMouseClick);
         p.set("onup", eventMouseUp);
         p.set("ondown", eventMouseDown);
         p.set("onover", eventMouseOver);
         p.set("onout", eventMouseOut);
         p.set("align", align);
         p.set("movie_id", movieRid); 
         p.setBoolean("isfitters", isFilters);
			p.set("click_interval",click_interval.toString());
         if(isBorder){
            var xb:FXmlNode = p.create("Border");
            _border.saveConfig(xb);
         }
      }
      
      //============================================================
      // <T>按钮生成。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function setup():void{
         if(isBorder){
            _border.display.x = _border.display.y = 0;
            contentContainer.addChild(_border.display);
            _border.addChild(backgroundBit, 0, 0);
         }else{
            contentContainer.addChild(backgroundBit);
         }
         contentContainer.addChild(text);
         contentContainer.addChild(player.displayObject);
         contentContainer.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
         contentContainer.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
         contentContainer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
         contentContainer.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
         contentContainer.addEventListener(MouseEvent.CLICK, onMouseClick);
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(activatedPic && activatePic){
            if(activatedPic.ready && activatePic.ready){
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         // 处理动画
         if(movieRid){
            player.process(); 
         }
         // 处理边框
         if(isBorder){
            _border.process();
         }
         // 准备数据
         if(activatedRid && !activatedPic){
            activatedPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, activatedRid.toString());
         }
         if(activateRid && !activatePic){
            activatePic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, activateRid.toString());
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
         // 显示处理
         if(click_interval > 0){
            var number:Number = RTimer.currentTick - time; 
            if(number >= (click_interval * 1000) && activated == false){
               setDisable(false);
               activated = true;
            } 
         }
      }
   }
}