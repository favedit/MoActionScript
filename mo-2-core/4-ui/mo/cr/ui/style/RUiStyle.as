package mo.cr.ui.style
{
   import flash.filters.ColorMatrixFilter;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.filters.GradientGlowFilter;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   import mo.cm.xml.FXmlNode;
   
   public class RUiStyle
   {
      public static var LabelHeight:int = 20;
      
      public static var LoadingCaption:TextFormat = new TextFormat();
      
      // 
      public static var NpcCaption:TextFormat = new TextFormat();
      
      // 
      public static var notify:TextFormat = new TextFormat();
      
      public static var NpcText:TextFormat = new TextFormat();
      
      public static var listStyle:GradientGlowFilter = new GradientGlowFilter(0, 0, [0xFFFFFF, 0xFFFB00], [0.8,0.2], [0,128], 12, 12,1,2,"inner",false);
      
      // 角色信息(进入游戏时显示角色列表信息)
      public static var RoleInfoStyle:TextFormat = new TextFormat();
      
      // 角色或者NPC的姓名描边样式滤镜
      public static var SpriteLabelGlowFilter:GlowFilter = new GlowFilter(0x000000, 1, 2, 2, 10, 1, false, false);
      
      // 喇叭聊天字体描边滤镜
      public static var SpriteHeroTextGlowFilter:GlowFilter = new GlowFilter(0xf2f435, 1, 2, 2, 10, 1, false, false);
      
      // 聊天字体描边滤镜
      public static var SpriteTextGlowFilter:GlowFilter = new GlowFilter(0x00000, 0.5, 2, 2, 10, 1, false, false);
      
      // 通用的阴影样式滤镜
      public static var DropFilter:DropShadowFilter = new DropShadowFilter(1, 45, 0xFFFFFF, 1, 1, 1, 10, 1, false, false);
      
      // 向显示对象添加投影
      public static var DropEmptyFilter:DropShadowFilter = new DropShadowFilter();
      
      // 按钮渐变样式
      public static var ButtonGlowFilter:GlowFilter = new GlowFilter(0xFFFFFF, 2, 2, 2, 10, 1, false, false);
      
      // 焦点样式
      public static var HoverGlowFilter:GlowFilter = new GlowFilter();
      
      // 控件失效样式
      public static var ValidGrayFilter:ColorMatrixFilter = new ColorMatrixFilter([0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0.3086,0.6094,0.0820,0,0,0,0,0,1,0]);
      
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
         notify.align = TextFormatAlign.CENTER;
         notify.size = 20;
         RoleInfoStyle.font = "youyuan";
         notify.color = 0xE59800;
         
         // 实体标签格式
         RoleInfoStyle.align = TextFormatAlign.CENTER;
         RoleInfoStyle.size = 24;
         RoleInfoStyle.font = "华文楷体";
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