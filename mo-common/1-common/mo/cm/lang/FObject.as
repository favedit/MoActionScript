package mo.cm.lang
{
   import flash.utils.getQualifiedClassName;
   
   import mo.cm.reflection.RType;
   import mo.cm.reflection.SClassInfo;
   import mo.cm.system.RAllocator;
   import mo.cm.system.RClass;
   
   //============================================================
   // <T>基础对象。</T>
   //============================================================
   public class FObject implements IObject, IRuntime
   {
      // 唯一哈希标识
      public var hashCode:int = RObject.next();
      
      // 释放标识
      public var disposed:Boolean;

      //============================================================
      // <T>创建基础对象。</T>
      //============================================================
      public function FObject(){
      }
      
      //============================================================
      // <T>构造资源。</T>
      //============================================================
      public function construct():void{
         disposed = false;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function dispose():void{
         disposed = true;
      }
      
      //============================================================
      // <T>循环利用。</T>
      //============================================================
      public function recycling():void{
         dispose();
         RAllocator.release(this);
      }
      
      //============================================================
      // <T>获得运行总大小。</T>
      //
      // @return 运行总大小
      //============================================================
      public function runtimeCalculateTotal(p:SClassInfo):int{
         return RType.calculateTotal(this, p);
      }

      //============================================================
      // <T>获得运行信息。</T>
      //
      // @return 运行信息
      //============================================================
      public function get runtimeInfo():String{
         return getQualifiedClassName(this) + "@" + hashCode;
      }

      //============================================================
      // <T>获得运行大小。</T>
      //
      // @return 运行大小
      //============================================================
      public function get runtimeSize():int{
         return RType.calculateSize(this);
      }
      
      //============================================================
      // <T>获得运行总大小。</T>
      //
      // @return 运行总大小
      //============================================================
      public function get runtimeTotal():int{
         return RType.calculateTotal(this);
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public function toString():String{
         return RClass.makeClassName(this) + "@" + hashCode;
      }
   }
}