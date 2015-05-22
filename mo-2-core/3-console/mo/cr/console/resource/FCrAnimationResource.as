package mo.cr.console.resource
{
   import mo.cm.console.loader.ELoader;
   import mo.cm.console.resource.FStreamResource;
   import mo.cm.core.device.RFatal;
   import mo.cm.core.ui.EDirection;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   import mo.cr.console.RCrConsole;
   
   //============================================================
   // <T>图片资源。</T>
   //============================================================
   public class FCrAnimationResource extends FStreamResource
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrAnimationResource);
      
      // 设置合并
      public var optionData:Boolean;

      // 设置空白
      public var optionPadding:Boolean;
      
      // 大小
      public var size:SIntSize2;
      
      // 重心
      public var barycenter:SIntPoint2;
      
      // 帧总数
      public var frameCount:int;
      
      // 关键帧
      public var frameKey:int;
      
      // 关键帧
      public var frameDelays:Vector.<int>;
      
      // 位图总数
      public var bitmapCount:int;

      // 剪辑集合
      public var clips:Vector.<FCrAnimationClip>;
      
      // 图片数据
      public var data:FCrBitmapData;

      //============================================================
      // <T>构造图片资源。</T>
      //============================================================
      public function FCrAnimationResource(){
         typeName = ECrResource.Animation;
         loaderCd = ELoader.Data;
         timeout = 10000;
      }
      
      //============================================================
      // <T>计算实际内存大小。</T>
      //
      // @return 内存大小
      //============================================================
      public override function calculateMemoryBytes():int{
         var r:int = 0;
         if(null != clips){
            var c:int = clips.length;
            for(var n:int = 0; n < c; n++){
               var ac:FCrAnimationClip = clips[n];
               if(null != ac){
                  r += ac.calculateMemoryBytes();
               }
            }
         }
         return r;
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
      // <T>获得第一个可用的动画剪辑。</T>
      //
      // @return 动画剪辑
      //============================================================
      public function get available():FCrAnimationClip{
         if(ready){
            var c:int = clips.length;
            for(var n:int = 0; n < c; n++){
               var ac:FCrAnimationClip = clips[n];
               if(ac){
                  if(null != ac.frames){
                     return ac;
                  }
               }
            }
         }
         return null;
      }
      
      //============================================================
      // <T>临时创建反转剪辑（临时功能）（已修改为正常功能）。</T>
      //============================================================
      public function reverseClips():void{
         var c:int = clips.length;
         for(var n:int = 0; n < c; n++){
            var ac:FCrAnimationClip = clips[n];
            if(ac && ac.reverseOption){
               ac.reverseFrom(clips[ac.reverseDirection]);
            }
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化信息内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function unserializeInfo(p:IInput):void{
         bitmapCount = 0;
         // 反序列化处理
         super.unserializeInfo(p);
         // 读取设置
         optionData = p.readBoolean();
         // 读取属性
         size = new SIntSize2();
         size.unserialize16(p);
         barycenter = new SIntPoint2();
         barycenter.unserialize16(p);
         frameCount = p.readUint16();
         frameKey = p.readUint16();
         if(frameCount > 0){
            frameDelays = new Vector.<int>(frameCount, true);
            for(var dn:int = 0; dn < frameCount; dn++){
               frameDelays[dn] = p.readUint16();
            }
         }
         // 创建数组
         if(null != clips){
            RFatal.throwFatal("Clip vector is already exist.");
         }
         clips = new Vector.<FCrAnimationClip>(EDirection.Count, true);
         // 读取帧集合
         var c:int = p.readUint8();
         for(var n:int = 0; n < c; n++){
            var ac:FCrAnimationClip = new FCrAnimationClip();
            ac.animation = this;
            ac.unserializeInfo(p);
            clips[ac.directionCd] = ac;
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容</T>
      //
      // @param p:input 输入流
      //============================================================
      public override function unserializeData(p:IInput):void{
         // 反序列化处理
         super.unserializeData(p);
         // 读取帧集合
         var c:int = clips.length;
         for(var n:int = 0; n < c; n++){
            var ac:FCrAnimationClip = clips[n];
            if(null != ac){
               ac.unserializeData(p);
            }
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
            if(null != clips){
               var c:int = clips.length;
               for(var n:int = 0; n < c; n++){
                  var ac:FCrAnimationClip = clips[n];
                  if(null != ac){
                     if(!ac.testReady()){
                        return false;
                     }
                  }
               }
               ready = true;
            }
         }
         return ready;
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
         // 处理数据
         if(!ready){
            // 数据处理
            if(null != data){
               if(!data.ready){
                  return false;
               }
            }
            // 桢集合处理
            var c:int = clips.length;
            for(var n:int = 0; n < c; n++){
               var ac:FCrAnimationClip = clips[n];
               if(null != ac){
                  if(ac.testReady()){
                     continue;
                  }
                  ac.process();
                  break;
               }
            }
         }
         // 测试是否准备好
         if(testReady()){
            // 反转剪辑
            reverseClips();
            // 释放数据
            if(null != data){
               data.dispose();
               data = null;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function onFree():void{
         size = null;
         barycenter = null;
         frameDelays = null;
         // 释放剪辑
         if(null != clips){
            var c:int = clips.length;
            for(var n:int = 0; n < c; n++){
               var ac:FCrAnimationClip = clips[n];
               if(null != ac){
                  ac.dispose();
               }
               clips[n] = null;
               
            }
            clips = null;
         }
         super.onFree();
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         size = null;
         barycenter = null;
         frameDelays = null;
         // 释放数据
         if(null != data){
            data.dispose();
            data = null;
         }
         // 释放所有帧
         if(null != clips){
            var c:int = clips.length;
            for(var n:int = 0; n < c; n++){
               var ac:FCrAnimationClip = clips[n];
               if(null != ac){
                  ac.dispose();
                  clips[n] = null;
               }
            }
            clips = null;
         }
         // 释放资源
         super.dispose();
      }
   }
}