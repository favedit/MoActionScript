package mo.gl.console
{
	import mo.gl.console.achievement.FLgAchievementConsole;
	import mo.gl.console.organization.FLgOrganizationConsole;
	import mo.gl.console.task.FLgTaskConsole;
	
	//============================================================
	// <T>逻辑控制台。</T>
	//============================================================
	public class RLgConsole
	{
		// 组织控制台
		protected static var _organizationConsole:FLgOrganizationConsole;
		
		// 绩效控制台
		protected static var _achievementConsole:FLgAchievementConsole;
		
		// 任务控制台
		protected static var _taskConsole:FLgTaskConsole;

		//============================================================
		// <T>获得组织控制台。</T>
		//
		// @return 组织控制台
		//============================================================
		public static function get organizationConsole():FLgOrganizationConsole{
			if(_organizationConsole == null){
				_organizationConsole = new FLgOrganizationConsole();
			}
			return _organizationConsole;
		}
		
		//============================================================
		// <T>获得绩效控制台。</T>
		//
		// @return 绩效控制台
		//============================================================
		public static function get achievementConsole():FLgAchievementConsole{
			if(_achievementConsole == null){
				_achievementConsole = new FLgAchievementConsole();
			}
			return _achievementConsole;
		}
		
		//============================================================
		// <T>获得任务控制台。</T>
		//
		// @return 任务控制台
		//============================================================
		public static function get taskConsole():FLgTaskConsole{
			if(_taskConsole == null){
				_taskConsole = new FLgTaskConsole();
			}
			return _taskConsole;
		}
	}
}
