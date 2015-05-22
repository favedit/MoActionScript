package mo.cr.console.resource
{
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.geom.SIntPadding;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   
   //============================================================
   // <T>通道位图数据。</T>
   //
   // @param e:event 事件
   //============================================================
   public class FCrBitmapChannles extends FObject
   {
      // 尺寸
      public var size:SIntSize2 = new SIntSize2();
      
      // 内边框
      public var padding:SIntPadding = new SIntPadding();
      
      // 颜色数据
      public var colorData:Vector.<uint>;
      
      // RGB加载器
      public var loaderRgb:Loader;
      
      // RGB准备好
      public var readyRgb:Boolean;
      
      // 透明数据
      public var alphaData:Vector.<uint>;
      
      // A加载器
      public var loaderA:Loader;
      
      // A准备好
      public var readyA:Boolean;
      
      //============================================================
      // <T>构造位图数据。</T>
      //============================================================
      public function FCrBitmapChannles():void{
      }
      
      //============================================================
      // <T>测试是否准备好。</T>
      //
      // @return 准备好
      //============================================================
      public function testReady():Boolean{
         return readyRgb && readyA;
      }
      
      //============================================================
      // <T>加载RGB通道颜色。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onContentCompleteRgb(e:Event):void{
         var d:Bitmap = e.currentTarget.content;
         colorData = d.bitmapData.getVector(d.bitmapData.rect);
         d.bitmapData.dispose();
         loaderRgb.unload();
         loaderRgb = null;
         readyRgb = true;
      }
      
      //============================================================
      // <T>加载A通道颜色。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onContentCompleteA(e:Event):void{
         var d:Bitmap = e.currentTarget.content;
         alphaData = d.bitmapData.getVector(d.bitmapData.rect);
         d.bitmapData.dispose();
         loaderA.unload();
         loaderA = null;
         readyA = true;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserialize(p:IInput):void{
         // 获得数据内容
         size.unserialize16(p);
         // 加载通道
         var channels:int = p.readInt8();
         readyRgb = true;
         readyA = true;
         if(channels >= 1){
            // 加载RGB通道
            var length:int = p.readInt32();
            var bd:ByteArray = new ByteArray();
            bd.endian = Endian.LITTLE_ENDIAN;
            p.readBytes(bd, 0, length);
            // 加载数据
            loaderRgb = new Loader();
            loaderRgb.contentLoaderInfo.addEventListener(Event.COMPLETE, onContentCompleteRgb);
            loaderRgb.loadBytes(bd);
            readyRgb = false;
         }
         if(channels >= 2){
            // 加载A通道
            length = p.readInt32();
            bd = new ByteArray();
            bd.endian = Endian.LITTLE_ENDIAN;
            p.readBytes(bd, 0, length);
            // 加载数据
            loaderA = new Loader();
            loaderA.contentLoaderInfo.addEventListener(Event.COMPLETE, onContentCompleteA);
            loaderA.loadBytes(bd);
            readyA = false;
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         size = null;
         padding = null;
         if(colorData){
            colorData.length = 0;
            colorData = null;
         }
         if(loaderRgb){
            loaderRgb.unload();
            loaderRgb = null;
         }
         if(alphaData){
            alphaData.length = 0;
            alphaData = null;
         }
         if(loaderA){
            loaderA.unload();
            loaderA = null;
         }
      }
   }
}