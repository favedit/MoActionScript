package mo.cr.console.resource
{
   import mo.cm.core.device.RFatal;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   import mo.cr.console.RCrConsole;
   
   //============================================================
   // <T>动画剪辑。</T>
   //============================================================
   public class FCrAnimationClip extends FObject
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrAnimationClip);
      
      // 动画资源
      public var animation:FCrAnimationResource;

      // 准备好
      public var ready:Boolean;

      // 设置合并
      public var optionData:Boolean;

      // 方向
      public var directionCd:int;

      // 是否反转
      public var reverseOption:Boolean;
      
      // 反转类型
      public var reverseCd:int;
      
      // 反转来源
      public var reverseDirection:int;
      
      // 大小
      public var size:SIntSize2;

      // 重心
      public var barycenter:SIntPoint2;

      // 延迟
      public var delay:int;

      // 位图总数
      public var bitmapCount:int;

      // 帧集合
      public var frames:Vector.<FCrAnimationFrame>;
      
      // 图片数据
      public var data:FCrBitmapData;

      //============================================================
      // <T>动画剪辑。</T>
      //============================================================
      public function FCrAnimationClip(){
      }
      
      //============================================================
      // <T>计算实际内存大小。</T>
      //
      // @return 内存大小
      //============================================================
      public function calculateMemoryBytes():int{
         var r:int = 0;
         if(null != frames){
            var c:int = frames.length;
            for(var n:int = 0; n < c; n++){
               var af:FCrAnimationFrame = frames[n];
               if(null != af){
                  r += af.memoryBytes;
               }
            }
         }
         return r;
      }
      
      //============================================================
      // <T>计算压缩内存大小。</T>
      //
      // @return 压缩大小
      //============================================================
      public function calculateCompressBytes():int{
         var r:int = 0;
         if(null != frames){
            var c:int = frames.length;
            for(var n:int = 0; n < c; n++){
               var af:FCrAnimationFrame = frames[n];
               if(null != af){
                  r += af.compressBytes;
               }
            }
         }
         return r;
      }

      //============================================================
      // <T>获得指定索引的动画帧。</T>
      //
      // @params p:index 索引
      // @return 动画帧
      //============================================================
      public function frame(p:int):FCrAnimationFrame{
         return frames[p];
      }
      
      //============================================================
      // <T>生成翻转的剪辑。</T>
      //
      // @params clip 要赋值的剪辑
      //============================================================
      public function reverseFrom(p:FCrAnimationClip):void{
         size = new SIntSize2();
         size.assign(p.size);
         barycenter = new SIntPoint2();
         barycenter.assign(p.barycenter);
         delay = p.delay;
         // 复制帧
         var fc:int = p.frames.length;
         frames = new Vector.<FCrAnimationFrame>(fc, true);
         for(var n:int = 0; n < fc; n++){
            var af:FCrAnimationFrame = new FCrAnimationFrame();
            af.reverseFrom(p.frames[n]);
            frames[n] = af;
         }
         ready = true;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserializeInfo(p:IInput):void{
         bitmapCount = 0;
         // 获取方向
         directionCd = p.readInt8();
         // 获取设置
         optionData = p.readBoolean();
         reverseOption = p.readBoolean();
         reverseCd = p.readUint8();
         reverseDirection = p.readUint8();
         // 获取信息
         if(null != size){
            RFatal.throwFatal("Size is already exists.");
         }
         size = new SIntSize2();
         size.unserialize16(p);
         if(null != barycenter){
            RFatal.throwFatal("Barycenter is already exists.");
         }
         barycenter = new SIntPoint2();
         barycenter.unserialize16(p);
         delay = p.readInt32();
         // 读取帧集合
         if(null != frames){
            RFatal.throwFatal("Frame vector is already exist.");
         }
         var c:int = p.readUint8();
         frames = new Vector.<FCrAnimationFrame>(c, true);
         for(var n:int = 0; n < c; n++){
            var af:FCrAnimationFrame = new FCrAnimationFrame();
            af.animation = animation;
            af.clip = this;
            af.unserializeInfo(p);
            frames[n] = af;
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserializeData(p:IInput):void{
         // 读取帧集合
         var c:int = frames.length;
         for(var n:int = 0; n < c; n++){
            frames[n].unserializeData(p);
         }
         // 读取位图
         if(optionData){
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
         if(!ready){
            var c:int = frames.length;
            for(var n:int = 0; n < c; n++){
               if(!frames[n].testReady()){
                  return false;
               }
            }
            ready = true;
         }
         return ready;
      }
      
      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function process():Boolean{
         if(!ready){
            // 数据处理
            if(null != data){
               if(!data.ready){
                  return false;
               }
            }
            // 处理所有帧
            var c:int = frames.length;
            for(var n:int = 0; n < c; n++){
               var af:FCrAnimationFrame = frames[n];
               if(af.testReady()){
                  continue;
               }
               af.process();
               return false;
            }
            // 测试是否成功
            if(testReady()){
               // 释放数据
               if(null != data){
                  data.dispose();
                  data = null;
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
         size = null;
         barycenter = null;
         // 释放数据
         if(null != data){
            data.dispose();
            data = null;
         }
         // 释放所有帧
         if(null != frames){
            var c:int = frames.length;
            for(var n:int = 0; n < c; n++){
               var f:FCrAnimationFrame = frames[n];
               if(null != f){
                  f.dispose();
                  frames[n] = null;
               }
            }
            frames = null;
         }
         // 释放资源
         super.dispose();
      }
   }
}