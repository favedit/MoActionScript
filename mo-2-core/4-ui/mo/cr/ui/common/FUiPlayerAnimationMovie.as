package mo.cr.ui.common
{
   import mo.cr.console.resource.FCrAnimationClip;

   public class FUiPlayerAnimationMovie
   {
      // 播放类型
      public var playCd:int;
      
      // 帧速率
      public var frameRate:Number;
      
      // 当前播放的动画
      public var clip:FCrAnimationClip;
      
      // 当前播放的帧数索引
      public var currFameIndex:int;
      
      // 帧数总数
      public var frameCount:int;
      
      // 循环数
      public var loop:int;
      
      // 比率
      public var rate:Number = 1;

      //============================================================
      // <T>构造资源动画。</T>
      //============================================================
      public function FUiPlayerAnimationMovie(){
      }
      
      //============================================================
      // <T>更新处理。</T>
      //============================================================
      public function update():void{
         // 设置帧数
         frameCount = clip.frames.length;
         currFameIndex = 0;
      }
   }
}