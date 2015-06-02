package mo.gl.console.organization
{
	import mo.cm.console.RCmConsole;
	import mo.cm.console.loader.FJsonLoader;
	import mo.cm.console.loader.FLoader;
	import mo.gm.core.core.ELgConstant;
	
	//============================================================
	// <T>组织控制台。</T>
	//============================================================
	public class FLgOrganizationConsole
	{
		//		//============================================================
		//		// <T>构造组织控制台。</T>
		//		//============================================================
		//		public function FLgOrganizationConsole(){
		//		}
		
		//============================================================
		// <T>获取数据处理。</T>
		//============================================================
		public function doFetch(owner:Object, callback:Function):FLoader{
			// 获得网络地址
			var serviceHost:String = RCmConsole.environmentConsole.findValue(ELgConstant.ServiceHost);
			var url:String = "http://" + serviceHost + "/eai/organization/fetch";
			// 加载数据
			var loader:FJsonLoader = new FJsonLoader();
			loader.registerComplete(callback, owner);
			loader.load(url);
			return loader;
		}
	}
}