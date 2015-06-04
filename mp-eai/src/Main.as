package
{
	import flash.display.Sprite;
	
	import mo.cm.console.RCmConsole;
	import mo.cm.console.environment.FEnvironment;
	import mo.cm.console.loader.FLoaderEvent;
	import mo.cm.logger.RLogger;
	import mo.gl.console.RLgConsole;
	import mo.gm.core.core.ELgConstant;
	
	public class Main extends Sprite
	{
		public function onResult(event:FLoaderEvent):void{
			var content:Object = event.content;
			trace(content);
		}
		
		public function Main()
		{
			//var timer:FLgNumberTimer = new FLgNumberTimer();
			//timer.start(null, 1234, 200);
			RLogger.debugAble = true;
			RCmConsole.setup();
			RCmConsole.environmentConsole.register(new FEnvironment(ELgConstant.ServiceHost, "115.28.82.149"));
			RLgConsole.organizationConsole.doFetch(this, onResult);
			//RLgConsole.achievementConsole.doWhole(this, onResult);
			//RLgConsole.achievementConsole.doSort(this, onResult);
			//RLgConsole.achievementConsole.doQuery(this, onResult, "bj0");
			//RLgConsole.taskConsole.doFetch(this, onResult);
		}
	}
}