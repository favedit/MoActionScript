package mo.cr.ui.tip
{
   public interface ICrTipProvider
   {
      // type, x, y, hint
      function show(pt:String, px:int, py:int, ph:String):void;

      function hide(p:String):void;
   }
}