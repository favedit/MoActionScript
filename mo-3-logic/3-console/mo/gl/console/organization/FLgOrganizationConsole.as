package mo.gl.console.organization
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.console.environment.FEnvironment;
   import mo.cm.console.loader.FUrlLoader;
   import mo.gm.core.core.ELgConstant;
   import mo.cm.console.loader.FLoader;
   
   //============================================================
   // <T>组织控制台。</T>
   //============================================================
   public class FLgOrganizationConsole
   {
      public function FLgOrganizationConsole()
      {
         //var urlLoader:URLLoader = new URLLoader();
         //urlLoader.load(new URLRequest( "http://115.28.82.149//eai/organization/fetch"))
         //urlLoader.load(new URLRequest( "http://115.28.82.149//eai/organization/query"));
         //urlLoader.addEventListener(Event.COMPLETE, decodeJSONHandler);
      }
      
      public function doFetch():FLoader
      {
         var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
         var url:String = "http://" + serviceHost + "/eai/organization/fetch";
         var loader:FUrlLoader = new FUrlLoader();
         loader.load(url);
         return loader;
      }
   }
}