package mo.cr.console.focus
{
   import mo.cm.core.common.FConsole;

   //============================================================
   // <T>焦点控制台。</T>
   //============================================================
   public class FCrFocusConsole extends FConsole
   {
      //============================================================
      // <T>构造焦点控制台。</T>
      //============================================================
      public function FCrFocusConsole(){
         name = "core.focus.console";
      }

      public function findFocus(pc:Class, po:ICrFocus):void{
      }

      public function focus(pc:Class, po:ICrFocus):void{
      }

      public function blur(pc:Class, po:ICrFocus):void{
      }

      public function findHover(pc:Class, po:ICrFocus):void{
      }

      public function enter(pc:Class, po:ICrFocus):void{
      }

      public function leave(pc:Class, po:ICrFocus):void{
      }
   }
}