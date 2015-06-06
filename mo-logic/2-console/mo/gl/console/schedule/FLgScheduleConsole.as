package mo.gl.console.schedule
{
	import mo.cm.console.RCmConsole;
	import mo.cm.console.loader.FJsonLoader;
	import mo.cm.console.loader.FLoader;
	import mo.gm.core.core.ELgConstant;
	
	//============================================================
	// <T>任务控制台。</T>
	//============================================================
	public class FLgScheduleConsole
	{
		//============================================================
		// <T>构造任务控制台。</T>
		//============================================================
		public function FLgScheduleConsole(){
		}
		
		//============================================================
		// <T>获取数据处理。</T>
		//============================================================
		public function doFetch(owner:Object, callback:Function):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/schedule/fetch";
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			return loader;
		}
	}
}