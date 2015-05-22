package mo.cr.ui.control
{
   import flash.display.Graphics;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cr.ui.FUiContext;

   //==========================================================
   // <T> 文本单元格</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiGridCellText extends FUiGridCell
   {
      // 列名称
      protected var _headText:String;

      // 中间显示文本
      public var _tf:TextField = new TextField();
      
      //==========================================================
      // <T> 单元格</T>
      //
      // @author HECNG 20120327
      //==========================================================
      public function FUiGridCellText(){
      }
      
      //===========================================================
      // <T>执行函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public override function process(p:FUiContext):void{ 
      }
      
      //===========================================================
      // <T>初始化函数</T>
      //
      // @params w:width h:height 宽高
      // @author HECNG 20120327
      //===========================================================
      public override function setup(w:int, h:int):void{
         super.setup(w, h);
         setlabel();
         display.addChild(_tf);
      }
      
      //===========================================================
      // <T>画直线</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function drawLine(g:Graphics, sx:int, sy:int, ex:int, ey:int):void{
         g.lineStyle(1, 0x000000, .5);
         g.moveTo(sx, sy);
         g.lineTo(ex, ey);
         g.endFill();
      }
      
      //===========================================================
      // <T>设置文本</T>
      //
      // @author HECNG 20120327
      //===========================================================
      private function setlabel():void{
         _tf.selectable = false;
         _tf.wordWrap = false;
         _tf.width = size.width;
         _tf.height = size.height; 
         _tf.mouseEnabled = false;
      }
      
      //===========================================================
      // <T>获取列名称</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function get text():String
      {
         return _headText;
      }
      
      //===========================================================
      // <T>设置列名称</T>
      //
      // @params value:columnname 列名称
      // @author HECNG 20120327
      //===========================================================
      public function set text(value:String):void
      {
         _headText = value;
         _tf.text = _headText;
      }
   }
}