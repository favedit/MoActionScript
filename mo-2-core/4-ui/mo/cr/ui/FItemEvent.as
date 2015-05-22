package mo.cr.ui
{
   import mo.cm.system.FEvent;
   import mo.cr.ui.control.FUiListItem;
   
   //==========================================================
   // <T> 项点击事件</T>
   //
   // @author HECNG 20120302
   //==========================================================
   public class FItemEvent extends FEvent
   {
      // 项
      public var item:FUiListItem; 
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120302
      //==========================================================
      public function FItemEvent(){
      }
   }
}