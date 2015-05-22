package mo.cm.reflection
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.FString;
   import mo.cm.lang.RBoolean;
   import mo.cm.lang.RString;
   
   //============================================================
   // <T>类对象。</T>
   //============================================================
   public class FClass extends FObject
   {
      // 名称
      public var name:String;
      
      // 父名称
      public var parentName:String;
      
      // 接口集合
      public var interfaces:Vector.<String>;
      
      // 基础
      public var base:String;
      
      // 动态
      public var isDynamic:Boolean;
      
      // 静态
      public var isStatic:Boolean;
      
      // 封装
      public var isFinal:Boolean;
      
      // 字段集合
      public var fields:Vector.<FField>;
      
      // 函数集合
      public var methods:Vector.<FMethod>;
      
      //============================================================
      // <T>构造类对象。</T>
      //============================================================
      public function FClass(){
      }
      
      //============================================================
      // <T>字段排序。</T>
      //
      // @param ps:source 来源
      // @param pt:target 目标
      //============================================================
      public function sortField(ps:FField, pt:FField):int{
         return RString.compare(ps.name, pt.name);
      }
      
      //============================================================
      // <T>字段排序。</T>
      //
      // @param ps:source 来源
      // @param pt:target 目标
      //============================================================
      public function sortMethod(ps:FMethod, pt:FMethod):int{
         if(ps.declaredBy == pt.declaredBy){
            return RString.compare(ps.name, pt.name);
         }
         return RString.compare(ps.declaredBy, pt.declaredBy);
      }
      
      //============================================================
      // <T>根据类名称找到类对象。</T>
      //
      // @param p:className 类名称
      // @return 类对象
      //============================================================
      public function parse(p:XML):void{
         // 获得类属性
         name = p.@name.toString();
         base = p.@base.toString();
         isDynamic = RBoolean.isTrue(p.@isDynamic.toString());
         isStatic = RBoolean.isTrue(p.@isStatic.toString());
         isFinal = RBoolean.isTrue(p.@isFinal.toString());
         // 获得工厂
         var x:XML = p.factory[0];
         // 获得父类
         parentName = x.extendsClass.@type.toString();
         // 获得接口集合
         interfaces = new Vector.<String>();
         for each(var xi:XML in x.implementsInterface){
            interfaces.push(xi.@type.toString());
         }
         // 获得字段集合
         fields = new Vector.<FField>();
         for each(var xf:XML in x.variable){
            var f:FField = new FField();
            f.parse(xf);
            fields.push(f);
         }
         fields.sort(sortField);
         // 获得字段集合
         methods = new Vector.<FMethod>();
         for each(var xm:XML in x.method){
            var m:FMethod = new FMethod();
            m.parse(xm);
            methods.push(m);
         }
         methods.sort(sortMethod);
      }
      
      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public override function get runtimeInfo():String{
         var r:FString = new FString();
         r.appendLine(super.runtimeInfo);
         // 获得类属性
         r.append("Class: name=" + name);
         r.append(" ,parent_name=" + parentName);
         r.append(" ,base=" + base);
         r.append(" ,is_dynamic=" + isDynamic);
         r.append(" ,is_static=" + isStatic);
         r.append(" ,is_final=" + isFinal);
         // 获得接口集合
         r.append("\n-- interfaces count=" + interfaces.length);
         for each(var i:String in interfaces){
            r.append("\n      interface: name=" + i);
         }
         // 获得字段集合
         r.append("\n-- fields count=" + interfaces.length);
         for each(var f:FField in fields){
            r.append("\n      " + f.runtimeInfo);
         }
         // 获得字段集合
         r.append("\n-- methods count=" + methods.length);
         for each(var m:FMethod in methods){
            r.append("\n      " + m.runtimeInfo);
         }
         return r.toString();
      }
   }
}