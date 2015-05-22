package mo.cr.console.resource
{
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.ByteArray;
   
   import mo.cm.core.device.EDrawMode;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.device.RGlobal;
   import mo.cm.geom.RGeom;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.FFatalUnsupportError;
   import mo.cm.system.ILogger;
   import mo.cr.console.RCrConsole;
   
   //============================================================
   // <T>动画帧资源。</T>
   //============================================================
   public class FCrAnimationFrame extends FObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrAnimationFrame);
      
      // 处理数量
      public static var processCount:int;
      
      // 处理限制
      public static var processLimit:int = 8;
      
      // 动画资源
      public var animation:FCrAnimationResource;
      
      // 剪辑资源
      public var clip:FCrAnimationClip;
      
      // 准备好
      public var ready:Boolean;
      
      // 代码
      public var code:int;

      // 配置合并
      public var optionData:Boolean;

      // 配置为空
      public var optionEmpty:Boolean;
      
      // 延迟
      public var delay:int;
      
      // 大小
      public var size:SIntSize2;
      
      // 合并坐标
      public var mergeLocation:SIntPoint2;

      // 有效坐标
      public var validLocation:SIntPoint2;
      
      // 有效大小
      public var validSize:SIntSize2;
      
      // 重心坐标
      public var barycenter:SIntPoint2;
      
      // 图片数据
      public var data:FCrBitmapData;
      
      // 内存大小
      public var memoryBytes:int;
      
      // 压缩标志
      public var compressed:Boolean;
      
      // 压缩大小
      public var compressBytes:int;
      
      // 压缩数据
      public var compressData:ByteArray
      
      // 位图大小
      public var bitmapSize:SIntSize2;
      
      // 位图数据
      public var bitmapData:BitmapData;
      
      // 反转帧
      public var reverseFrame:FCrAnimationFrame;
      
      //============================================================
      // <T>构造。</T>
      //============================================================
      public function FCrAnimationFrame(){
      }
      
      //============================================================
      // <T>是否有效帧。</T>
      //============================================================
      public function testValid():Boolean{
         if(!optionEmpty){
            return (null != bitmapData);
         }
         return false;
      }
      
      //============================================================
      // <T>获得翻转后的帧。</T>
      //
      // @param p:frame 反转的帧
      //============================================================
      public function reverseFrom(p:FCrAnimationFrame):void{
         optionEmpty = p.optionEmpty;
         delay = p.delay;
         if(!optionEmpty){
            size = new SIntSize2();
            size.assign(p.size);
            barycenter = new SIntPoint2();
            barycenter.x = size.width - p.barycenter.x;
            barycenter.y = p.barycenter.y;
            validLocation = new SIntPoint2();
            validLocation.assign(p.validLocation);
            validSize = new SIntSize2();
            validSize.assign(p.validSize);
            // 检查对象
            if(null != bitmapData){
               RFatal.throwFatal("Bitmap data is already exists.");
               return;
            }
            // 绘制处理
            switch(RGlobal.drawMode){
               case EDrawMode.Copy:
                  // 反转图片
                  var m:Matrix = ECrReverse.levelMatrix;
                  m.tx = size.width;
                  // TODO: 临时判断
                  if(!size.isEmpty()){
                     bitmapData = new BitmapData(size.width, size.height, true, 0x00000000);
                     bitmapData.draw(p.bitmapData, m);
                  }else{
                     bitmapData = new BitmapData(1, 1, true, 0);
                  }
                  memoryBytes = p.memoryBytes;
                  break;
               case EDrawMode.Draw:
                  // 反转图片
                  bitmapData = p.bitmapData;
                  memoryBytes = 0;
                  break;
               default:
                  throw new FFatalUnsupportError(); 
            }
            reverseFrame = p;
         }
         ready = true;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserializeInfo(p:IInput):void{
         // 读取属性
         code = p.readInt32();
         optionData = p.readBoolean();
         optionEmpty = p.readBoolean();
         delay = p.readInt32();
         // 读取数据
         if(!optionEmpty){
            // 读取位置
            if(null != size){
               RFatal.throwFatal("Size is already exists.");
            }
            size = new SIntSize2();
            size.unserialize16(p);
            // 读取位置
            if(null != validLocation){
               RFatal.throwFatal("Valid location is already exists.");
            }
            validLocation = new SIntPoint2();
            validLocation.unserialize16(p);
            // 读取尺寸
            if(null != validSize){
               RFatal.throwFatal("Valid size is already exists.");
            }
            validSize = new SIntSize2();
            validSize.unserialize16(p);
            // 读取重心
            if(null != barycenter){
               RFatal.throwFatal("Barycenter is already exists.");
            }
            barycenter = new SIntPoint2();
            barycenter.unserialize16(p);
            // 读取位图
            animation.bitmapCount++;
            clip.bitmapCount++;
            if(!optionData){
               // 合并处理
               if(null != mergeLocation){
                  RFatal.throwFatal("Merge location is already exists.");
               }
               mergeLocation = new SIntPoint2();
               mergeLocation.unserialize16(p);
            }
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserializeData(p:IInput):void{
         // 读取数据
         if(optionData){
            // 修改属性
            animation.bitmapCount++;
            clip.bitmapCount++;
            // 读取位图
            if(null != data){
               RFatal.throwFatal("Data is already exists.");
            }
            data = RCrResource.vendor.createBitmap(p.readString());
            data.unserialize(p);
            RCrConsole.resourceConsole.processBitmap(data);
         }
      }
      
      //============================================================
      // <T>测试是否准备好。</T>
      //
      // @return 准备好
      //============================================================
      public function testReady():Boolean{
         return ready;
      }
      
      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function process():Boolean{
         // 数据为空
         if(optionEmpty){
            ready = true;
            return true;
         }
         // 读取数据
         if(!ready){
            if(animation.optionData){
               // 检查动画资源
               if(null == animation.data){
                  return false;
               }
               if(!animation.data.ready){
                  return false;
               }
               // 复制数据到内部
               if(null != bitmapData){
                  RFatal.throwFatal("Bitmap data is already exists.");
               }
               if(!size.isEmpty()){
                  var ad:BitmapData = animation.data.bitmapData;
                  if(animation.optionPadding){
                     bitmapData = new BitmapData(size.width, size.height, true, 0);
                     bitmapData.copyPixels(ad, new Rectangle(mergeLocation.x, mergeLocation.y, size.width, size.height), new Point(validLocation.x, validLocation.y));
                     bitmapSize = size;
                     memoryBytes = 4 * size.width * size.height;
                  }else{
                     if(1 == animation.bitmapCount){
                        bitmapData = animation.data.flip();
                     }else{
                        bitmapData = new BitmapData(validSize.width, validSize.height, true, 0);
                        bitmapData.copyPixels(ad, new Rectangle(mergeLocation.x, mergeLocation.y, validSize.width, validSize.height), RGeom.EmptyPoint);
                     }
                     bitmapSize = validSize;
                     memoryBytes = 4 * validSize.width * validSize.height;
                  }
               }else{
                  bitmapData = RCrResource.emptyBitmapData;
               }
               // 数据已经准备好
               ready = true;
            }else if(clip.optionData){
               // 检查动画资源
               if(null == clip.data){
                  return false;
               }
               if(!clip.data.ready){
                  return false;
               }
               // 复制数据到内部
               if(null != bitmapData){
                  RFatal.throwFatal("Bitmap data is already exists.");
               }
               if(!size.isEmpty()){
                  var cd:BitmapData = clip.data.bitmapData;
                  if(animation.optionPadding){
                     bitmapData = new BitmapData(size.width, size.height, true, 0);
                     bitmapData.copyPixels(cd, new Rectangle(mergeLocation.x, mergeLocation.y, size.width, size.height), new Point(validLocation.x, validLocation.y));
                     bitmapSize = size;
                     memoryBytes = 4 * size.width * size.height;
                  }else{
                     if(1 == clip.bitmapCount){
                        bitmapData = clip.data.flip();
                     }else{
                        bitmapData = new BitmapData(validSize.width, validSize.height, true, 0);
                        bitmapData.copyPixels(cd, new Rectangle(mergeLocation.x, mergeLocation.y, validSize.width, validSize.height), RGeom.EmptyPoint);
                     }
                     bitmapSize = validSize;
                     memoryBytes = 4 * validSize.width * validSize.height;
                  }
               }else{
                  bitmapData = RCrResource.emptyBitmapData;
               }
               // 数据已经准备好
               ready = true;
            }else{
               // 处理图片
               if(null != data){
                  if(!data.ready){
                     return false;
                  }
                  // 复制数据到内部
                  if(null != bitmapData){
                     RFatal.throwFatal("Bitmap data is already exists.");
                  }
                  if(!size.isEmpty()){
                     ad = data.bitmapData;
                     if(animation.optionPadding){
                        bitmapData = new BitmapData(size.width, size.height, true, 0);
                        bitmapData.copyPixels(ad, ad.rect, new Point(validLocation.x, validLocation.y));
                        bitmapSize = validSize;
                        memoryBytes = 4 * size.width * size.height;
                     }else{
                        bitmapData = data.flip();
                        bitmapSize = validSize;
                        memoryBytes = 4 * validSize.width * validSize.height;
                     }
                  }else{
                     bitmapData = RCrResource.emptyBitmapData;
                  }
                  data.dispose();
                  data = null;
                  // 数据已经准备好
                  ready = true;
               }
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         // 释放数据
         animation = null;
         clip = null;
         size = null;
         validLocation = null;
         validSize = null;
         barycenter = null;
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
         // 释放位图（不释放反转位图引用）
         if(null != bitmapData){
            if(null != reverseFrame){
               if(RGlobal.drawMode == EDrawMode.Copy){
                  if(bitmapData != RCrResource.emptyBitmapData){
                     bitmapData.dispose();
                  }
               }
            }else{
               if(bitmapData != RCrResource.emptyBitmapData){
                  bitmapData.dispose();
               }
            }
            bitmapData = null;
         }
         super.dispose();
      }
   }
}