package mo.cr.console.resource
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BitmapDataChannel;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.console.resource.RResource;
   import mo.cm.core.device.RFatal;
   import mo.cm.geom.RGeom;
   import mo.cm.stream.IInput;
   
   //============================================================
   // <T>位图JPEG数据。</T>
   //============================================================
   public class FCrBitmapDataJpg extends FCrBitmapData
   {
      // 通道数目
      public var channels:int;
      
      // RGB数据
      public var dataRgb:ByteArray
      
      // RGB加载器
      public var loaderRgb:Loader;
      
      // RGB准备好
      public var readyRgb:Boolean;
      
      // A数据
      public var bitmapRgb:BitmapData;

      // A数据
      public var dataA:ByteArray
      
      // A数据
      public var bitmapA:BitmapData;
      
      // A加载器
      public var loaderA:Loader;
      
      // A准备好
      public var readyA:Boolean;
      
      // Rgb准备好
      public var mergeRgb:Boolean;

      // A准备好
      public var mergeA:Boolean;
      
      //============================================================
      // <T>构造位图JPEG数据。</T>
      //============================================================
      public function FCrBitmapDataJpg():void{
         typeName = ECrBitmapData.JpgStr;
      }
      
      //============================================================
      // <T>反序列化颜色RGB通道。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onContentCompleteRgb(e:Event):void{
         // 获得位图
         var d:Bitmap = loaderRgb.content as Bitmap;
         if(1 == channels){
            mergeRgb = true;
            bitmapRgb = null;
            bitmapData = d.bitmapData;
         }else if(2 == channels){
            mergeRgb = false;
            bitmapRgb = d.bitmapData.clone();
            //bitmapData = new BitmapData(d.width, d.height, true, 0xFFFFFFFF);
            //bitmapData.copyPixels(d.bitmapData, d.bitmapData.rect, RGeom.EmptyPoint);
            d.bitmapData.dispose();
         }
         d.bitmapData = null;
         // 释放资源
         loaderRgb.unload();
         loaderRgb = null;
         // 处理完成
         readyRgb = true;
      }
      
      //============================================================
      // <T>反序列化颜色A通道。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onContentCompleteA(e:Event):void{
         // 获得位图
         var d:Bitmap = e.currentTarget.content;
         bitmapA = d.bitmapData;
         // 处理完成
         readyA = true;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function unserialize(p:IInput):void{
         RResource.PictureJpgCount++;
         // 获得数据内容
         size.unserialize16(p);
         // 获取有效区域
         validLocation.unserialize16(p);
         validSize.unserialize16(p);
         // 获得边界
         if(bitmapData){
            RFatal.throwFatal("Bitmap is already exists.");
         }
         channels = p.readInt8();
         // 加载RGB数据
         readyRgb = true;
         if(channels >= 1){
            var length:int = p.readInt32();
            dataRgb = new ByteArray();
            dataRgb.endian = Endian.LITTLE_ENDIAN;
            p.readBytes(dataRgb, 0, length);
            readyRgb = false;
         }
         // 加载A数据
         readyA = true;
         if(channels >= 2){
            // 加载A通道
            length = p.readInt32();
            dataA = new ByteArray();
            dataA.endian = Endian.LITTLE_ENDIAN;
            p.readBytes(dataA, 0, length);
            readyA = false;
         }
         // 设置标志
         mergeRgb = false;
         mergeA = (1 == channels);
      }
      
      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public override function process():Boolean{
         // 加载RGB数据
         if(null != dataRgb){
//            var lc:LoaderContext = new LoaderContext();
//            lc.imageDecodingPolicy = ImageDecodingPolicy.ON_DEMAND;
            loaderRgb = new Loader();
            loaderRgb.contentLoaderInfo.addEventListener(Event.COMPLETE, onContentCompleteRgb);
            loaderRgb.loadBytes(dataRgb);
//            loaderRgb.loadBytes(dataRgb, lc);
            dataRgb.clear();
            dataRgb = null;
            return false;
         }
         // 加载A数据
         if(null != dataA){
//            var la:LoaderContext = new LoaderContext();
//            la.imageDecodingPolicy = ImageDecodingPolicy.ON_DEMAND;
            loaderA = new Loader();
            loaderA.contentLoaderInfo.addEventListener(Event.COMPLETE, onContentCompleteA);
            loaderA.loadBytes(dataA);
//            loaderA.loadBytes(dataA, la);
            dataA.clear();
            dataA = null;
            return false;
         }
         // 复制图片
         if(readyRgb && !mergeRgb){
            if(null != bitmapRgb){
               bitmapData = new BitmapData(bitmapRgb.width, bitmapRgb.height, true, 0xFFFFFFFF);
               bitmapData.copyPixels(bitmapRgb, bitmapRgb.rect, RGeom.EmptyPoint);
               bitmapRgb.dispose();
               bitmapRgb = null;
               mergeRgb = true;
            }
            return false;
         }
         // 合并通道
         if(mergeRgb && !mergeA){
            if(null != bitmapA){
               bitmapData.copyChannel(bitmapA, bitmapA.rect, RGeom.EmptyPoint, BitmapDataChannel.RED, BitmapDataChannel.ALPHA);
               // 释放资源
               bitmapA.dispose();
               bitmapA = null;
               // 合并成功
               mergeA = true;
            }
            return false;
         }
         // 测试是否准备好
         ready = readyRgb && readyA && mergeRgb && mergeA;
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != dataRgb){
            dataRgb.clear();
            dataRgb = null;
         }
         if(null != loaderRgb){
            loaderRgb.unload();
            loaderRgb = null;
         }
         if(null != dataA){
            dataA.clear();
            dataA= null;
         }
         if(null != bitmapA){
            bitmapA.dispose();
            bitmapA = null;
         }
         if(null != loaderA){
            loaderA.unload();
            loaderA = null;
         }
         super.dispose();
      }
   }
}