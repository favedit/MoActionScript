package
{
	import flash.display.Sprite;
	
	import mo.cm.console.RCmConsole;
	import mo.cm.console.environment.FEnvironment;
	import mo.cm.console.loader.FLoaderEvent;
	import mo.gl.console.RLgConsole;
	import mo.gm.core.core.ELgConstant;
	
	public class Main extends Sprite
	{
		public function onFetch(e:FLoaderEvent):void{
			var ee:* = e;
			trace(e);
		}
		
		public function Main()
		{
			//var timer:FLgNumberTimer = new FLgNumberTimer();
			//timer.start(null, 1234, 200);
			
			
//			RLogger.debugAble = true;
//			RLogger.find(this).debug('frame214', 'Register province event. (name={1})', "1");
//			
			RCmConsole.setup();
			RCmConsole.environmentConsole.register(new FEnvironment(ELgConstant.ServiceHost, "115.28.82.149"));
//			var test:Object = "asd";
//			var test2:Object = "asd";
			RLgConsole.organizationConsole.doFetch(this, onFetch);
//			//RLgConsole.achievementConsole.doWhole(onFetch, this);
//			RLgConsole.achievementConsole.doQuery(this, onFetch, "bj");
		}
		
		//      public function loadServiceUrl() {
		//         var urlLoader:URLLoader = new URLLoader();
		//         //urlLoader.load(new URLRequest( "http://115.28.82.149//eai/organization/fetch"))
		//         urlLoader.load(new URLRequest( "http://115.28.82.149//eai/organization/query"));
		//         urlLoader.addEventListener(Event.COMPLETE, decodeJSONHandler);
		//      }
		//      
		//      private function decodeJSONHandler(event:Event):void {
		//         var loader:URLLoader = event.target as URLLoader;
		//         var source:String = loader.data;
		//         var test:Object = JSON.parse(source);
		//         trace(test);
		//      }
		//      
		//      public function parseJSON(event:Event) {
		//         var urlLoader:URLLoader = new URLLoader();
		//         urlLoader.load(new URLRequest( "http://127.0.0.1/json.php" ));//这里是你要获取JSON的路径
		//         urlLoader.addEventListener(Event.COMPLETE, decodeJSONHandler);
		//      }
		//   }
	}
}