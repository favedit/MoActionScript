package mo.cr.ui
{
   import mo.cm.system.FEvent;
   import mo.cr.ui.control.FUiTreeNode;

   //==========================================================
   // <T> 点点击事件</T>
   //
   // @author HECNG 20120302
   //==========================================================
   public class FNodeEvent extends FEvent
   {
      // 点击节点
      public var node:FUiTreeNode;
      
      // 事件文本
      public var text:String;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120302
      //==========================================================
      public function FNodeEvent(){
      }
   }
}