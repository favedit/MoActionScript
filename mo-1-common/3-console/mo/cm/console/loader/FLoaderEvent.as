package mo.cm.console.loader
{
   import mo.cm.system.FEvent;

   //============================================================
   // <T>加载事件对象。</T>
   //============================================================
   public class FLoaderEvent extends FEvent
   {
      // 加载器
      public var loader:*;
      
      // 网络地址
      public var url:String;
      
      // 解析后的数据
      public var content:*;
      
      // 二进制数据
      public var data:*;

      //============================================================
      // <T>构造加载事件对象。</T>
      //============================================================
      public function FLoaderEvent(){
      }
   
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         loader = null;
         content = null;
         data = null;
         super.dispose();
      }
   }
}