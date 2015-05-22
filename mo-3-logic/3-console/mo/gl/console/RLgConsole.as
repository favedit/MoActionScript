package mo.gl.console
{
   import mo.gl.console.organization.FLgOrganizationConsole;
   
   //============================================================
   // <T>逻辑控制台。</T>
   //============================================================
   public class RLgConsole
   {
      // 组织控制台
      protected static var _organizationConsole:FLgOrganizationConsole = new FLgOrganizationConsole();
      
      //============================================================
      // <T>获得组织控制台。</T>
      //
      // @return 组织控制台
      //============================================================
      public static function get organizationConsole():FLgOrganizationConsole{
         return _organizationConsole;
      }
   }
}