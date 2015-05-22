package mo.cr.console.resource
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.cache.FCacheStream;
   import mo.cm.cache.RCache;
   import mo.cm.console.resource.RResource;
   import mo.cm.core.device.RFatal;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>索引位图数据。</T>
   //============================================================
   public class FCrBitmapDataIndex extends FCrBitmapData
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrBitmapDataIndex);
      
      // 设置信息
      public var optionAlpha:Boolean;
      
      // 数据
      public var data:ByteArray;

      //============================================================
      // <T>构造索引位图数据。</T>
      //============================================================
      public function FCrBitmapDataIndex(){
         typeName = ECrBitmapData.IndexStr;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function unserialize(p:IInput):void{
         // 检查参数
         if(bitmapData){
            RFatal.throwFatal("Bitmap is already exists.");
         }
         RResource.PictureIndexCount++;
         // 读取设置
         optionAlpha = p.readBoolean();
         // 读取属性
         size.unserialize16(p);
         validLocation.unserialize16(p);
         validSize.unserialize16(p);
         // 读取数据
         var l:int = p.readInt32();
         data = new ByteArray();
         data.endian = Endian.LITTLE_ENDIAN;
         p.readBytes(data, 0, l);
         data.position = 0;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function process():Boolean{
         if(null != data){
            // 解压缩数据
            var size:int = 4 * validSize.width * validSize.height;
            var cs:FCacheStream = RCache.allocStream(size);
            RCrResource.vendor.blockDecompress(data, cs.data);
            // 创建图片
            if(bitmapData){
               RFatal.throwFatal("Bitmap is already exists.");
            }
            cs.position = 0;
            bitmapData = new BitmapData(validSize.width, validSize.height);
            bitmapData.setPixels(bitmapData.rect, cs.memory);
            // 释放资源
            RCache.freeStream(cs);
            data.clear();
            data = null;
            // 读取数据
            ready = true;
         }
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
      }
   }
}