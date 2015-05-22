package mo.cr.ui.common
{
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrAnimationFrame;
   import mo.cr.console.resource.FCrAnimationResource;
   import mo.cr.ui.layout.EGePlay;

   //============================================================
   // <T>播放器。</T>
   //============================================================
   public class FUiPlayer extends FObject
   {
      // 是否在播放
      public var playing:Boolean;
      
      // 显示对象
      public var displayObject:DisplayObject;

      // 位图对象
      public var bitmap:Bitmap = new Bitmap();
      
      // 动画
      public var movie:FUiPlayerAnimationMovie = new FUiPlayerAnimationMovie();

      // 命令集合
      public var actions:Vector.<SUiPlayerAction> = new Vector.<SUiPlayerAction>();
      
      // 检测中的命令集合
      public var testActions:Vector.<SUiPlayerAction> = new Vector.<SUiPlayerAction>();
      
      // 上次播放时间
      public var lastTick:Number = 0;
      
      // 播放速率
      public var frameRate:Number = 0;
      
      // 当前播放帧的总数
      public var frameCount:int = 0;
      
      // 一次播完
      public var lsnsFlistener:FListeners = RAllocator.create(FListeners);
      
      //============================================================
      // <T>构造播放器。</T>
      //============================================================
      public function FUiPlayer(){
         displayObject = bitmap;
//         backContainer.addChild(displayObject);
      }

      //============================================================
      // <T>播放动画命令。</T>
      //
      // @param p:action 命令
      //============================================================
      public function play(p:SUiPlayerAction):void{
         p.resource = RCmConsole.resourceConsole.syncResource(ECrResource.Animation, p.rid.toString()) as FCrAnimationResource;
         testActions.push(p);
         playing = true;
      }
      
      //============================================================
      // <T>设置动画坐标。</T>
      //
      // @param p:action 命令
      //============================================================
      public function setLocation(x:int, y:int):void{
         displayObject.x = x;
         displayObject.y = y;
      }
      
      //============================================================
      // <T>关闭动画。</T>
      //
      // @param p:action 命令
      //============================================================
      public function close():void{
         playing = false;
         movie.loop = 0;
         bitmap.bitmapData = null;
      }
      
      //============================================================
      // <T>动画播放。</T>
      //
      // @param pn:name 动画名称
      // @param pr:rate 播放速率
      // @return 动画对象
      //============================================================
      private function playSwitch(p:SUiPlayerAction):void{
         movie.playCd = EGePlay.parse(p.action);
         movie.loop = p.loop;
         movie.clip = p.resource.clips[p.direction];
         movie.update();
         frameCount =  p.resource.frameCount;
         lastTick = 0;
      }

      //============================================================
      // <T>播放处理。</T>
      //============================================================
      public function process():void{
         testReady();
         // 设置动画
         var m:SUiPlayerAction = null;
         if(0 == movie.loop){
            bitmap.bitmapData = null;
            if(actions.length > 0){
               m = actions.shift();
            }
         }
         if(m){
            playSwitch(m);
         }
         if(playing && movie.loop > 0){
            var currFrame:int = movie.currFameIndex;
            if(movie.clip.frames){
               var frame:FCrAnimationFrame = movie.clip.frames[currFrame];
               frameRate = frameRate == 0 ? frame.delay : frameRate;
               if(RTimer.currentTick - lastTick >= frameRate){
                  var nextFrame:int = currFrame + 1;
                  if(nextFrame >= movie.frameCount){
                     if(movie.playCd != EGePlay.Loop){
                        movie.loop --;
                     }
                     movie.currFameIndex = 0;
                     nextFrame = 0;
                     lsnsFlistener.process();
                  }
                  if(movie.loop > 0){
                     frame = movie.clip.frames[nextFrame];
                     bitmap.bitmapData = frame.bitmapData;
                     //                  bitmap.width = frame.size.width;
                     //                  bitmap.height = frame.size.height;
                     movie.currFameIndex = nextFrame;
                     lastTick = RTimer.currentTick;
                  }
               }
            }
         }
      }
      
      //============================================================
      // <T>检查动画是否加载完成。</T>
      //============================================================
      public function testReady():void{
         var c:int = testActions.length;
         for(var n:int = 0; n < c; n++){
            var p:SUiPlayerAction = testActions[n];
            if(p.resource.ready){
               actions.push(p);
               checkLastMovie();
               testActions.splice(n, 1);
               break;
            }
         }
      }
      
      //============================================================
      // <T>检查上一个动画是否为循环播放动画。</T>
      //============================================================
      public function checkLastMovie():void{
         if(movie.playCd == EGePlay.Loop){
            movie.loop = 0;
         }
      }
   }
}