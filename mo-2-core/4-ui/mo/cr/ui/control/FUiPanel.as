package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.events.MouseEvent;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.ui.FSprite;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContainer3d;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.layout.FUiBorder;
   
   //==========================================================
   // <T> 面板容器</T>
   //
   // @author HECNG 20120507
   //==========================================================
   public class FUiPanel extends FUiContainer3d
   {
      // 背景容器
      public var contentContainer:FSprite = new FSprite();
      
      // 背景位图
      public var bitmap:Bitmap = new Bitmap();
      
      // 背景图编号
      public var groundRid:uint = 0;
      
      // 背景图
      public var backGroundPic:FCrPictureResource;
      
      // 边框
      public var _border:FUiBorder = new FUiBorder();
      
      // 是否添加边框
      public var isborder:Boolean = false;
      
      // 是否可以拖拽
      public var isdrag:Boolean = false;
      
      public var context:FUiContext;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120427
      //==========================================================
      public function FUiPanel(){
         display = contentContainer;
         type = EUiControlType.Panel;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //===========================================================
      // <T> 初始化组件。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function setup():void{
         contentContainer.addChild(bitmap);
         contentContainer.addChild(_border.display);
         _border.size.set(size.width, size.height);
         _border.display.x = _border.display.y = 0;
         display.addEventListener(MouseEvent.MOUSE_DOWN, startDrag);
         display.addEventListener(MouseEvent.MOUSE_UP, stopDrag);
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
         isborder = p.getBoolean("isborder");
         setup();
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            growControl(x);
         }
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
               addControl(edit, p);
               break;
            case EUiControlType.Button:
               var ctl:FUiButton = new FUiButton();
               addControl(ctl, p)
               break;
            case EUiControlType.Slot:
               var slot:FUiSlot = new FUiSlot();
               addControl(slot, p);
               break;
            case EUiControlType.Check:
               var check:FUiCheck = new FUiCheck();
               addControl(check, p);
               break;
            case EUiControlType.PageControl:
               var page:FUiPageControl = new FUiPageControl();
               addControl(page, p);
               break;
            case EUiControlType.Border:
               _border.size.set(size.width, size.height);
               _border.loadConfig(p);
               isborder = true;
               break;
            case EUiControlType.Select:
               var select:FUiSelect = new FUiSelect();
               addControl(select, p);
               break;
            case EUiControlType.ListBox:
               var box:FUiListBox = new FUiListBox();
               addControl(box, p);
               break;
            case EUiControlType.TreeView:
               var tree:FUiTreeView = new FUiTreeView();
               addControl(tree, p);
               break;
            case EUiControlType.Table:
               var t:FUiTable = new FUiTable();
               addControl(t, p);
               break;
            case EUiControlType.PictureBox:
               var pbox:FUiPictureBox = new FUiPictureBox();
               addControl(pbox, p);
               break;
            case EUiControlType.ProgressBar:
               var pbar:FUiProgressBar = new FUiProgressBar();
               addControl(pbar, p);
               break;
            case EUiControlType.Radio:
               var ra:FUiRadio = new FUiRadio();
               addControl(ra, p);
               break;
            case EUiControlType.Panel:
               var pan:FUiPanel = new FUiPanel();
               addControl(pan, p);
               break;
            case EUiControlType.Label:
               var label:FUiLabel = new FUiLabel();
               addControl(label, p);
               break;
            case EUiControlType.LoaderPictureBox:
               var loader:FUiLoaderPictrueBox = new FUiLoaderPictrueBox();
               addControl(loader, p);
               break;
            case EUiControlType.AnimationMovie:
               var ani:FUiAnimationMovie= new FUiAnimationMovie();
               addControl(ani, p);
               break;
         }
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         backGroundPic = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function paint(p:FUiContext = null):void{
         // 绘制底框
         var g:Graphics = contentContainer.graphics;
         g.clear();
         g.beginFill(0xffffff, 0);
         g.drawRect(0, 0, size.width, size.height);
         g.endFill();
         // 绘制位图
         if(backGroundPic){
            var d:BitmapData = backGroundPic.bitmapData;
            bitmap.bitmapData = d; 
            bitmap.width = size.width;
            bitmap.height = size.height;
         }
      }
      
      //============================================================
      // <T>清理内部全部显示对象</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function clear():void{
         var l:int = controls.length;
         for(var i:int = 0; i < l; i++ ){
            var f:FUiControl3d = controls[i];
            var p:DisplayObjectContainer = f.display.parent;
            if(p){
               p.removeChild(f.display);
            }
            controls[i] = null;
         }
         controls.length = 0;
      }
      
      //============================================================
      // <T>添加组件</T>
      //
      // @params f 组件
      // @author HECNG 20120302
      //============================================================
      public function addControl(f:FUiControl3d, p:FXmlNode = null):void{
         if(p){
            f.loadConfig(p);
         }
         contentContainer.addChild(f.display);
         push(f);
      }
      
      //============================================================
      // <T>删除组件</T>
      //
      // @params f 组件
      // @author HECNG 20120302
      //============================================================
      public function removeControl(f:FUiControl3d):void{
         contentContainer.removeChild(f.display);
         remove(f);
      }
      
      //============================================================
      // <T>通过名称获取对应组件</T>
      //
      // @param p:name 组件名称
      // @return 组件
      // @author HECNG 20120320
      //============================================================
      public function getControlByName(p:String):FUiControl3d{
         var count:int = controls.length;
         var f:FUiControl3d;
         for(var n:int = 0; n < count; n++){
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
      // <T>设置宽高。</T>
      //
      // @author HECNG 20120320
      //============================================================
      public override function setSize(pw:Number, ph:Number):void{
         super.setSize(pw, ph);
         if(isborder){
            _border.size.set(pw, ph);
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
         if(isdrag){
            contentContainer.startDrag();
         }
      }
      
      //============================================================
      // <T>停止拖拽。</T>
      //
      // @author HECNG 20120320
      //============================================================
      private function stopDrag(e:MouseEvent):void{
         if(isdrag){
            contentContainer.stopDrag(); 
         }
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(groundRid != 0){
            if(backGroundPic){
               ready = backGroundPic.ready;
            }
         }else{
            ready = true;
         }
         return ready;
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
         p.setBoolean("isborder", isborder);
         var length:int = controls.length;
         for(var n:int = 0; n < length; n++ ){
            var name:String = controls[n].type;
            controls[n].saveConfig(p.create(name));
         }
         if(isborder){
            var xb:FXmlNode = p.create("Border");
            _border.saveConfig(xb);
         }
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
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         // 处理边框
         if(isborder){
            _border.process();
         }
         // 准备数据
         if(groundRid && !backGroundPic){
            backGroundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
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
         // 子处理
         processControls(p);
      }
   }
}