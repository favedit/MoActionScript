package mo.cm.core.device
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.display.StageDisplayState;
   import flash.text.TextField;
   
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SFloatPoint3;
   import mo.cm.geom.SIntSize2;
   
   //============================================================
   // <T>屏幕管理器。</T>
   //============================================================
   public class RScreen
   {
      // 容器对象
      public static var container:Sprite;
      
      // 舞台对象
      public static var stage:Stage;
      
      // 屏幕尺寸
      public static var size:SIntSize2 = new SIntSize2(800, 600);
      
      // 屏幕消息
      public static var message:FScreenMessage = new FScreenMessage();

      // 帧速
      public static var frameRate:Number = 60;

      // 近平面
      public static var znear:Number = 10;
      
      // 远平面
      public static var zfar:Number = 1000;

      // 舞台质量
      public static var stageQuality:String;
      
      // 舞台质量状态
      public static var stageQualityStatus:String;
      
      // 蒙板层
      public static var mask:FSprite = new FSprite();
      
      // 蒙板层显示文本
      public static var maskTitle:TextField = new TextField();
      
      //============================================================
      // <T>选择容器。</T>
      //
      // @param p:container 容器对象
      //============================================================
      public static function selectContainer(p:Sprite):void{
         // 设置环境
         container = p;
         stage = p.stage;
         frameRate = stage.frameRate;
         // 消息设置
         message.setup(stage);
         // 刷新处理
         refresh();
      }
      
      //============================================================
      // <T>开启蒙板。</T>
      //
      // @return 全屏
      //============================================================
      public static function opMask():void{
         maskTitle.htmlText = "<font size='40' color='#ffffff'>加载中，请稍候！</font>";
         maskTitle.autoSize = "center";
//         setSprite(mask);
//         mask.x = 0;
//         mask.y = 0;
         stage.addChild(maskTitle);
//         mask.addChild(maskTitle);
         maskTitle.x = (stage.stageWidth - maskTitle.width) / 2;
         maskTitle.y = (stage.stageWidth - maskTitle.height) / 2;
      }
      
      //============================================================
      // <T>关闭蒙板。</T>
      //
      // @return 全屏
      //============================================================
      public static function closeMask():void{
//         if(mask.parent){
//            mask.parent.removeChild(mask);
//            mask.removeChild(maskTitle);
//         }
         if(maskTitle.parent){
            maskTitle.parent.removeChild(maskTitle);
         }
      }
      
      //============================================================
      // <T>设置遮罩层。</T>
      //
      // @return 全屏
      //============================================================
      public static function setSprite(s:FSprite):void{
         var g:Graphics = s.graphics;
         g.beginFill(0xffee00, 0);
         g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
         g.endFill();
         stage.addChild(s);
      }
//      
//      //============================================================
//      // <T>锁定屏幕兵添加显示对象。</T>
//      //
//      // @return 全屏
//      //============================================================
//      public static function lockScreen(dis:FSprite, location:SIntPoint2):void{
//         setSprite(loack);
//         loack.addChild(dis);
//         dis.x = location.x;
//         dis.y = location.y;
//      }
//      
//      //============================================================
//      // <T>接触屏幕锁定。</T>
//      //
//      // @return 全屏
//      //============================================================
//      public static function unLockScreen():void{
//         loack.clear();
//         if(loack.parent){
//            loack.parent.removeChild(loack);
//         }
//      }

      //============================================================
      // <T>获取屏幕是否全屏。</T>
      //
      // @return 全屏
      //============================================================
      public static function get fullScreen():Boolean{
         return (StageDisplayState.FULL_SCREEN == stage.displayState);
      }
      
      //============================================================
      // <T>设置屏幕是否全屏。</T>
      //
      // @param p:value 全屏
      //============================================================
      public static function set fullScreen(p:Boolean):void{
         var s:Stage = stage;
         if(p){
            s.displayState = StageDisplayState.FULL_SCREEN;
         }else{
            s.displayState = StageDisplayState.NORMAL;
         }
         stage.frameRate = frameRate;
      }
      
      //============================================================
      // <T>设置屏幕是否全屏反转。</T>
      //============================================================
      public static function fullScreenInvert():void{
         var s:Stage = stage;
         if(s.displayState == StageDisplayState.NORMAL){
            s.displayState = StageDisplayState.FULL_SCREEN;
         }else{
            s.displayState = StageDisplayState.NORMAL;
         }
         stage.frameRate = frameRate;
      }
      
      //============================================================
      // <T>记录舞台品质。</T>
      //============================================================
      public static function qualityStore():void{
         if((null != stage) && (null != stageQuality)){
            stageQualityStatus = stage.quality;
            if(stageQualityStatus != stageQuality){
               stage.quality = stageQuality;
            }
         }
      }

      //============================================================
      // <T>回复舞台品质。</T>
      //============================================================
      public static function qualityRestore():void{
         if((null != stage) && (null != stageQuality)){
            stage.quality = stageQualityStatus;
         }
      }

      //============================================================
      // <T>刷新内容。</T>
      //============================================================
      public static function refresh():void{
         if(null != stage){
            size.set(stage.stageWidth, stage.stageHeight);
         }
      }
      
      //============================================================
      // <T>获得舞台大小。</T>
      //
      // @param p:size 大小
      //============================================================
      public static function getStageSize(p:SIntSize2):Boolean{
         if(null != stage){
            p.width = stage.stageWidth;
            p.height = stage.stageHeight;
            return true;
         }
         return false;
      }
	  
	  //============================================================
	  // <T>返回当前鼠标坐标。</T>
	  //============================================================
	  public static function mousePoint():SFloatPoint3{
		 var p:SFloatPoint3 = new SFloatPoint3();
		 p.set(stage.mouseX, stage.mouseY, 0);
		 return p;
	  }
   }
}