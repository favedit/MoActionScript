package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Graphics;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.IhintAble;
   import mo.cr.ui.RGmStyle;
   import mo.cr.ui.RUiUtil;
   
   //==========================================================
   // <T> 图片控件</T>
   //
   // @author HECNG 20120427
   //==========================================================
   public class FUiPictureBox extends FUiControl3d implements IhintAble
   {
      // 背景容器
      public var contentContainer:FSprite = new FSprite();
      
      // 背景位图
      public var bitmap:Bitmap = new Bitmap();
      
      // 背景图编号
      public var groundRid:uint = 0;
      
      // 背景图
      public var backGroundPic:FCrPictureResource;
      
      // 对齐方式
      public var align:String;
      
      // 是否缩放
      public var isSclae:Boolean = false;
      
      public var context:FUiContext;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120427
      //==========================================================
      public function FUiPictureBox(){
         display = contentContainer;
         type = EUiControlType.PictureBox;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //============================================================
      // <T>是否显示说明文本。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function isHintAble():Boolean{
         return isHite;
      }
      
      //============================================================
      // <T>设置激活状态。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function setDisable(p:Boolean):void{
         contentContainer.filters = p ? [RGmStyle.ValidGrayFilter] : [];
      }
      
      //============================================================
      // <T>获取说明文本。</T>
      //
      // @author HECNG 20120302
      //============================================================
      public function get hintText():String{
         return hite;
      }
      
      //===========================================================
      // <T> 初始化组件。 <T>
      //
      // @author HECNG 20120227
      //===========================================================
      public override function setup():void{
         contentContainer.addChild(bitmap);
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         backGroundPic = null;
         bitmap.bitmapData = null;
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function paint(p:FUiContext = null):void{
         // 绘制底框
         var g:Graphics = contentContainer.graphics;
         g.clear();
         g.beginFill(0xffffff, 0);
         g.drawRect(0, 0, size.width, size.height);
         g.endFill();
         // 绘制位图
         if(backGroundPic){
            var d:BitmapData = backGroundPic.bitmapData;
            bitmap.bitmapData = d;
            if(isSclae){
               bitmap.width = size.width;
               bitmap.height = size.height;
            }else{
               bitmap.width = d.width;
               bitmap.height = d.height;
            }
            RUiUtil.calculateAlign(bitmap, align, size.width, size.height);
         }
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(groundRid){
            if(backGroundPic){
               ready = backGroundPic.ready;
            }
         }else{
            ready = true;
         }
         return ready;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         groundRid = p.getUint("ground_rid");
         isSclae = p.getBoolean("scale");
         align = p.get("align");
         setup();
      }
      
      //============================================================
      // <T>保存组件。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("ground_rid", groundRid.toString());
         p.set("scale", isSclae.toString());
         p.set("align", align);
      }
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function mouseEnable(bool:Boolean):void{
         contentContainer.mouseChildren = bool;
         contentContainer.mouseEnabled = bool;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         // 准备数据
         if(groundRid && !backGroundPic){
            backGroundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, groundRid.toString());
         }
         // 测试准备
         if(!ready){
            ready = testReady();
         }
         // 绘制处理
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
   }
}