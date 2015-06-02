package mo.cm.reflection
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.FString;
   
   //============================================================
   // <T>类字段。</T>
   //============================================================
   public class FField extends FObject
   {
      // 名称
      public var name:String;
      
      // 类型
      public var type:String;
      
      //============================================================
      // <T>构造类字段。</T>
      //============================================================
      public function FField(){
      }
      
      //============================================================
      // <T>解析结构内容。</T>
      //
      // @param p:config 配置信息
      //============================================================
      public function parse(p:XML):void{
         // 获得属性
         name = p.@name.toString();
         type = p.@type.toString();
      }
      
      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public override function get runtimeInfo():String{
         var r:FString = new FString();
         r.appendLine(super.runtimeInfo);
         r.append("Field: name=" + name);
         r.append(" ,type=" + type);
         return r.toString();
      }
   }
}