package mo.cm.reflection
{
   import flash.sampler.getSize;
   import flash.utils.describeType;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   import mo.cm.core.device.RFatal;
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.FObject;
   import mo.cm.system.FFatalUnsupportError;
   
   //============================================================
   // <T>类管理器。</T>
   //============================================================
   public class RType
   {
      // 类对象集合
      public static var classes:FDictionary = new FDictionary(); 
      
      //============================================================
      // <T>根据类名称找到类对象。</T>
      //
      // @param p:className 类名称
      // @return 类对象
      //============================================================
      public static function forName(p:String):FClass{
         var c:FClass = classes.get(p);
         if(!c){
            // 获得类对象
            var s:Class = getDefinitionByName(p) as Class;
            if(!s){
               RFatal.throwFatal("Unknown class. (name={1})", p);
            }
            // 创建类对象
            c = new FClass();
            c.parse(describeType(s));
            classes.set(p, c);
         }
         return c;
      }
      
      //============================================================
      // <T>根据对象找到类对象。</T>
      //
      // @param p:object 对象 
      // @return 类对象
      //============================================================
      public static function forObject(p:*):FClass{
         return forName(getQualifiedClassName(p));
      }
      
      //============================================================
      // <T>计算类内存大小。</T>
      //
      // @param p:object 对象 
      // @return 内存大小
      //============================================================
      public static function calculateSize(p:Object):int{
         return getSize(p);
      }
      
      //============================================================
      // <T>计算类内存大小。</T>
      //
      // @param p:object 对象 
      // @return 内存大小
      //============================================================
      public static function calculateTotal(p:Object, ps:SClassInfo = null):int{
         var r:int = 0;
         // 设置系统
         var ci:SClassInfo = ps;
         if(!ci){
            ci = new SClassInfo();
         }
         if(p){
            // 根据类型处理
            var s:String = typeof(p);
            switch(s){
               case "boolean":
                  r += getSize(p);
                  break;
               case "number":
                  r += getSize(p);
                  break;
               case "string":
                  r += getSize(p);
                  break;
               case "object":
                  if(-1 == ci.instances.indexOf(p)){
                     ci.instances.push(p);
                     // 计算对象内存
                     r += getSize(p);
                     var oc:FClass = forObject(p);
                     var c:int = oc.fields.length;
                     for(var n:int = 0; n < c; n++){
                        var f:FField = oc.fields[n];
                        var v:Object = p[f.name];
                        if(v){
                           var t:String = f.type;
                           if((t == "int") || (t == "uint") || (t == "Boolean") || (t == "Number")){
                              continue;
                           }else if(0 == t.indexOf("flash.")){
                              r += getSize(v);
                           }else if(0 == t.indexOf("__AS3__.vec::Vector.")){
                              r += getSize(v);
                              if(t == "__AS3__.vec::Vector.<bool>"){
                                 continue;
                              }else if(t == "__AS3__.vec::Vector.<int>"){
                                 continue;
                              }else if(t == "__AS3__.vec::Vector.<uint>"){
                                 continue;
                              }else if(t == "__AS3__.vec::Vector.<number>"){
                                 continue;
                              }else{
                                 // 处理数组
                                 for each(var i:int in v){
                                    if(i){
                                       r += calculateTotal(i, ci);
                                    }
                                 }
                              }
                           }else{
                              // 处理对象
                              var vi:FObject = v as FObject;
                              if(vi){
                                 r += vi.runtimeCalculateTotal(ci);
                              }else{
                                 r += calculateTotal(v, ci);
                              }
                           }
                        }
                     }
                  }
                  break;
               default:
                  throw new FFatalUnsupportError();
            }
         }
         return r;
      }
   }
}