package mo.cr.ui.control
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.FUiContext;

   //==========================================================
   // <T> 列表</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiTable extends FUiGrid
   {
      //===========================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function FUiTable(){
         super();
         type = EUiControlType.Table;
      }
   }
}