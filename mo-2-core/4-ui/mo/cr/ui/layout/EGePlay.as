package mo.cr.ui.layout
{
   import mo.cm.core.device.RFatal;
   
   //============================================================
   // <T>播放方式。</T>
   //============================================================
   public class EGePlay
   {
      // 没有
      public static const None:int = 0x00;
      
      // 循环
      public static const Loop:int = 0x01;
      
      // 重复
      public static const Repeat:int = 0x02;
      
      // 单次
      public static const Single:int = 0x03;

      // 等待
      public static const Wait:int = 0x04;
      
      //============================================================
      // <T>从字符串变换到播放方式。</T>
      //
      // @param p:value 字符串
      // @return 播放方式
      //============================================================
      public static function parse(p:String):int{
         switch(p){
            case "none":
               return None;
            case "loop":
               return Loop;
            case "repeat":
            case "play":
               return Repeat;
            case "single":
               return Single;
            case "wait":
               return Wait;
         }
         RFatal.throwUnsupport();
         return None;
      }
      
      //============================================================
      // <T>从播放方式变换到字符串。</T>
      //
      // @param p:value 播放方式
      // @return 字符串
      //============================================================
      public static function toString(p:int):String{
         switch(p){
            case None:
               return "none";
            case Loop:
               return "loop";
            case Repeat:
               return "repeat";
            case Single:
               return "single";
            case Wait:
               return "wait";
         }
         RFatal.throwUnsupport();
         return "none";
      }
   }
}