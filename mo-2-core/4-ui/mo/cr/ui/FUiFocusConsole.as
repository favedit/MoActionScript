package mo.cr.ui
{
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RMouse;
   import mo.cm.system.FEvent;
   import mo.cm.xml.FXmlNode;

   public class FUiFocusConsole extends FConsole
   {
      protected var _controlHover:FUiControl3d;
      
      protected var _controlFocus:FUiControl3d;

      protected var _controlDock:IUiDockable;

      protected var _controlDrag:IUiDragable;

      public function FUiFocusConsole(){
         name = "core.ui.focus.console";
      }

      public function get controlHover():FUiControl3d{
         return _controlHover;
      }

      public function set controlHover(p:FUiControl3d):void{
      }

      public function get controlFocus():FUiControl3d{
         return _controlFocus;
      }
      
      public function set controlFocus(p:FUiControl3d):void{
      }

      public function get controlDock():IUiDockable{
         return _controlDock;
      }
      
      public function set controlDock(p:IUiDockable):void{
      }

      public function get controlDrag():IUiDragable{
         return _controlDrag;
      }
      
      public function set controlDrag(p:IUiDragable):void{
         _controlDrag = p;
      }
   
      //============================================================
      // <T> 释放拖拽物体。</T>
      //============================================================
      public function onMouseDown(p:FEvent):void{
         if(controlDrag){
            controlDrag.cancle();
         }
      }

      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         RMouse.lsnsClick.register(onMouseDown, this);
         super.loadConfig(p);
      }   
   }
}