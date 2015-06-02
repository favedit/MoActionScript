package mo.cm.core.ui
{
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class RStyle
   {
      public static var ControlHeight:int = 20;
      
      public static var ControlPadding:int = 8;
      
      public static var ControlLineHeight:int = 28;
      
      public static var LabelLeftFormat:TextFormat = new TextFormat();
      
      public static var LabelMidleFormat:TextFormat = new TextFormat();
      
      public static var LabelPlayerMidleFormat:TextFormat = new TextFormat();
      
      public static var LabelRightFormat:TextFormat = new TextFormat();
      
      public static var TextFieldFormat:TextFormat = new TextFormat();
      
      public static var RoleTitleFormat:TextFormat = new TextFormat();
      
      public static var EditFormat:TextFormat = new TextFormat();
      
      public static var PasswordFormat:TextFormat = new TextFormat();
      
      public static var SCROLL_TOP:int = 1;
      
      public static var SCROLL_BOTTOM:int = 2;
      
      //============================================================
      {
         // 初始化标签格式
         LabelLeftFormat.align = TextFormatAlign.LEFT;
         LabelLeftFormat.size = 12;
         // 初始化标签格式
         LabelMidleFormat.align = TextFormatAlign.CENTER;
         LabelMidleFormat.size = 12;
         
         // 初始化标签格式
         LabelPlayerMidleFormat.align = TextFormatAlign.CENTER;
         LabelPlayerMidleFormat.color = 0x000000;
         LabelPlayerMidleFormat.size = 12;
         
         // 初始化标签格式
         RoleTitleFormat.align = TextFormatAlign.CENTER;
         RoleTitleFormat.color = 0x000000;
         RoleTitleFormat.bold = true;
         RoleTitleFormat.size = 20;
         
         // 初始化标签格式
         LabelRightFormat.align = TextFormatAlign.RIGHT;
         LabelRightFormat.size = 12;
         
         //初始化textfield格式
         TextFieldFormat.align = TextFormatAlign.CENTER;
         TextFieldFormat.color = 0xfef067;
         TextFieldFormat.size = 12;
      
         // 初始化编辑框格式
         EditFormat.align = TextFormatAlign.LEFT;
         EditFormat.size = 12;
         
         // 初始化密码编辑框格式
         PasswordFormat.align = TextFormatAlign.LEFT;
         PasswordFormat.size = 12;
      }
   }
}