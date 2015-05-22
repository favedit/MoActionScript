package mo.cr.ui.common
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.EDirection;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrAnimationResource;
   import mo.cr.ui.RUiConsole;
   import mo.cr.ui.layout.EGeMovieAction;

   //============================================================
   // <T>播放命令。</T>
   //============================================================
   public class SUiPlayerAction
   {
      // 播放中
      public var playing:Boolean;

      // 开始时刻
      public var startTick:Number;
      
      // 名称
      public var action:String = EGeMovieAction.Invisible;
      
      // 循环数
      public var loop:int;
      
      // 方向
      public var direction:int;
      
      // 资源动画名称
      public var rid:String;
      
      // 资源
      public var resource:FCrAnimationResource;
      
      //============================================================
      // <T>构造播放命令。</T>
      // 
      // @param act 动作类型
      // @param r 动画资源编号
      // @param dir: 方向
      // @param lo 播放次数
      //============================================================
      public function SUiPlayerAction(act:String, r:String, dir:int = 0, lo:int = 1){
         direction = dir;
         action = act;
         rid = r;
         loop = lo;
      }
   }
}