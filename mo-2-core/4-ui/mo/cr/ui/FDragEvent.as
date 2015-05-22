package mo.cr.ui
{
   import mo.cm.system.FEvent;

   //==========================================================
   // <T> 拖拽事件</T>
   //
   // @author HECNG 20120302
   //==========================================================
   public class FDragEvent extends FEvent
   {
      // 源插槽
      public var sourceDock:IUiDockable; 

      // 目标插槽
      public var targetDock:IUiDockable; 
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120302
      //==========================================================
      public function FDragEvent(){
      }
   }
}