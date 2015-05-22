package mo.cr.ui.control
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FEvent;
   import mo.cr.ui.RGmStyle;

   //==========================================================
   // <T> 分页按钮</T>
   //
   // @author HECNG 20120314
   //==========================================================
   public class FUiPageButton extends FSprite
   {
      public var bit:Bitmap = new Bitmap();
      
      public var ready:Boolean;
      
      public var dirty:Boolean;
      
      // 绑定页面名称
      public var pageName:String;
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @author HECNG 20120314
      //============================================================
      public function FUiPageButton(){
         addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
         addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
         addEventListener(MouseEvent.CLICK, mouseClick);
         addChild(bit);
      }
      
      //============================================================
      // <T>鼠标离开。</T>
      //
      // @author HECNG 20120314
      //============================================================
      private function mouseOut(e:MouseEvent):void{
         filters = [];
      }
      
      //============================================================
      // <T>鼠标点击。</T>
      //
      // @author HECNG 20120314
      //============================================================
      private function mouseClick(e:MouseEvent):void{
         var f:FEvent = new FEvent();
         f.senderName = pageName;
         f.sender = this;
         FUiPageControl.pageButtonListener.process(f);
      }
      
      //============================================================
      // <T>鼠标划过。</T>
      //
      // @author HECNG 20120314
      //============================================================
      private function mouseOver(e:MouseEvent):void{
//         filters = [RGmStyle.ItemWarnFilter];
         filters = [RGmStyle.ButtonGlowFilter, RGmStyle.DropEmptyFilter];
      }
      
      //============================================================
      // <T>绘制图形。</T>
      //
      // @param p:bitmapData 图片数据
      // @author HECNG 20120314
      //============================================================
      public function paint(data:BitmapData):void{
         bit.bitmapData = data;
         bit.width = data.width;
         bit.height = data.height;
//         graphics.clear();
//         graphics.beginBitmapFill(data);
////         graphics.drawRect(0, 0, size.width, size.height);
//         graphics.drawRect(0, 0, data.width, data.height);
//         graphics.endFill();
      }
   }
}