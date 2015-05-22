package mo.cr.ui
{
   import flash.display.DisplayObject;
   
   import mo.cr.ui.control.EUiAlign;

   //===========================================================
   // <T>界面工具。 <T>
   //===========================================================
   public class RUiUtil
   {
      //===========================================================
      // <T>计算对齐。 <T>
      //===========================================================
      static public function calculateAlign(p:DisplayObject, pa:String, pw:Number, ph:Number):void{
         if((EUiAlign.Center == pa) || (EUiAlign.Top == pa) || (EUiAlign.Bottom == pa)){
            p.x = (pw - p.width) / 2;
         }
         if((EUiAlign.Center == pa) || (EUiAlign.Left == pa) || (EUiAlign.Right == pa)){
            p.y = (ph - p.height) / 2;
         }
      }

      //===========================================================
      // <T>格式化HTML。 <T>
      //===========================================================
      static public function fromatHtml(p:String):String{
         p = p.replace(/\[/g, "<");
         p = p.replace(/\]/g, ">");
         p = p.replace(/\n/g, "");
         return p;
      }
   }
}