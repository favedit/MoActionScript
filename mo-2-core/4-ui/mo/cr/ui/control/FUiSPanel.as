package mo.cr.ui.control
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.FItemEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.layout.FUiScrollBox;
   
   //==========================================================
   // <T> 下拉列表</T>
   //
   // @author HECNG 20120321
   //==========================================================
   public class FUiSPanel extends FUiControl3d
   {
      // 显示精灵
      protected var contentContainer:FSprite = new FSprite();
      
      // 滑动框
      public var scrollbox:FUiScrollBox = new FUiScrollBox();
      
      // 
      protected var context:FUiContext;
      
      //===========================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120321
      //===========================================================
      public function FUiSPanel(){
         type = EUiControlType.SPanel;
         display = contentContainer;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //============================================================
      // <T>出事化组件</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function setup():void{
         scrollbox.display.tag = this;
         contentContainer.addChild(scrollbox.display);
         scrollbox.setup();
      }
      
      //============================================================
      // <T>添加ui</T>
      //
      // @author HECNG 20120321
      //============================================================
      public function addChild(f:FUiControl3d, x:int, y:int):void{
         scrollbox.addChild(f.display, x, y);
         push(f);
      }
      
      //============================================================
      // <T>添加ui</T>
      //
      // @author HECNG 20120321
      //============================================================
      public function addDisplay(f:DisplayObject, x:int, y:int):void{
         scrollbox.addChild(f, x, y);
      }
      
      //============================================================
      // <T>移除</T>
      //
      // @author HECNG 20120321
      //============================================================
      public function removeDis(f:DisplayObject):void{
         scrollbox.removeChild(f);
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120321
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         var xb:FXmlNode = p.findNode(EUiControlType.ScrollBox);
         scrollbox.loadConfig(xb);
         setup();
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         scrollbox.setupEnd();
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120321
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         var xb:FXmlNode = p.create(EUiControlType.ScrollBox);
         scrollbox.saveConfig(xb);
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function paint(p:FUiContext=null):void{
         scrollbox.size.set(size.width, size.height);
         scrollbox.paint();
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         scrollbox.process();
         if(!dirty){
            paint(p);
            dirty = true;
         }
         var l:int = controls.length;
         for(var i:int = 0; i < l; i++ ){
            var fn:FUiControl3d = controls[i];
            if(fn.visible){
               fn.process(p);
            }
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
      // <T>清楚数据</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function clear():void{
         scrollbox.clear();
         var l:int = controls.length;
         for(var i:int = 0; i < l; i++ ){
            var f:FUiControl3d = controls[i];
            controls[i] = null;
         }
         controls.length = 0;
      }
   }
}