package mo.cm.reflection
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.FString;
   
   //============================================================
   // <T>类函数。</T>
   //============================================================
   public class FMethod extends FObject
   {
      // 名称
      public var name:String;
      
      // 定义对象
      public var declaredBy:String;
      
      // 返回类型
      public var returnType:String;

      //============================================================
      // <T>构造类函数。</T>
      //============================================================
      public function FMethod(){
      }
      
      //============================================================
      // <T>解析结构内容。</T>
      //
      // @param p:config 配置信息
      //============================================================
      public function parse(p:XML):void{
         // 获得属性
         name = p.@name.toString();
         returnType = p.@returnType.toString();
         declaredBy = p.@declaredBy.toString();
      }
      
      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public override function get runtimeInfo():String{
         var r:FString = new FString();
         r.appendLine(super.runtimeInfo);
         r.append("Method: name=" + name);
         r.append(" ,return_type=" + returnType);
         r.append(" ,declared_by=" + declaredBy);
         return r.toString();
      }
   }
}