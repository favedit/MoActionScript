package mo.cm.console.resource
{
   import mo.cm.system.FFatalUnsupportError;
   
   //============================================================
   // <T>资源类型定义。</T>
   //============================================================
   public class EResourceType
   {
      // 位置类型
      public static const UnknownCode:int = 0;
      
      // 组类型
      public static const GroupCode:int = 1;
      
      // 文件类型
      public static const XmlCode:int = 2;
      
      // SWF类型
      public static const SwfCode:int = 3;
      
      // 程序类型
      public static const ShaderCode:int = 4;
      
      // 图片类型
      public static const PictureCode:int = 5;
      
      // 动画类型
      public static const AnimationCode:int = 6;
      
      // 地图类型
      public static const MapCode:int = 7;
      
      // 地面类型
      public static const GroundCode:int = 8;
      
      // 音乐类型
      public static const MusicCode:int = 9;
      
      // 声音类型
      public static const SoundCode:int = 10;
      
      // 资源组
      public static const Group:String = "g";
      
      // 内容(SWF)
      public static const Content:String = "c";
      
      // 图片类型
      public static const Picture:String = "2p";
      
      // 动画类型
      public static const Animation:String = "2a";
      
      // 地图类型
      public static const Ground:String = "2g";
      
      // 音效类型
      public static const Sound:String = "ws";
      
      // 音乐类型
      public static const Music:String = "wm";
      
      //============================================================
      public static function toString(p:int):String{
         switch(p){
            case UnknownCode:
               break;
            case GroupCode:
               return Group;
            case XmlCode:
               break;
            case SwfCode:
               break;
            case ShaderCode:
               break;
            case PictureCode:
               return Picture;
            case AnimationCode:
               return Animation;
            case MapCode:
               break;
            case GroundCode:
               break;
            case MusicCode:
               break;
            case SoundCode:
               break;
         }
         throw new FFatalUnsupportError();
      }
   }
}