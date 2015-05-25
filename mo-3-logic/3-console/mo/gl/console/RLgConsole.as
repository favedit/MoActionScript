package mo.gl.console
{
   import mo.gl.console.organization.FLgOrganizationConsole;
   import mo.gl.console.achievement.FLgAchievementConsole;
   
   //============================================================
   // <T>逻辑控制台。</T>
   //============================================================
   public class RLgConsole
   {
      // 组织控制台
      protected static var _organizationConsole:FLgOrganizationConsole = new FLgOrganizationConsole();
      
	  // 绩效控制台
	  protected static var _achievementConsole:FLgAchievementConsole = new FLgAchievementConsole();
	  
      //============================================================
      // <T>获得组织控制台。</T>
      //
      // @return 组织控制台
      //============================================================
      public static function get organizationConsole():FLgOrganizationConsole{
         return _organizationConsole;
      }
	  
	  //============================================================
	  // <T>获得绩效控制台。</T>
	  //
	  // @return 绩效控制台
	  //============================================================
	  public static function get achievementConsole():FLgAchievementConsole{
		  return _achievementConsole;
	  }
   }
}
