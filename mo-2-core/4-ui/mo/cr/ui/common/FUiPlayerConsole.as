package mo.cr.ui.common
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.common.FUiPlayer;
   
   //============================================================
   // <T>动画控制台。</T>
   //============================================================
   public class FUiPlayerConsole extends FConsole
   {
      // 线程
      public var thread:FUiPlayerThread = new FUiPlayerThread();
      
      //============================================================
      // <T>构造样式控制台。</T>
      //============================================================
      public function FUiPlayerConsole(){
         name = "core.animation.console";
      }
      
      //============================================================
      // <T>增加播放器。</T>
      //============================================================
      public function addPlayer(p:FUiPlayer):void{
         thread.plays.push(p);
      }
      
      //============================================================
      // <T>获取播放器。</T>
      //============================================================
      public function getPlay():FUiPlayer{
         var l:int = thread.plays.length;
         var fp:FUiPlayer;
         for(var i:int = 0; i < l; i++ ){
            var p:FUiPlayer = thread.plays[i];
            if(p.playing == false){
               fp = p;
               break;
            }
         }
         if(fp == null){
            fp = new FUiPlayer();
            addPlayer(fp);
         }
         return fp;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         RCmConsole.threadConsole.start(thread);
      }
   }
}