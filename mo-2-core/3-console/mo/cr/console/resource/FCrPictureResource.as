package mo.cr.console.resource
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.ByteArray;
   
   import mo.cm.console.loader.ELoader;
   import mo.cm.console.resource.FStreamResource;
   import mo.cm.core.device.RFatal;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   import mo.cr.console.RCrConsole;
   
   //============================================================
   // <T>图片资源。</T>
   //============================================================
   public class FCrPictureResource extends FStreamResource
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrPictureResource);
      
      // 设置空白
      public var optionPadding:Boolean;
      
      // 大小
      public var size:SIntSize2;
      
      // 有效坐标
      public var validLocation:SIntPoint2;
      
      // 有效大小
      public var validSize:SIntSize2;
      
      // 图片数据
      public var data:FCrBitmapData;
      
      // 存储图片数据
      public var compressData:ByteArray;
      
      // 位图大小
      public var bitmapSize:SIntSize2;
      
      // 位图数据
      public var bitmapData:BitmapData;
      
      //============================================================
      // <T>构造图片资源。</T>
      //============================================================
      public function FCrPictureResource(){
         typeName = ECrResource.Picture;
         loaderCd = ELoader.Data;
         timeout = 10000;
      }
      
      //============================================================
      // <T>获得宽度。</T>
      // 
      // @return 宽度
      //============================================================
      [Inline]
      public final function get width():int{
         return size.width;
      }
      
      //============================================================
      // <T>获得高度。</T>
      // 
      // @return 高度
      //============================================================
      [Inline]
      public final function get height():int{
         return size.height;
      }
      
      //============================================================
      // <T>从输入流里反序列化信息内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function unserializeInfo(p:IInput):void{
         super.unserializeInfo(p);
         // 加载数据
         optionPadding = p.readBoolean();
         size = new SIntSize2();
         size.unserialize16(p);
         validLocation = new SIntPoint2();
         validLocation.unserialize16(p);
         validSize = new SIntSize2();
         validSize.unserialize16(p);
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function unserializeData(p:IInput):void{
         super.unserializeData(p);
         // 加载图片
         data = RCrResource.vendor.createBitmap(p.readString());
         data.unserialize(p);
         RCrConsole.resourceConsole.processBitmap(data);
      }
      
      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public override function onProcess():Boolean{
         // 读取数据
         if(null != stream){
            if(stream.ready){
               unserializeData(stream);
               stream.dispose();
               stream = null;
            }else{
               return false;
            }
         }
         // 读取数据
         if(!ready){
            // 处理图片
            if(null != data){
               if(!data.ready){
                  return false;
               }
               // 复制数据到内部
               if(null != bitmapData){
                  RFatal.throwFatal("Bitmap data is already exist.");
               }
               // 判断是否为空
               if(!size.isEmpty()){
                  var bd:BitmapData = data.bitmapData;
                  bitmapSize = new SIntSize2();
                  if(optionPadding){
                     bitmapData = new BitmapData(size.width, size.height, true, 0);
                     bitmapData.copyPixels(bd, bd.rect, new Point(validLocation.x, validLocation.y));
                     bitmapSize.assign(size);
                     memoryBytes = 4 * size.width * size.height;
                  }else{
                     bitmapData = data.flip();
                     bitmapSize.assign(validSize);
                     memoryBytes = 4 * validSize.width * validSize.height;
                  }
               }else{
                  bitmapData = RCrResource.emptyBitmapData;
               }
               // 释放数据
               data.dispose();
               data = null;
               // 数据已经准备好
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function onFree():void{
         size = null;
         validLocation = null;
         validSize = null;
         if(null != data){
            data.dispose();
            data = null;
         }
         if(null != bitmapData){
            bitmapData.dispose();
            bitmapData = null;
         }
         super.onFree();
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         // 释放数据
         size = null;
         validLocation = null;
         validSize = null;
         bitmapSize = null;
         // 释放数据
         if(null != data){
            data.dispose();
            data = null;
         }
         // 释放压缩
         if(null != compressData){
            compressData.clear();
            compressData = null;
         }
         // 释放位图
         if(null != bitmapData){
            if(bitmapData != RCrResource.emptyBitmapData){
               bitmapData.dispose();
            }
            bitmapData = null;
         }
         super.dispose();
      }
   }
}