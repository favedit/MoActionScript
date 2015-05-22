package mo.cr.console.resource
{
   import flash.geom.Matrix;

   //============================================================
   // <T>反转方式。</T>
   //============================================================
   public class ECrReverse
   {
      // 水平翻转
      public static const LevelReverse:int = 0;
      
      // 垂直翻转
      public static const PlumbReverse:int = 1;
      
      // 水平反转矩阵
      public static var levelMatrix:Matrix = new Matrix(-1);
      
      // 垂直反转矩阵
      public static var plumbMatrix:Matrix = new Matrix();
      
      // 水平绘制反转矩阵
      public static var levelDrawMatrix:Matrix = new Matrix(-1);
      
      // 正常绘制矩阵
      public static var normalDrawMatrix:Matrix = new Matrix();
   }
}