package mo.cm.core.ui
{
   //============================================================
   // <T>方向。</T>
   //============================================================
   public class EDirection
   {
      // 无方向
      public static const None:int = 0;
      
      // 右下
      public static const RightDown:int = 1;
      
      // 下
      public static const Down:int = 2;
      
      // 左下
      public static const LeftDown:int = 3;
      
      // 左
      public static const Left:int = 4;
      
      // 左上
      public static const LeftUp:int = 5;
      
      // 上
      public static const Up:int = 6;
      
      // 右上
      public static const RightUp:int = 7;
      
      // 右
      public static const Right:int = 8;
      
      // 总数
      public static const Count:int = 9;
      
      //============================================================
      // <T>解析字符串为枚举内容。</T>
      //
      // @param p:value 字符串
      // @return 枚举内容
      //============================================================
      public static function parse(p:String):int{
         switch(p){
            case "right.down":
               return RightDown;
            case "down":
               return Down;
            case "left.down":
               return LeftDown;
            case "left":
               return Left;
            case "left.up":
               return LeftUp;
            case "up":
               return Up;
            case "right.up":
               return RightUp;
            case "right":
               return Right;
         }
         return None;
      }
      
      //============================================================
      // <T>获得枚举内容的字符串。</T>
      //
      // @param p:value 枚举内容
      // @return 字符串
      //============================================================
      public static function toString(p:int):String{
         switch(p){
            case RightDown:
               return "right.down";
            case Down:
               return "down";
            case LeftDown:
               return "left.down";
            case Left:
               return "left";
            case LeftUp:
               return "left.up";
            case Up:
               return "up";
            case RightUp:
               return "right.up";
            case Right:
               return "right";
         }
         return "none";
      }
   }
}