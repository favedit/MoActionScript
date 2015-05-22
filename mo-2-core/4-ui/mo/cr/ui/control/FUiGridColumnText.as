package mo.cr.ui.control
{
   import flash.text.TextField;

   //==========================================================
   // <T> 文本列</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiGridColumnText extends FUiGridColumn
   {
      // 中间显示文本
      public var _tf:TextField = new TextField();
      
      //===========================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function FUiGridColumnText(){
         cellType = EUiCellType.FUiGridCellText;
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
      // <T>设置文本</T>
      //
      // @author HECNG 20120327
      //===========================================================
      private function setlabel():void{
         _tf.selectable = false;
         _tf.wordWrap = false;
         _tf.mouseEnabled = false;
         _tf.width = size.width;
         _tf.height = size.height;
         //_tf.autoSize = TextFieldAutoSize.CENTER;
      }
      
      //===========================================================
      // <T>设置列名称</T>
      //
      // @params value:columnname 列名称
      // @author HECNG 20120327
      //===========================================================
      public function set headText(value:String):void{
         _headText = value;
         _tf.text = _headText;
      }
      
      //===========================================================
      // <T>创建单元格</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public override function createCell():FUiGridCell{
         var c:FUiGridCellText = new FUiGridCellText();
         return c;
      }
   }
}