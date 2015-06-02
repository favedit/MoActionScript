package mo.cm.console.loader
{
   //============================================================
   public class FInfoLoaderConsole extends FLoaderConsole
   {
      //============================================================
      public function FInfoLoaderConsole(){
         name = "common.info.loader.console";
      }
      
      //============================================================
      public override function createLoader():FLoader{
         return new FInfoLoader();
      }
   }
}