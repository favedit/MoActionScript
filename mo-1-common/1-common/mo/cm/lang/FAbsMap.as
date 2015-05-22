package mo.cm.lang
{
   import flash.sampler.getSize;
   import flash.utils.Dictionary;
   
   import mo.cm.reflection.SClassInfo;
   
   //============================================================
   // <T>对象键和值对存储表基类。</T>
   //============================================================
   public class FAbsMap extends FObject
   {
      // 存储字典
      public var storage:Dictionary = new Dictionary(); 
      
      // 存储名称
      public var names:Vector.<String> = new Vector.<String>();
      
      //============================================================
      // <T>创建键和值对存储表基类。</T>
      //============================================================
      public function FAbsMap(){
      }
      
      //============================================================
      // <T>判断是否存在键值对。</T>
      //
      // @return 是否为空
      //============================================================
      [Inline]
      public final function isEmpty():Boolean{
         return (0 == names.length);
      }
      
      //============================================================
      // <T>获得键值对的总数。</T>
      //
      // @return 是否为空
      //============================================================
      [Inline]
      public final function get count():uint{
         return names.length;
      }
      
      //============================================================
      // <T>判断是否包含指定名称的值。</T>
      //
      // @param p:name 名称
      // @return 是否包含
      //============================================================
      [Inline]
      public final function contains(p:String):Boolean{
         return (null != storage[p]);
      }
      
      //============================================================
      // <T>获得名称的索引位置。</T>
      //
      //@param p:name 名称
      //@return 索引位置
      //============================================================
      [Inline]
      public final function indexOf(p:String):int{
         return names.indexOf(p);
      }
      
      //============================================================
      // <T>获得指定位置的名称。</T>
      //
      // @param index 索引位置
      // @return Object 名称对象 
      //============================================================
      [Inline]
      public final function name(p:int):String{
         return (p >= 0 && p < names.length) ? names[p] : null;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         // 释放字典
         var c:int = names.length;
         for(var n:int = 0; n < c; n++){
            delete storage[names[n]];
            names[n] = null;
         }
         storage = null;
         // 释放名称集合
         names.length = 0;
         names = null;
      }
      
      //============================================================
      // <T>获得运行总大小。</T>
      //
      // @return 运行总大小
      //============================================================
      public override function runtimeCalculateTotal(p:SClassInfo):int{
         var r:int = getSize(this);
         r += getSize(storage);
         r += getSize(names);
         return r;
      }
   }
}