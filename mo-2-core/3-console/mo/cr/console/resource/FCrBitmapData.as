package mo.cr.console.resource
{
   import flash.display.BitmapData;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;

   //============================================================
   // <T>位图数据。</T>
   //============================================================
   public class FCrBitmapData extends FObject
   {
      // 类型名称
      public var typeName:String;

      // 大小
      public var size:SIntSize2 = new SIntSize2();
      
      // 有效坐标
      public var validLocation:SIntPoint2 = new SIntPoint2();

      // 有效大小
      public var validSize:SIntSize2 = new SIntSize2();

      // 位图数据
      public var bitmapData:BitmapData;
      
      // 准备好
      public var ready:Boolean;
      
      //============================================================
      // <T>构造位图数据。</T>
      //============================================================
      public function FCrBitmapData():void{
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserialize(p:IInput):void{
      }
      
      //============================================================
      // <T>返回位图数据并置空。</T>
      //
      // @return 位图数据
      //============================================================
      public function flip():BitmapData{
         var r:BitmapData = null;
         if((null != size) && size.isEmpty()){
            r = RCrResource.emptyBitmapData;
         }else{
            r = bitmapData;
            bitmapData = null;
         }
         return r;
      }

      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function process():Boolean{
         return true;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         typeName = null;
         size = null;
         validLocation = null;
         validSize = null;
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
         super.dispose();
      }
   }
}