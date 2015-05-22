package mo.cr.ui.control
{
   import flash.display.Graphics;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.console.RCmConsole;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FUiContext;

   //==========================================================
   // <T> 文本项</T>
   //
   // @author HECNG 20120328
   //==========================================================
   public class FUiListTextItem extends FUiListItem
   {
      // 显示文本
      private var _tf:TextField = new TextField();
      
      // 背景图片id
      public var resourceId:uint;
      
      // 背景图片
      private var backgroundPic:FCrPictureResource; 
      
      // 是否绘制完成
      private var isDrawed:Boolean;
      
      //==========================================================
      // <T> 文本项</T>
      //
      // @author HECNG 20120328
      //==========================================================
      public function FUiListTextItem(){  
      }
      
      //==========================================================
      // <T> 获取文本</T>
      //
      // @author HECNG 20120328
      //==========================================================
      public function get text():String{
         return _tf.text;
      }

      //==========================================================
      // <T> 获取文本</T>
      //
      // @params t:text 文本显示文字
      // @author HECNG 20120328
      //==========================================================
      public function set text(t:String):void{
         _tf.text = t;
      }

      //==========================================================
      // <T>测试资源是否加载完成。</T>
      //
      // @param p:context 环境
      // @author HECNG 20120328
      //==========================================================
      private function testReady():void{
         if(backgroundPic){
            if(backgroundPic.ready){
               ready = true;
            }
         }
      }
      
      //===========================================================
      // <T>设置文本样式</T>
      //
      // @author HECNG 20120328
      //===========================================================
      private function setlabel():void{
         _tf.selectable = false;
         _tf.wordWrap = false;
         _tf.mouseEnabled = false;
         _tf.width = size.width;
         _tf.height = size.height;
         _tf.autoSize = TextFieldAutoSize.CENTER;
      }
      
      //==========================================================
      // <T> 初始化组件</T>
      //
      // @params pw:width ph:height 宽高
      // @params v:valie 绑定数据
      // @author HECNG 20120321
      //==========================================================
      public override function setup(pw:int, ph:int, v:*):void{
         super.setup(pw, ph, v);
         display.addChild(_tf);
         _tf.width = pw;
         _tf.height = ph;
         setlabel();
      }
      
      //==========================================================
      // <T>执行处理过程。</T>
      //
      // @param p:context 环境
      // @author HECNG 20120328
      //==========================================================
      public override function process(p:FUiContext):void{
         if(resourceId && !backgroundPic){
            backgroundPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, resourceId.toString());
         }
         if(!ready){
            testReady();
         }
         if(ready && !isDrawed){
            paint();
            isDrawed = true;
         }
      }
      
      //==========================================================
      // <T>绘制图形。</T>
      //
      // @author HECNG 20120328
      //==========================================================
      public override function paint():void{
         if(ready){
            var g:Graphics = display.graphics;
            g.clear();
            g.beginBitmapFill(backgroundPic.bitmapData);
            g.drawRect(0, 0, size.width, size.height);
            g.endFill();
         }
      }
   }
}