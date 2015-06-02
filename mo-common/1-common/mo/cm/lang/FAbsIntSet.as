package mo.cm.lang
{
   import flash.sampler.getSize;
   import flash.utils.Dictionary;
   
   import mo.cm.reflection.SClassInfo;
   
   //============================================================
   // <T>整数键和值对存储表基类。</T>
   //============================================================
   public class FAbsIntSet extends FObject
   {
      // 存储字典
      public var storage:Dictionary = new Dictionary(); 
      
      // 名称集合
      public var names:Vector.<int> = new Vector.<int>();
      
      //============================================================
      // <T>创建键和值对存储表基类。</T>
      //============================================================
      public function FAbsIntSet(){
      }
      
      //============================================================
      // <T>判断是否存在键值对。</T>
      //
      // @return 是否为空
      //============================================================
      public function isEmpty():Boolean{
         return (0 == names.length);
      }
      
      //============================================================
      // <T>获得键值对的总数。</T>
      //
      // @return 是否为空
      //============================================================
      public function get count():uint{
         return names.length;
      }
      
      //============================================================
      // <T>判断是否包含指定名称的值。</T>
      //
      // @param p:name 名称
      // @return 是否包含
      //============================================================
      public function contains(p:int):Boolean{
         return (null != storage[p]);
      }
      
      //============================================================
      // <T>获得名称的索引位置。</T>
      //
      //@param p:id 名称
      //@return 索引位置
      //============================================================
      public function indexOf(p:int):int{
         var v:* = storage[p];
         return (null != v) ? v : -1;
      }
      
      //============================================================
      // <T>获得指定位置的名称。</T>
      //
      // @param p:index 索引位置
      // @return Object 名称对象 
      //============================================================
      public function name(p:int):int{
         return names[p];
      }
      
      //============================================================
      // <T>获得运行时信息。</T>
      //============================================================
      public function dump(p:int = 0):String{
         return null;
      }
      
      //============================================================
      // <T>释放。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         // 清空对照表
         var c:int = names.length;
         for(var n:int = 0; n < c; n++){
            delete storage[names[n]];
            names[n] = null;
         }
         storage = null;
         // 清空内容
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