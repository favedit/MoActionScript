package mo.cr.ui.control
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Sprite;
   
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.FRowEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.layout.FUiScrollBox;

   //==========================================================
   // <T> 列表</T>
   //
   // @author HECNG 20120327
   //==========================================================
   public class FUiGrid extends FUiControl3d
   {
      // 显示精灵
      protected var contentContainer:FSprite = new FSprite();
      
      // 列集合
      public var columns:Vector.<FUiGridColumn> = new Vector.<FUiGridColumn>(); 
      
      // 行集合
      public var rows:Vector.<FUiGridRow> = new Vector.<FUiGridRow>();
      
      // 边框
      public var scrollbox:FUiScrollBox = new FUiScrollBox();
      
      // 数据
      private var context:FUiContext;
      
      // 表头高度
      public var columnHeight:int = 22;
      
      // 选中行
      public var selectRow:FUiGridRow;
      
      // 行点击响应
      public var rowEventName:String;
      
      // 填充色
      public var filters:Array = [0xcccccc, 0xffffff];
      
      
      //===========================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function FUiGrid(){
         display = contentContainer;
         contentContainer.tag = this;
         type = EUiControlType.Grid;
         controls = new Vector.<FUiControl3d>();
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
        super.loadConfig(p);
        rowEventName = p.get("onrowclick");
        var xb:FXmlNode = p.findNode(EUiControlType.ScrollBox);
        if(xb){
           scrollbox.loadConfig(xb);
        }
        ready = true;
        setup();
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("onrowclick", rowEventName);
         var xb:FXmlNode = p.create(EUiControlType.ScrollBox);
         scrollbox.saveConfig(xb);
      }
      
      //============================================================
      // <T>初始化组件。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function setup():void{
         scrollbox.display.tag = this;
         contentContainer.addChild(scrollbox.display);
         scrollbox.setup();
         scrollbox.size.set(size.width, size.height);
      }
      
      //============================================================
      // <T>更新结束（此函数在数据添加完成后调用）。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      public function endUpdate():void{
         setPostion();
         scrollbox.paint();
      }
      
      //============================================================
      // <T>增加显示元素到列表</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120227
      //============================================================
      private function addChild(d:DisplayObject):void{
         scrollbox.addChild(d);
      }
      
      //============================================================
      // <T>设置显示元素坐标</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function setPostion():void{
         setColumnsPostion();
         setRowsPostion();
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         scrollbox.setupEnd();
      }
      
      //============================================================
      // <T>设置行坐标</T>
      //
      // @author HECNG 20120227
      //============================================================
      private function setRowsPostion():void{
         var cl:int = rows.length;
         var h:int = columnHeight;
         for(var n:int = 0; n < cl; n++){
            var row:FUiGridRow = rows[n];
            row.setLocation(0, h);
            h += row.rowHeight;
         } 
      }
      
      //============================================================
      // <T>设置列坐标</T>
      //
      // @author HECNG 20120227
      //============================================================
      private function setColumnsPostion():void{
         var cl:int = columns.length;
         var w:int = 0;
         for(var n:int = 0; n < cl; n++){
            var c:FUiGridColumn = columns[n];
            c.setLocation(w, 0);
            w += c.size.width;
         }
      }
      
      //============================================================
      // <T>添加列</T>
      //
      // @params c:column 列
      // @author HECNG 20120227
      //============================================================
      public function addColumn(c:FUiGridColumn):void{
         columns.push(c);
         addChild(c.display);
      }
      
      //============================================================
      // <T>添加行</T>
      //
      // @params r:row 行
      // @author HECNG 20120227
      //============================================================
      public function addRow(r:FUiGridRow):void{
         rows.push(r);
         r.rowFlisteners.register(rowClick, this);
         addChild(r.display);
      }
      
      //============================================================
      // <T>行点击事件</T>
      //
      // @params e:row 行
      // @author HECNG 20120227
      //============================================================
      private function rowClick(e:FRowEvent):void{
         selectRow = e.row;
         var form:FUiForm = this.findParent(FUiForm);
         var f:FRowEvent = new FRowEvent();
         f.sender = this;
         f.row = selectRow;
         var d:Object = form.eventDispatcher;
         var m:Function = d[rowEventName];
         m.call(d, f);
      }
      
      //============================================================
      // <T>创建行</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function createRow():FUiGridRow{
         var r:FUiGridRow = RAllocator.create(FUiGridRow);
         r.tag = this;
         return r;
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function paint(p:FUiContext = null):void{
         if(ready){
            scrollbox.size.set(size.width, size.height);
            scrollbox.paint();
            draw();
         }
      }
      
      //============================================================
      // <T>资源是否加载完成</T>
      //
      // @return 资源是否加载完成
      // @author HECNG 20120227
      //============================================================
      public override function testReady():Boolean{
         return scrollbox.ready;
      }
      
      //============================================================
      // <T>删除列对象</T>
      //
      // @params c:column 列
      // @author HECNG 20120227
      //============================================================
      public function removeColumn(c:FUiGridColumn):void{
         var index:int = columns.indexOf(c);
         eraseColumn(index);
      }
      
      //============================================================
      // <T>删除行对象</T>
      //
      // @params c:column 列
      // @author HECNG 20120227
      //============================================================
      public function removeRow(r:FUiGridRow):void{
         var index:int = rows.indexOf(r);
         var length:int = r.cells.length;
         for(var i:int = 0; i < length; i++){
            scrollbox.removeChild(r.cells[i].display);
         }
         if(-1 != index){
            columns.splice(index, 1);
         }
      }
      
      //============================================================
      // <T>按照索引删除列</T>
      //
      // @params index 删除列索引
      // @author HECNG 20120227
      //============================================================
      public function eraseColumn(index:int):void{
         scrollbox.removeChild(columns[index].display);
         columns.splice(index, 1);
         var rl:int = rows.length;
         for(var i:int = 0; i < rl; i++){
            var cl:int = rows[i].cells.length;
            for(var n:int = 0; n < cl; n++){
               if(index == n){
                  rows[i].cells.splice(index, 1);
                  scrollbox.removeChild(rows[i].cells[n].display);
               }
            }
         }
      }
      
      //============================================================
      // <T>按照索引删除行</T>
      //
      // @params index 删除行索引
      // @author HECNG 20120227
      //============================================================
      public function eraseRow(index:int):void{
         var r:FUiGridRow = rows[index];
         removeRow(r);
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120227
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         scrollbox.process();
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
      
      //===========================================================
      // <T>绘制</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function draw():void{
         if(filters.length > 0){
            var rl:int = rows.length;
            var width:int;
            for each(var i:FUiGridColumn in columns){
               width += i.size.width;
            }
            for(var n:int = 0; n < rl; n++){
               var row:FUiGridRow = rows[n];
               var color:uint = n % 2 == 0 ? filters[0] : filters[1];
               row.paint(color, width);
            }  
         }
      }
   }
}