package mo.cr.ui.control
{
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.common.FUiPlayer;
   import mo.cr.ui.common.SUiPlayerAction;
   import mo.cr.ui.layout.EGeMovieAction;

   public class FUiAnimationMovie extends FUiControl3d
   {
      // 背景容器
      public var contentContainer:FSprite = new FSprite();
      
      // 动画播放器
      public var player:FUiPlayer = new FUiPlayer();
      
      // 对齐方式
      public var align:String;
      
      // 名称
      public var action:String = EGeMovieAction.Invisible;
      
      // 循环数
      public var loop:int;
      
      // 方向
      public var direction:int;
      
      // 资源动画名称
      public var rid:String;
      
      // 是否立即播放动画
      public var isPlay:Boolean = false;
      
      // 第一次循环完成
      public var lsnsFlistener:FListeners = RAllocator.create(FListeners);
      
      public var context:FUiContext;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120427
      //==========================================================
      public function FUiAnimationMovie(){
         display = contentContainer;
         type = EUiControlType.AnimationMovie;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
         player.lsnsFlistener.register(loopOver, this);
         mouseEnable(false);
      }
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function mouseEnable(bool:Boolean):void{
         contentContainer.mouseChildren = bool;
         contentContainer.mouseEnabled = bool;
      }
      
      //===========================================================
      // <T>一个循环完成。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public function loopOver(e:FEvent):void{
         lsnsFlistener.process();
      }
      
      //===========================================================
      // <T> 设置文字。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         action = p.get("action");
         loop = p.getInt("loop");
         direction = p.getInt("direction");
         rid = p.get("rid");
         isPlay = p.getBoolean("isplay");
         paint();
      }
      
      //============================================================
      // <T>播放动画命令。</T>
      //
      // @param pa:actionCd 动作类型
      // @param rid:name 动画编号
      // @param dir: 方向
      // @param pc:count 播放次数
      // @param rate 播放平率
      //============================================================
      public function playMovie(rate:int = 0):void{
         isPlay = true;
         var p:SUiPlayerAction = new SUiPlayerAction(action, rid, direction, loop);
         play(p);
         player.frameRate = rate;
      }
      
      //============================================================
      // <T>关闭动画。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function closeMovie():void{
         player.close();
         isPlay = false;
      }
      
      //============================================================
      // <T>保存组件。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("action", action);
         p.set("loop", loop.toString());
         p.set("direction", direction.toString());
         p.set("rid", rid);
         p.set("isplay", isPlay.toString());
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function paint(p:FUiContext = null):void{
         contentContainer.addChild(player.displayObject);
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         ready = true;
         return ready;
      }
      
      //============================================================
      // <T>播放动画命令。</T>
      //
      // @param p:action 命令
      //============================================================
      public function play(p:SUiPlayerAction):void{
         player.play(p);
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         if(isPlay){
            player.process(); 
         }
      }
   }
}