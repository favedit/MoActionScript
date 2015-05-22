package mo.cr.ui.control
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cr.ui.FRowEvent;
   import mo.cr.ui.FUiComponent3d;
   import mo.cr.ui.RGmStyle;
   
   import spark.primitives.supportClasses.GraphicElement;

   //==========================================================
   // <T> 行</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiGridRow extends FUiComponent3d
   {
      // 显示精灵
      public var display:Sprite = new Sprite();
      
      // 所属列表
      public var tag:FUiGrid;
      
      // 行高
      public var rowHeight:int = 22;
      
      // 单元格集合
      public var cells:Vector.<FUiGridCell> = new Vector.<FUiGridCell>();
      
      // 点击事件
      public var rowFlisteners:FListeners = RAllocator.create(FListeners);
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120327
      //==========================================================
      public function FUiGridRow(){
      }
      
      //==========================================================
      // <T> 初始化函数</T>
      //
      // @author HECNG 20120327
      //==========================================================
      public function setup():void{
         display.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
         display.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
         display.addEventListener(MouseEvent.CLICK, mouseClick);
      }
      
      //==========================================================
      // <T> 鼠标划过</T>
      //
      // @author HECNG 20120327
      //==========================================================
      private function mouseOver(e:MouseEvent):void{
         display.filters = [RGmStyle.listStyle];
      }
      
      //==========================================================
      // <T> 鼠标离开</T>
      //
      // @author HECNG 20120327
      //==========================================================
      private function mouseOut(e:MouseEvent):void{
         display.filters = [];
      }
      
      //===========================================================
      // <T>绘制矩形</T>
      //
      // @params color 颜色
      // @author HECNG 20120327
      //===========================================================
      public function paint(color:uint, width:int):void{
         var g:Graphics = display.graphics;
         g.clear();
         g.beginFill(color);
         g.drawRect(0, 0, display.width, rowHeight);
         g.endFill();
      }
      
      //==========================================================
      // <T> 鼠标点击</T>
      //
      // @author HECNG 20120327
      //==========================================================
      private function mouseClick(e:MouseEvent):void{
         var ev:FRowEvent = new FRowEvent();
         ev.row = this;
         rowFlisteners.process(ev);
      }
      
      //==========================================================
      // <T> 添加单元格</T>
      //
      // @params c:cell单元格
      // @author HECNG 20120327
      //==========================================================
      public function addCell(c:FUiGridCell):void{
         cells.push(c);
         display.addChild(c.display);
         setPostition();
      }
      
      //==========================================================
      // <T> 设置坐标</T>
      //
      // @params x:int, y:int 坐标
      // @author HECNG 20120327
      //==========================================================
      public function setLocation(x:int, y:int):void{
         display.x = x;
         display.y = y;
      }
      
      //==========================================================
      // <T> 设置单元格坐标</T>
      //
      // @author HECNG 20120327
      //==========================================================
      public function setPostition():void{
         var lenth:int = cells.length;
         var w:int = 0;
         for(var n:int = 0; n < lenth; n++){
            var cell:FUiGridCell = cells[n];
            cell.setLocation(w, 0);
            w += cell.size.width;
         }
      }
   }
}