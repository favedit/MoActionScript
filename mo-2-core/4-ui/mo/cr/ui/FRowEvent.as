package mo.cr.ui
{
   import mo.cm.system.FEvent;
   import mo.cr.ui.control.FUiGridRow;

   //==========================================================
   // <T> 行点击事件</T>
   //
   // @author HECNG 20120302
   //==========================================================
   public class FRowEvent extends FEvent
   {
      // 被点击行
      public var row:FUiGridRow; 
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120302
      //==========================================================
      public function FRowEvent(){
      }
   }
}