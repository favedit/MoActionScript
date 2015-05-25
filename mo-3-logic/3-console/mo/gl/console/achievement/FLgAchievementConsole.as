package mo.gl.console.achievement
{
	import mo.cm.console.RCmConsole;
	import mo.cm.console.loader.FJsonLoader;
	import mo.cm.console.loader.FLoader;
	import mo.cm.system.FListeners;
	import mo.gm.core.core.ELgConstant;
	
	//============================================================
	// <T>组织控制台。</T>
	//============================================================
	public class FLgAchievementConsole
	{
		//============================================================
		// <T>构造组织控制台。</T>
		//============================================================
		public function FLgAchievementConsole(){
		}
		
		//============================================================
		// <T>获取数据处理。</T>
		//============================================================
		public function doWhole(owner:Object, callback:Function):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/achievement/whole";
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			// 完成监听列表
			var listeners:FListeners = new FListeners();
			listeners.register(callback, owner);
			loader.tag = listeners; 
			return loader;
		}
		
		//============================================================
		// <T>获取数据处理。</T>
		//============================================================
		public function doQuery(owner:Object, callback:Function, guid:String):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/achievement/query?guid=" + guid;
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			// 完成监听列表
			var listeners:FListeners = new FListeners();
			listeners.register(callback, owner);
			loader.tag = listeners; 
			return loader;
		}
	}
}