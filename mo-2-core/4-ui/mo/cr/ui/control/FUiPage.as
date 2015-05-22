package mo.cr.ui.control
{
   import flash.display.Graphics;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContainer3d;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   
   //==========================================================
   // <T> 页面</T>
   //
   // @author HECNG 20120315
   //==========================================================
   public class FUiPage extends FUiContainer3d
   {
      // 容器对象
      public var containerDisplay:FSprite = new FSprite();
      
      // 关联按钮
      public var uibutton:FUiPageButton;
      
      // 背景图id
      public var groundRid:int;
      
      // 按钮图片id
      public var buttonRid:int;
      
      // 选中按钮
      public var buttonSelectRid:int;
      
      // 选中按钮
      public var buttonSelectGround:FCrPictureResource;
      
      // 背景图
      public var background:FCrPictureResource;
      
      // 按钮背景
      public var buttonGround:FCrPictureResource;
      
      // 是否显示
      public var defaultVisable:Boolean;
      
      public var isSelect:Boolean = false;
      
      public var context:FUiContext;
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @author HECNG 20120315
      //============================================================
      public function FUiPage(){
         type = EUiControlType.Page;
         display = containerDisplay;
         containerDisplay.tag = this;
         controls = new Vector.<FUiControl3d>();
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
      
      //============================================================
      // <T>设置关联按钮。</T>
      //
      // @param b:FUiPageButton 关联按钮
      // @author HECNG 20120315
      //============================================================
      public function setButton(b:FUiPageButton):void{
         uibutton = b;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120315
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         groundRid = p.getInt("ground_rid");
         buttonRid = p.getInt("button_rid");
         defaultVisable = p.getBoolean("default_display");
         buttonSelectRid = p.getInt("button_select_rid");
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
      // @author HECNG 20120315
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
            case EUiControlType.Panel:
               var panel:FUiPanel = new FUiPanel();
               addChild(panel, p);
               break;
            case EUiControlType.AnimationMovie:
               var ani:FUiAnimationMovie= new FUiAnimationMovie();
               addChild(ani, p);
               break;
         }
      }
      
      //============================================================
      // <T>保存配置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120315
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid", groundRid.toString());
         p.set("button_rid", buttonRid.toString());
         p.set("default_display", defaultVisable.toString());
         p.set("button_select_rid", buttonSelectRid.toString());
         var length:int = controls.length;
         for(var n:int = 0; n < length; n++ ){
            var name:String = controls[n].type;
            controls[n].saveConfig(p.create(name));
         }
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         background = null;
         buttonGround = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>在页面上添加组件。</T>
      //
      // @param f:FUiControl3d 组件
      // @param p:FXmlNode 节点
      // @author HECNG 20120315
      //============================================================
      public function addChild(f:FUiControl3d, p:FXmlNode = null):void{
         if(p){
            f.loadConfig(p);
         }
         containerDisplay.addChild(f.display);
         push(f);
      }
      
      //============================================================
      // <T>通过名称查询页面组件。</T>
      //
      // @param name:String 页面名称
      // @author HECNG 20120315
      //============================================================
      public function findControlByName(name:String):FUiControl3d{
         var f:FUiControl3d = null;
         for each(var n:FUiControl3d in controls){
            if(n.name == name){
               f = n;
               break;
            }
         }
         return f;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120315
      //============================================================
      public override function paint(p:FUiContext = null):void{
         // 绘制底框
         var g:Graphics = containerDisplay.graphics;
         g.clear();
         g.beginBitmapFill(background.bitmapData);
         g.drawRect(0, 0, size.width, size.height);
         g.endFill();
         // 绘制按键
         isSelect ? uibutton.paint(buttonSelectGround.bitmapData) :  uibutton.paint(buttonGround.bitmapData);
      }
      
      //============================================================
      // <T>更新按钮</T>
      //
      // @author HECNG 20120315
      //============================================================
      public function updateButton(bool:Boolean):void{
         isSelect = bool;
         bool ? uibutton.paint(buttonSelectGround.bitmapData) : uibutton.paint(buttonGround.bitmapData);
      }
      
      //============================================================
      // <T>资源是否加载完成</T>
      //
      // @return 资源是否加载完成
      // @author HECNG 20120315
      //============================================================
      public override function testReady():Boolean{
         if(background && buttonGround && buttonSelectGround){
            if(background.ready && buttonGround.ready && buttonSelectGround.ready){
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120315
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         // 准备数据
         if(groundRid && !background){
            background = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
         }
         if(buttonRid && !buttonGround){
            buttonGround = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, buttonRid.toString());
         }
         if(buttonSelectRid && !buttonSelectGround){
            buttonSelectGround = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, buttonSelectRid.toString());
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