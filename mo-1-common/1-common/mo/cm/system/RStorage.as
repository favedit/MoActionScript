package mo.cm.system
{
   import flash.net.SharedObject;
   
   //============================================================
   // <T>存储对象。</T>
   //============================================================
   public class RStorage
   {
      // 共享对象
      public static var data:SharedObject = SharedObject.getLocal("mo.storge");
      
      //============================================================
      // <T>设置处理</T>
      //============================================================
      public static function setup():void{
      }
      
      //============================================================
      // <T>获取指定数据。</T>
      //
      // @param pn:name 名称
      // @return 内容
      //============================================================
      public static function get(p:String):Object{
         return data.data[p];
      }
      
      //============================================================
      // <T>设置指定数据.</T>
      //
      // @param pn:name 名称
      // @param pv:value 内容
      //============================================================
      public static function set(pn:String, pv:Object):void{
         data.data[pn] = pv;
      }
      
      //============================================================
      // <T>写入本地存储文件.</T>
      //============================================================
      public static function flush():void{
         data.flush();
      }
   }
}