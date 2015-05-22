package mo.cr.ui.style
{
   import flash.text.TextFormat;

   public interface ICrStyleProvider
   {
      function findFormat(n:String):TextFormat;

      function emptyFilters():Array;
      
      function findFilters(...rest):Array;
   }
}