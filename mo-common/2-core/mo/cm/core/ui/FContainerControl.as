package mo.cm.core.ui
{
   import flash.display.DisplayObjectContainer;
   
   public class FContainerControl extends FControl
   {
      public var displayContainer:DisplayObjectContainer = new FSprite();
      
      //============================================================
      public function FContainerControl(name:String=null) {
         super(name);
         display = displayContainer;
      }
      
      //============================================================
      public override function push(component:FComponent):void {
         super.push(component);
         if (component is FControl) {
            var control:FControl = component as FControl;
            controls.push(control);
            // 将子控件添加到当前对象上去
            displayContainer.addChild(control.display);
         }
      }
   }
}