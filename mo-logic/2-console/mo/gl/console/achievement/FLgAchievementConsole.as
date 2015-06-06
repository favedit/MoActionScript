package mo.gl.console.achievement
{
	import mo.cm.console.RCmConsole;
	import mo.cm.console.loader.FJsonLoader;
	import mo.cm.console.loader.FLoader;
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
		public function doGroup(owner:Object, callback:Function):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/achievement/group";
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			return loader;
		}
		
		//============================================================
		// <T>获取排序处理。</T>
		//============================================================
		public function doSort(owner:Object, callback:Function):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/achievement/sort";
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			return loader;
		}
		
		//============================================================
		// <T>获取查询处理。</T>
		//============================================================
		public function doQuery(owner:Object, callback:Function, guid:String):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/achievement/query?guid=" + guid;
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			return loader;
		}
	}
}