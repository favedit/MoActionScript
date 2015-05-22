package mo.cr.ui
{
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.StyleSheet;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   import mo.cm.xml.FXmlNode;
   
   public class RGmStyle
   {
      // 白色描边滤镜
      public static var FT_GW:GlowFilter = new GlowFilter(0xffffff, 0.5, 2, 2, 10, 1, false, false);
      // 黑色描边滤镜
      public static var FT_GB:GlowFilter = new GlowFilter(0x000000, 0.5, 2, 2, 10, 1, false, false);
      // 阴影滤镜
      public static var FT_DB:DropShadowFilter = new DropShadowFilter(1, 45, 0xFFFFFF, 1, 1, 1, 10, 1, false, false);
      // 灰度滤镜
      public static var FT_CG:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0,0,0,1,0]);
         
      public static var LabelHeight:int = 20;
      
      public static var LoadingCaption:TextFormat = new TextFormat();
      
      // 
      public static var NpcCaption:TextFormat = new TextFormat();
      
      // 
      public static var NpcInfo:TextFormat = new TextFormat();
      
      // 
      public static var NpcDisplay:TextFormat = new TextFormat();
      
      // 
      public static var notify:TextFormat = new TextFormat();
      
      public static var suspend:TextFormat = new TextFormat();
      
      public static var NpcText:TextFormat = new TextFormat();
      
      // 角色信息(进入游戏时显示角色列表信息)
      public static var RoleInfoStyle:TextFormat = new TextFormat();
      
      // 角色或者NPC的姓名描边样式滤镜
      public static var SpriteLabelGlowFilter:GlowFilter = new GlowFilter(0x000000, 1, 2, 2, 10, 1, false, false);
      
      // 角色或者NPC的姓名描边样式滤镜
      public static var TalkGlowFilter:GlowFilter = new GlowFilter(0x222121, 1, 2, 2, 10, 1, false, false);
      
      // 喇叭聊天字体描边滤镜
      public static var SpriteHeroTextGlowFilter:GlowFilter = new GlowFilter(0x000000, .4, 2, 2, 10, 1, false, false);
      
      // 喇叭聊天字体描边滤镜
      public static var SpriteHeroGlowFilter:GradientGlowFilter = new GradientGlowFilter(0, 0, [0xFFFFFF, 0xFFFB00], [0,1], [0,128], 12, 12,1,2,"outer",false);
      
      // 喇叭聊天字体描边滤镜
      public static var listStyle:GradientGlowFilter = new GradientGlowFilter(0, 0, [0xFFFFFF, 0xFFFB00], [0.8,0.2], [0,128], 12, 12,1,2,"inner",false);
      
      // 聊天字体描边滤镜
      public static var SpriteTextGlowFilter:GlowFilter = new GlowFilter(0x00000, 0.5, 2, 2, 10, 1, false, false);
      
      // 通用的阴影样式滤镜
      public static var DropFilter:DropShadowFilter = new DropShadowFilter(1, 45, 0xFFFFFF, 1, 1, 1, 10, 1, false, false);
      
      // 向显示对象添加投影
      public static var DropEmptyFilter:DropShadowFilter = new DropShadowFilter();
      
      // 按钮渐变样式
      public static var ButtonGlowFilter:GlowFilter = new GlowFilter(0x001c19, .2, 10, 10, 10, 1, false, false);
      
      // item红色蒙板
      public static var ItemWarnFilter:GradientGlowFilter = new GradientGlowFilter(0,45,[0x8effb3],[0.8],[0,1],20,20,255,1,"inner");
      
//      public static var ButtonGlowFilter:GlowFilter = new GlowFilter(0xffe785, 1, 5, 5, 10, 1, false, false);
      
      // 按钮渐变样式
      public static var EntitySelectedFilter:GradientGlowFilter = new GradientGlowFilter(0,0,[0xFFE000,0xFBD501],[0,1],[0,128],10,10,1,2,"outer");
      
      // 按钮渐变样式
      public static var cGlowFilter:GlowFilter = new GlowFilter(0xC71005, 1, 4, 4, 10, 1, false, false);
      
      // 焦点样式
      public static var HoverGlowFilter:GlowFilter = new GlowFilter();
      
      // 控件失效样式
      public static var ValidGrayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0,0,0,1,0]);
      
      // 编辑器中选中控件时发光效果
      public static var ControlSelected:GlowFilter = new GlowFilter(0xFF0000, 1, 20.0);
      
      // 编辑器中选中控件时发光效果
      public static var defaultSheet:StyleSheet = new StyleSheet();
      
      //============================================================
      {
         // 加载资源字体样式
         LoadingCaption.bold = true;
         LoadingCaption.color = 0x000000;
         LoadingCaption.size = 18;
         
         // 实体标签格式
         NpcCaption.align = TextFormatAlign.CENTER;
         NpcCaption.size = 12;
         NpcCaption.color = 0xFFFFFF;
         
         // 实体标签格式
         NpcInfo.align = TextFormatAlign.LEFT;
         NpcInfo.size = 12;
         NpcInfo.color = 0x7CC523;
         
         // 实体标签格式
         NpcDisplay.align = TextFormatAlign.CENTER;
         NpcDisplay.size = 12;
         NpcDisplay.color = 0x00EAFF;
         
         // 实体标签格式
         notify.align = TextFormatAlign.CENTER;
         notify.size = 20;
         notify.font = "SimSun";
         notify.color = 0xE59800;
         
         // 实体标签格式
         suspend.align = TextFormatAlign.CENTER;
         suspend.size = 16;
         suspend.bold = true;
         suspend.color = 0xfcff00;
         
         // 实体标签格式
         RoleInfoStyle.align = TextFormatAlign.CENTER;
         RoleInfoStyle.size = 24;
         RoleInfoStyle.font = "SimSun";
         RoleInfoStyle.color = 0xFFFFFF;
         // 实体标签格式
         NpcText.align = TextFormatAlign.LEFT;
         NpcText.size = 14;
         NpcText.color = 0x333630;
         NpcText.bold = 2;
         NpcText.letterSpacing = 2;
         HoverGlowFilter.inner = true;
         HoverGlowFilter.color = 0xFFFFFF;
      }
      
      //============================================================
      public static function construct():void{
      }
      
      //============================================================
      public static function loadConfig(config:FXmlNode):void{
      }
      
      //============================================================
      public static function setup():void{
      }
   }
}