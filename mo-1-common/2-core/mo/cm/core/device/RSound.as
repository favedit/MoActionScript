package mo.cm.core.device
{
   import flash.display.Loader;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   
   
   //============================================================
   // <T>游戏时间。</T>
   //============================================================
   public class RSound
   {
      // 当前状态
      public static var status:int = 0;
      
      // 播放位置
      public static var position:int = 0;
      
      // 播放位置
      public static var sound:Sound = new Sound();
      
      // 音频
      public static var channel:SoundChannel = new SoundChannel();
      
      // 音频转换
      public static var transform:SoundTransform = new SoundTransform();
      
      //============================================================
      // <T>加载音乐</T>
      //
      // @param path String 路径
      //============================================================
      public static function loadAndPlay(path:String, loop:int = 0):void{
         sound.load(new URLRequest(RGlobal.sourceUrl + path));
         sound.play(0, loop);
      }
      
      //============================================================
      // <T>加载音乐</T>
      //
      // @param path String 路径
      //============================================================
      public static function load(path:String):void{
         sound.load(new URLRequest(path));
      }
      
      //============================================================
      // <T>开始播放音乐</T>
      //
      // @param times 播放次数
      //============================================================
      public static function play(times:int = 1):void{
         //load(path);
         status = 1;
         transform.volume = 0.1;
         channel.soundTransform = transform;
         channel = sound.play(position, times);
      }
      
      //============================================================
      // <T>暂停音乐</T>
      //
      // @param event Fevent 点击事件
      //============================================================
      public static function pause():void{
         status = 0;
         position = channel.position;
         channel.stop();
      }
      
      //============================================================
      // <T>结束播放</T>
      //
      // @param event Fevent 点击事件
      //============================================================
      public static function stop():void{
         status = 0;
         position = 0;
         channel.stop();
      }
      
      //============================================================
      // <T>增加声音</T>
      //
      // @param event Fevent 点击事件
      //============================================================
      public static function addVolume(value:Number = 0.1):void{
         transform.volume += value;
         channel.soundTransform = transform;
      }
      
      //============================================================
      // <T>减弱声音</T>
      //
      // @param event Fevent 点击事件
      //============================================================
      public static function reduceVolume(value:Number = 0.1):void{
         transform.volume -= value;
         channel.soundTransform = transform;
      }
      
      //============================================================
      // <T>设置声音</T>
      //
      // @param event Fevent 点击事件
      //============================================================
      public static function setVolume(value:Number):void{
         transform.volume = value;
         channel.soundTransform = transform;
      }
   }
}