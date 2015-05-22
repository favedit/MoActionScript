package mo.cr.console.resource
{
   import flash.display.BitmapData;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.console.resource.RResource;
   import mo.cm.core.device.RFatal;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>索引位图数据。</T>
   //============================================================
   public class FCrBitmapDataBlockIndex extends FCrBitmapDataIndex
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrBitmapDataIndex);
      
      // 分块当前
      public var blockCurrent:int;
      
      // 分块总数
      public var blockCount:int;
      
      // 颜色数据
      public var colorData:ByteArray;
      
      //============================================================
      // <T>构造索引位图数据。</T>
      //============================================================
      public function FCrBitmapDataBlockIndex(){
         typeName = ECrBitmapData.BlockIndexStr;
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
         RResource.PictureBlockIndexCount++;
         // 读取设置
         optionAlpha = p.readBoolean();
         // 读取属性
         size.unserialize16(p);
         validLocation.unserialize16(p);
         validSize.unserialize16(p);
         blockCurrent = 0;
         blockCount = p.readUint16();
         // 读取数据
         data = new ByteArray();
         data.endian = Endian.LITTLE_ENDIAN;
         var l:int = p.readUint32();
         p.readBytes(data, 0, l);
         data.position = 0;
         // 创建输出
         colorData = new ByteArray();
         colorData.endian = Endian.LITTLE_ENDIAN;
         colorData.length = 4 * validSize.width * validSize.height;
      }
      
      //============================================================
      // <T>解压一个图块。</T>
      //============================================================
      public function processBlock():void{
         // 解压数据
         RCrResource.vendor.blockDecompress(data, colorData);
         blockCurrent++;
      }
      
      //============================================================
      // <T>解压一个图块。</T>
      //============================================================
      public function processBitmap():void{
         // 释放原始数据
         data.clear();
         data = null;
         // 创建图片
         if(bitmapData){
            RFatal.throwFatal("Bitmap is already exists.");
         }
         colorData.position = 0;
         bitmapData = new BitmapData(validSize.width, validSize.height);
         bitmapData.setPixels(new Rectangle(0, 0, validSize.width, validSize.height), colorData);
         // 释放资源
         colorData.clear();
         colorData = null;
         // 准备完毕
         ready = true;
      }

      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public override function process():Boolean{
         if(!ready){
            if(blockCurrent < blockCount){
               processBlock();
               if(blockCurrent == blockCount){
                  processBitmap();
               }
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != colorData){
            colorData.clear();
            colorData = null;
         }
         super.dispose();
      }
   }
}