package mo.cm.core.content
{
   //===========================================================
   // <T>HTML工具。 <T>
   //===========================================================
   public class RHtml
   {
      //===========================================================
      // <T>格式化HTML。 <T>
      //===========================================================
      static public function fromat(p:String):String{
         p = p.replace(/\[/g, "<");
         p = p.replace(/\]/g, ">");
         p = p.replace(/\r/g, "");
         p = p.replace(/\n/g, "");
         return p;
      }

      //===========================================================
      // <T>格式化字符窜。 <T>
      //===========================================================
      static public function toString(p:String):String{
         p = p.replace(/</g, "&lt;");
         p = p.replace(/>/g, "&rt;");
         p = p.replace(/&/g, "&amp;");
         return p;
      }
   }
}