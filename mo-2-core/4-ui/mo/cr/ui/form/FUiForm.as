package mo.cr.ui.form
{
   import flash.display.Bitmap;
   import flash.display.Graphics;
   import flash.events.MouseEvent;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContainer3d;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.control.EUiControlType;
   import mo.cr.ui.control.FUiAnimationMovie;
   import mo.cr.ui.control.FUiButton;
   import mo.cr.ui.control.FUiCheck;
   import mo.cr.ui.control.FUiEdit;
   import mo.cr.ui.control.FUiLabel;
   import mo.cr.ui.control.FUiListBox;
   import mo.cr.ui.control.FUiLoaderPictrueBox;
   import mo.cr.ui.control.FUiPageControl;
   import mo.cr.ui.control.FUiPanel;
   import mo.cr.ui.control.FUiPictureBox;
   import mo.cr.ui.control.FUiProgressBar;
   import mo.cr.ui.control.FUiRadio;
   import mo.cr.ui.control.FUiSPanel;
   import mo.cr.ui.control.FUiSelect;
   import mo.cr.ui.control.FUiSlot;
   import mo.cr.ui.control.FUiTable;
   import mo.cr.ui.control.FUiTreeView;
   import mo.cr.ui.layout.FUiBorder;
   
   //============================================================
   // <T>界面表单。</T>
   //
   // @author HECNG 20120320
   //============================================================
   public class FUiForm extends FUiContainer3d
   {
      // 事件发送对象
      public var eventDispatcher:Object;
      
      // 显示容器
      public var containerDisplay:FSprite = new FSprite();
      
      // 边框
      public var _border:FUiBorder = new FUiBorder();
      
      // 图片编号
      public var resourceId:int;
      
      // 背景图
      private var groundPic:FCrPictureResource;
      
      // 背景图容器
      public var backShape:Bitmap = new Bitmap();
      
      // 是否显示边框
      public var isBorder:Boolean = false;
      
      // 是否可以拖拽
      public var isdrag:Boolean;
      
      // 环境
      public var context:FUiContext;
      
      // 位置
      public var groundLocation:SIntPoint2 = new SIntPoint2();
      
      // 加载完成
      public var lsnsComplete:FListeners = RAllocator.create(FListeners);
      
      public var isOrder:Boolean = true;
      
      //============================================================
      // <T>构造界面表单。</T>
      //
      // @author HECNG 20120320
      //============================================================
      public function FUiForm(){
         visible = false;
         isdrag = true;
         type = EUiControlType.Form;
         display = containerDisplay;
         display.name = "form";
         containerDisplay.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //============================================================
      // <T>显示处理。</T>
      //============================================================
      public function show():void{
         visible = true;
      }
      
      //============================================================
      // <T>隐藏处理。</T>
      //============================================================
      public function hide():void{
         visible = false;
      }
      
      //============================================================
      // <T>设置大小。</T>
      //============================================================
      public override function setSize(pw:Number, ph:Number):void{
         super.setSize(pw, ph);
         if(isBorder){
            if(_border.isReady){
               _border.resize(pw, ph);
            }
         }
      }
      
      //============================================================
      // <T>开始拖拽。</T>
      //
      // @author HECNG 20120320
      //============================================================
      private function startDrag(e:MouseEvent):void{
         if(isdrag && e.target.name == "form"){
            containerDisplay.startDrag();
         }
      }
      
      //============================================================
      // <T>停止拖拽。</T>
      //
      // @author HECNG 20120320
      //============================================================
      private function stopDrag(e:MouseEvent):void{
         if(isdrag && e.target.name == "form"){
            containerDisplay.stopDrag();
         }
      }
      
      //===========================================================
      // <T> 初始化背景 <T>
      //
      // @author HECNG 20120320
      //===========================================================
      public override function setup():void{
         display.addEventListener(MouseEvent.MOUSE_DOWN, startDrag);
         display.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
         containerDisplay.buttonMode = false;
         containerDisplay.addChild(backShape);
         containerDisplay.setChildIndex(backShape, 0);
         display.visible = false;
         if(isBorder){
            containerDisplay.addChild(_border.display);
            _border.display.x = _border.display.y = 0;
            _border.size.set(size.width, size.height);
            backShape.x = _border.left;
            backShape.y = _border.top;
            containerDisplay.setChildIndex(_border.display, 0);
            backShape.visible = false;
         }else{
            backShape.x = groundLocation.x;
            backShape.y = groundLocation.y;
         } 
         var g:Graphics =  containerDisplay.graphics;
         g.clear();
         g.beginFill(0xffee00, 0);
         g.drawRect(0, 0, size.width, size.height);
         g.endFill();
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120320
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid", resourceId.toString());
         p.set("visible",  display.visible.toString());
         p.set("ground_location", groundLocation.toString());
         p.set("display_order", displayOrder.toString());
         p.setBoolean("isborder", isBorder);
         if(isBorder){
            var xb:FXmlNode = p.create("Border");
            _border.saveConfig(xb);
         }
      }
      
      //============================================================
      // <T>通过名称获取对应组件</T>
      //
      // @param p:name 组件名称
      // @return 组件
      // @author HECNG 20120320
      //============================================================
      public function getControlByName(p:String):*{
         var c:int = controls.length;
         var f:FUiControl3d = null;
         for(var n:int = 0; n < c; n++){
            if(controls[n].name == p){
               f = controls[n];
               break;
            }
         }
         if(null == f){
            RFatal.throwFatal("Can't find control by name. (name={1})", p);
         }
         return f;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120320
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         resourceId = p.getUint("ground_rid");
         display.visible = p.getBoolean("visible");
         groundLocation.parse(p.get("ground_location"));
         displayOrder = p.getInt("display_order");
         isBorder = p.getBoolean("isborder");
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            growControl(x);
         }
         setup();
      }
      
      //============================================================
      // <T>生成组件</T>
      //
      // @param name 组件名称
      // @author HECNG 20120320
      //============================================================
      public function growControl(p:FXmlNode):void{
         switch(p.name){
            case EUiControlType.Edit:
               var edit:FUiEdit = new FUiEdit();
               addChild(edit, p);
               break;
            case EUiControlType.Button:
               var ctl:FUiButton = new FUiButton();
               addChild(ctl, p)
               break;
            case EUiControlType.Slot:
               var slot:FUiSlot = new FUiSlot();
               addChild(slot, p);
               break;
            case EUiControlType.Check:
               var check:FUiCheck = new FUiCheck();
               addChild(check, p);
               break;
            case EUiControlType.Border:
               _border.size.set(size.width, size.height);
               _border.loadConfig(p);
               isBorder = true;
               break;
            case EUiControlType.PageControl:
               var page:FUiPageControl = new FUiPageControl();
               addChild(page, p);
               break;
            case EUiControlType.Select:
               var select:FUiSelect = new FUiSelect();
               addChild(select, p);
               break;
            case EUiControlType.ListBox:
               var box:FUiListBox = new FUiListBox();
               addChild(box, p);
               break;
            case EUiControlType.TreeView:
               var tree:FUiTreeView = new FUiTreeView();
               addChild(tree, p);
               break;
            case EUiControlType.Table:
               var t:FUiTable = new FUiTable();
               addChild(t, p);
               break;
            case EUiControlType.PictureBox:
               var pbox:FUiPictureBox = new FUiPictureBox();
               addChild(pbox, p);
               break;
            case EUiControlType.ProgressBar:
               var pbar:FUiProgressBar = new FUiProgressBar();
               addChild(pbar, p);
               break;
            case EUiControlType.Radio:
               var ra:FUiRadio = new FUiRadio();
               addChild(ra, p);
               break;
            case EUiControlType.Panel:
               var pan:FUiPanel = new FUiPanel();
               addChild(pan, p);
               break;
            case EUiControlType.Label:
               var label:FUiLabel = new FUiLabel();
               addChild(label, p);
               break;
            case EUiControlType.SPanel:
               var spanel:FUiSPanel= new FUiSPanel();
               addChild(spanel, p);
               break;
            case EUiControlType.LoaderPictureBox:
               var loaderbox:FUiLoaderPictrueBox= new FUiLoaderPictrueBox();
               addChild(loaderbox, p);
               break; 
            case EUiControlType.AnimationMovie:
               var ani:FUiAnimationMovie= new FUiAnimationMovie();
               addChild(ani, p);
               break;
           
         }
      }
      
      //============================================================
      // <T>将一个组件添加到表单</T>
      //
      // @param ui:FUiControl3d 组件
      // @param node:FXmlNode 配置文件
      // @author HECNG 20120320
      //============================================================
      public function addChild(ui:FUiControl3d, node:FXmlNode = null):void{
         if(node){
            ui.loadConfig(node); 
         }
         containerDisplay.addChild(ui.display);
         push(ui);
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function paint(p:FUiContext = null):void{
         if(ready){
            if(groundPic){
               backShape.bitmapData = groundPic.bitmapData;
               backShape.width = size.width;
               backShape.height = size.height;
            }
//            if(isBorder){
//               _border.onPaint();
//               _border.resize(size.width, size.height);
//               backShape.width = size.width - 2 * _border.boardsWidth[1];
//               backShape.height = size.height - 2 * _border.boardsWidth[2];
//               backShape.width = size.width;
//               backShape.height = size.height;
//            }
         }
      }
      
      //============================================================
      // <T>资源是否加载完成</T>
      //
      // @return 资源是否加载完成
      // @author HECNG 20120320
      //============================================================
      public override function testReady():Boolean{
         // 判断自己资源是否准备好
         if(resourceId){
            if(groundPic && !groundPic.ready){
               return false;
            }
         }
         // 判断所有子对象是否准备好
         for(var n:int = controls.length - 1; n >= 0; n--){
            var c:FUiControl3d = controls[n];
            if(!c.testReady()){
               return false;
            }
         }
         ready = true;
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
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         super.process(p);
         if(isBorder){
            _border.process();
         }
         if(resourceId && !groundPic){
            groundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, resourceId.toString());
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint(p);
            display.visible = true;
            dirty = true;
            lsnsComplete.process();
         }
      }
   }
}