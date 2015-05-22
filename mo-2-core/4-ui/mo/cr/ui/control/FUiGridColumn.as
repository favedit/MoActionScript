package mo.cr.ui.control
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.geom.SIntSize2;
   import mo.cr.ui.FUiComponent3d;
   import mo.cr.ui.FUiContext;

   //==========================================================
   // <T> 列</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiGridColumn extends FUiComponent3d
   {
      // 所属列表
      public var tag:FUiGrid;
      
      // 单元格类型
      public var cellType:String;
      
      // 列名称
      protected var _headText:String;
      
      // 显示容器
      public var display:Sprite = new Sprite();
      
      // 宽高
      public var size:SIntSize2 = new SIntSize2();
      
    
      
      //===========================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function FUiGridColumn(){
      }
      
      //===========================================================
      // <T>执行函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public override function process(p:FUiContext):void{
      }
      
      //===========================================================
      // <T>设置坐标</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function setLocation(hx:int, hy:int):void{
         display.x = hx;
         display.y = hy;
      }
      
      //===========================================================
      // <T>初始化函数</T>
      //
      // @params w:width h:height 宽高
      // @author HECNG 20120327
      //===========================================================
      public function setup(w:int, h:int):void{
         size.set(w, h);
      }

      //===========================================================
      // <T>获取列名称</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function get headText():String{
         return _headText;
      }
      
      //===========================================================
      // <T>创建单元格</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function createCell():FUiGridCell{
         var c:FUiGridCell = new FUiGridCell();
         return c;
      }
   }
}