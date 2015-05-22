package mo.cr.ui.control
{
   import mo.cm.console.RCmConsole;
   import mo.cm.console.resource.FContent;
   import mo.cm.core.ui.FSprite;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   
   public class FUiLoaderPictrueBox extends FUiControl3d
   {
      // 背景容器
      public var contentContainer:FSprite = new FSprite();
      
      // 图片地址
      public var url:String;
      
      // 背景位图
      public var fcontent:FContent;
      
      // 背景图
      public var backGroundPic:FCrPictureResource;
      
      // 对齐方式
      public var align:String;
      
      public var context:FUiContext;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120427
      //==========================================================
      public function FUiLoaderPictrueBox(){
         display = contentContainer;
         type = EUiControlType.LoaderPictureBox;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //==========================================================
      // <T>初始化设置</T>
      //
      // @author HECNG 20120427
      //==========================================================
      public override function setup():void{
         super.setup();
         contentContainer.clear();
         contentContainer.graphics.beginFill(0xffee00, 0);
         contentContainer.graphics.drawRect(0, 0, size.width, size.height);
         contentContainer.graphics.endFill();
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function paint(p:FUiContext = null):void{
         if(ready){
            //var bit:Bitmap = fcontent.syncBitmap(size.width, size.height);
            //if(bit){
               //contentContainer.clear();
               //   contentContainer.addChild(bit);
            //} 
            if(null != fcontent){
               if(null != fcontent.display){
                  contentContainer.clear();
                  contentContainer.addChild(fcontent.display);
                  fcontent.display.width = size.width;
                  fcontent.display.height = size.height;
               }
            } 
         }
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(fcontent){
            if(fcontent.ready){
               ready = fcontent.ready;
            }
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
         url = p.get("url");
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
         p.set("url", url);
      }
      
      //============================================================
      // <T>初始数据。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function setupEnd(p:FUiContext=null):void{
         if(fcontent){
            fcontent.disposed;
         }
         url = null;
         fcontent = null;
         ready = false;
         dirty = false;
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
         if(url && !fcontent){
            fcontent = RCmConsole.resourceConsole.createContent(url);
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
   }
}