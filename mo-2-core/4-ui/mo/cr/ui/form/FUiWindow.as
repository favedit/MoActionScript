package mo.cr.ui.form
{
   import mo.cr.ui.control.EUiControlType;
   
   //==========================================================
   // <T> 可拖动界面</T>
   //
   // @author HECNG 20120314
   //==========================================================
   public class FUiWindow extends FUiForm
   {
      // 是否立即激活（激活后显示）
      public var active:Boolean = false;
      
      // 显示场景
      public var sceneCd:int;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120314
      //==========================================================
      public function FUiWindow(){
         super();
         type = EUiControlType.Window;
         isdrag = true;
         displayOrder = 10;
      }  
   }
}