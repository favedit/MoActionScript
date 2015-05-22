package mo.cr.ui
{
   public interface IUiSizeable
   {
      function get width():int;

      function get height():int;
      
      function resize(pw:int, ph:int):void;
   }
}