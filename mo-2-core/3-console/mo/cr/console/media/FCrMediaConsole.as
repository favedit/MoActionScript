package mo.cr.console.media
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.system.Capabilities;
   
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RGlobal;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>音乐控制台。</T>
   //============================================================
   public class FCrMediaConsole extends FConsole
   {
      // 路径
      private static var _logger:ILogger = RLogger.find(FCrMediaConsole);

      // 路径
      public var path:String;

      // 播放设置
      public var optionPlay:Boolean = true;

      // 播放中
      public var playing:Boolean;

      // 播放位置
      public var sound:Sound;
      
      // 音频
      public var channel:SoundChannel;

      // 播放声音
      public var volume:Number = 1;

      // 播放地址
      public var playUrl:String;

      // 音频转换
      public var transform:SoundTransform = new SoundTransform();

      // 正在播放的音乐
      public var playName:String;

      //============================================================
      // <T>构造音乐控制台。</T>
      //============================================================
      public function FCrMediaConsole(){
         name = "core.media.console";
      }
      
      //============================================================
      // <T>播放音乐。</T>
      //============================================================
      public function onIoError(e:Event):void{
         playing = false;
         //RFatal.throwFatal("Load file error. (event={1})", e);
      }

      //============================================================
      // <T>播放音乐。</T>
      //
      // @param pu:url 音乐地址
      // @param pc:count 播放次数
      //============================================================
      public function play(pu:String = null, pc:int = 100000):Boolean{
         // 检查正在播放相同音乐
         if(playing){
            // 相同检查
            if(pu){
               if(playName == pu){
                  return false;
               }
            }
            // 停止播放
            stop();
         }
         // 设置要播放音乐
         if(pu){
            playName = pu;
         }
         // 是否可以播放
         if(!optionPlay){
            return false;
         }
         // 是否能够播放动画
         if(Capabilities.hasStreamingAudio){
            // 生成地址
            var u:String = RGlobal.sourceUrl + RGlobal.sourceUri + path + "/" + playName + ".mp3";
            // 播放音乐
            sound = new Sound();
            sound.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
            try {
               sound.load(new URLRequest(u));
               channel = sound.play(0, pc);
               channel.soundTransform = transform;
               playing = true;
            }catch (er:Error) {
               sound.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
               sound = null;
               channel = null;
               _logger.error("play", "Play stream media error. (url={1})", u);
            }
         }
         return true;
      }
      
      //============================================================
      // <T>播放音乐继续。</T>
      //============================================================
      public function resume():void{
         transform.volume = volume;
      }
      
      //============================================================
      // <T>播放音乐继续。</T>
      //============================================================
      public function pause():void{
         volume = transform.volume;
         transform.volume = 0;
      }
      
      //============================================================
      // <T>播放音乐静音。</T>
      //============================================================
      public function mute():void{
         volume = transform.volume;
         transform.volume = 0;
      }

      //============================================================
      // <T>播放音乐停止。</T>
      //============================================================
      public function stop():void{
         if(playing){
            channel.stop();
            channel = null;
            sound.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
            sound = null;
            playing = false;
         }
      }
      
      //============================================================
      // <T>播放音乐停止。</T>
      //============================================================
      public function enable():void{
         // 允许播放
         optionPlay = true;
         // 开始播放
         play();
      }

      //============================================================
      // <T>播放音乐停止。</T>
      //============================================================
      public function disable():void{
         // 停止播放
         stop();
         // 禁止播放
         optionPlay = false;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 加载设置信息
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Property")){
               switch(x.get("name")){
                  case "path":
                     path = x.get("value");
                     break;
               }
            }
         }
      }
   }
}