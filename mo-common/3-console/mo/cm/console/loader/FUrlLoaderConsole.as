package mo.cm.console.loader
{
   //============================================================
   public class FUrlLoaderConsole extends FLoaderConsole
   {
      //============================================================
      public function FUrlLoaderConsole(){
         name = "common.data.loader.console";
      }
      
      //============================================================
      public override function createLoader():FLoader{
         return new FUrlLoader();
      }
   }
}