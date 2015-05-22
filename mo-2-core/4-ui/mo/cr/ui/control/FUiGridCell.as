package mo.cr.ui.control
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   import mo.cm.geom.SIntSize2;
   import mo.cr.ui.FUiComponent3d;
   import mo.cr.ui.FUiContext;

   //==========================================================
   // <T> 单元格</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiGridCell extends FUiComponent3d
   {
      // 显示容器
      public var display:Sprite = new Sprite();
      
      // 绑定对象
      public var value:*;
      
      // 宽高
      public var size:SIntSize2 = new SIntSize2();
      
      // 所在列
      public var column:FUiGridColumn;
      
      // 所在行
      public var row:FUiGridRow;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120327
      //==========================================================
      public function FUiGridCell(){
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
      public function setup(w:int, h:int):void{
         size.set(w, h);
      }
      
      //===========================================================
      // <T>设置坐标</T>
      //
      // @params x:int, y:int 坐标
      // @author HECNG 20120327
      //===========================================================
      public function setLocation(x:int, y:int):void{
         display.x = x;
         display.y = y;
      }
   }
}