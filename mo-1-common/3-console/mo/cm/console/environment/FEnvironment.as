package mo.cm.console.environment
{
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>环境信息。</T>
   //============================================================
   public class FEnvironment extends FObject
   {
      // 代码
      public var code:String;
      
      // 内容
      public var value:String;
      
      //============================================================
      // <T>构造环境信息。</T>
      //
      // @param code 代码
      // @param value 内容
      //============================================================
      public function FEnvironment(code:String, value:String){
         this.code = code;
         this.value = value;
      }
   }
}