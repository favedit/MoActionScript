package mo.cm.console.environment
{
   import mo.cm.lang.FObjects;
   
   //============================================================
   // <T>环境控制台。</T>
   //============================================================
   public class FEnvironmentConsole
   {
      // 环境数组
      protected var _environments:FObjects = new FObjects();
      
      //============================================================
      // <T>构造环境控制台。</T>
      //============================================================
      public function FEnvironmentConsole(){
      }
      
      //============================================================
      // <T>注册环境。</T>
      //
      // @param environment 环境
      //============================================================
      public function register(environment:FEnvironment):void{
         _environments.push(environment);
      }
      
      //============================================================
      // <T>注销环境。</T>
      //
      // @param environment 环境
      //============================================================
      public function unregister(environment:FEnvironment):void{
         _environments.remove(environment);
      }
      
      //============================================================
      // <T>根据代码查找一个环境。</T>
      //
      // @param code 
      // @return 环境
      //============================================================
      public function find(code:String):FEnvironment{
         var count:int = _environments.count;
         for(var i:int = 0; i < count; i++){
            var environment:FEnvironment = _environments.get(i) as FEnvironment;
            if(environment.code == code){
               return environment;
            }
         }
         return null;
      }
      
      //============================================================
      // <T>根据代码查找一个内容。</T>
      //
      // @param code 
      // @return 内容
      //============================================================
      public function findValue(code:String):String{
         var environment:FEnvironment = find(code);
         if(environment != null){
            return environment.value
         }
         return null;
      }
   }
}