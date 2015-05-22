package mo.cr.ui
{
   import mo.cm.system.FEvent;
   
   //==========================================================
   // <T> 滑动条滑动事件</T>
   //
   // @author HECNG 20120302
   //==========================================================
   public class FScrollEvent extends FEvent
   {
      // 滚动值
      public var scrollPosition:int; 
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120302
      //==========================================================
      public function FScrollEvent(){
      }
   }
}