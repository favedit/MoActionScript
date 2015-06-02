package mo.cm.console.loader
{
   //============================================================
   // <T>数据加载控制器。</T>
   //============================================================
   public class FXmlLoaderConsole extends FLoaderConsole
   {
      //============================================================
      // <T>构造数据加载控制器。</T>
      //============================================================
      public function FXmlLoaderConsole(){
         name = "common.config.loader.console";
      }
      
      //============================================================
      // <T>创建加载器。</T>
      //============================================================
      public override function createLoader():FLoader{
         return new FXmlLoader();
      }
   }
}