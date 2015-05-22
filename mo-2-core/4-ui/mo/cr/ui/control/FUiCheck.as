package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.form.FUiForm;
   
   //==========================================================
   // <T> 复选按钮</T>
   //
   // @author HECNG 20120227
   //==========================================================
   public class FUiCheck extends FUiControl3d
   {
      // 显示精灵
      public var contentContainer:FSprite = new FSprite();
      
      // 文本显示
      public var _label:TextField = new TextField();
      
      // 绑定数据
      public var value:String;
      
      // 未选中图片id
      public var selectpicId:int;
      
      // 选中图片id
      public var selectedpicId:int;
      
      // 未选中状态
      public var _selectPic:FCrPictureResource;
      
      // 选中状态
      public var _selectedPic:FCrPictureResource;
      
      // 未选中状态
      public var selectBit:Bitmap = new Bitmap();
      
      // 是否被选中
      public var selected:Boolean;
      
      // 触发事件
      public var eventName:String;
      
      public var selectFlitener:FListeners = RAllocator.create(FListeners);
      
      private var context:FUiContext;
      
      //===========================================================
      // <T> 构造函数。 <T>
      //
      // @Date 20120227 HECONG 新建
      //===========================================================
      public function FUiCheck(){ 
         type = EUiControlType.Check;
         display = contentContainer;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //===========================================================
      // <T> 初始化组件。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function setup():void{
         contentContainer.addChild(selectBit);
         contentContainer.addChild(_label);
         contentContainer.addEventListener(MouseEvent.CLICK, select);
      }
      
      //============================================================
      // <T>点击按钮</T>
      //
      // @author HECNG 20120227
      //============================================================
      private function select(e:MouseEvent):void{
         selected = !selected;
         paint(context);
         var form:FUiForm = this.findParent(FUiForm);
         var f:FEvent = new FEvent();
         f.sender = this;
         selectFlitener.process(f);
         var d:Object = form.eventDispatcher;
         if(d && eventName){
            var m:Function = d[eventName];
            m.call(d, f);
         }
      }
      
      //============================================================
      // <T>设置</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function setSelect(bool:Boolean):void{
         selected = bool;
         paint(context);
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         _selectPic = null;
         _selectedPic = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         value = p.get("value");
         eventName = p.get("onchange");
         if(label){
            _label.text  = label;
         }
         selectpicId = p.getUint("false_Resource_rid");
         selectedpicId = p.getUint("true_Resource_rid");
         setup();
      }
      
      //============================================================
      // <T>保存组件。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("value", value);
         p.set("onchange", eventName);
         p.set("false_Resource_rid", selectpicId.toString());
         p.set("true_Resource_rid", selectedpicId.toString());
      }
      
      //============================================================
      // <T>设置组件内显示元素大小及坐标</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function setPosition():void{
         selectBit.x = 0;
         selectBit.y = 0;
         _label.x = selectBit.width;
      }
      
      //============================================================
      // <T>设置当前显示文本</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function set text(str:String):void{
         _label.text = str;
      }
      
      //============================================================
      // <T>获取当前显示文本</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function get text():String{
         return _label.text;
      }
      
      //============================================================
      // <T>绘制显示内容。</T>
      //
      // @param p:context 环境
      // @author HECNG 20120227
      //============================================================
      public override function paint(p:FUiContext = null):void{
         // 绘制底框
         var g:Graphics = contentContainer.graphics;
         g.clear();
         g.drawRect(0, 0, size.width, size.height);
         // 绘制位图
         if((null != _selectedPic) && (null != _selectPic)){
            selectBit.bitmapData = selected ? _selectedPic.bitmapData : _selectPic.bitmapData;
            selectBit.width = size.width;
            selectBit.height = size.height;
            setPosition();
            setLabel();  
         }
      }
      
      //============================================================
      // <T>设置文本。</T>
      //
      // @author HECNG 20120302
      //============================================================
      private function setLabel():void{
         _label.selectable = false;
         _label.wordWrap = false;
         _label.mouseEnabled = false;
         _label.width = size.width - selectBit.width;
         _label.height = size.height;
         _label.autoSize = TextFieldAutoSize.CENTER;
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function testReady():Boolean{
         if(_selectPic && _selectedPic){
            if(_selectPic.ready && _selectedPic.ready){
               ready = true;
            }
         }
         return ready;
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
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         // 准备数据
         if(selectpicId && !_selectPic){
            _selectPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, selectpicId.toString());
         }
         if(selectedpicId && !_selectedPic){
            _selectedPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, selectedpicId.toString());
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