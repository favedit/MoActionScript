package mo.cr.ui.control
{
   import flash.display.Sprite;
   
   import mo.cm.core.ui.FSprite;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.FItemEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.layout.FUiScrollBox;

   //==========================================================
   // <T> 下拉列表</T>
   //
   // @author HECNG 20120321
   //==========================================================
   public class FUiListBox extends FUiControl3d
   {
      // 显示精灵
      protected var contentContainer:FSprite = new FSprite();
      
      // 显示行数
      public var rowCount:int = 5; 
      
      // 一行数据的默认高度；
      public var itemHeight:int = 22;
      
      // 数据
      public var items:Vector.<FUiListItem> = new Vector.<FUiListItem>();
      
      // 滑动框
      public var scrollbox:FUiScrollBox = new FUiScrollBox();
      
      // 选中项
      public var selectedItem:FUiListItem;
      
      // 选中项索引
      public var selectedIndex:int;
      
      // 触发事件名称
      public var eventName:String
      
      protected var context:FUiContext;
      
      //===========================================================
      // <T>构造函数</T>
      //
      // @author HECNG 20120321
      //===========================================================
      public function FUiListBox(){
         type = EUiControlType.ListBox;
         display = contentContainer;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
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
      // <T>出事化组件</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function setup():void{
         scrollbox.display.tag = this;
         contentContainer.addChild(scrollbox.display);
         scrollbox.setup();
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120321
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         rowCount = p.getInt("row_count");
         itemHeight = p.getInt("item_height");
         eventName = p.get("onselect");
         var xb:FXmlNode = p.findNode(EUiControlType.ScrollBox);
         if(xb){
            scrollbox.loadConfig(xb);
         }
         setup();
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
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120321
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("row_count", rowCount.toString());
         p.set("item_height", itemHeight.toString());
         p.set("onselect", eventName);
         var xb:FXmlNode = p.create(EUiControlType.ScrollBox);
         scrollbox.saveConfig(xb);
      }
      
      //===========================================================
      // <T>添加数据</T>
      //
      // @params i:FUiListItem 数据
      // @author HECNG 20120321
      //===========================================================
      public function addItem(i:FUiListItem):void{
         items.push(i);
         i.itemFlistener.register(itemClick, this);                                                                                                                             
         scrollbox.addChild(i.display);
      }
      
      //===========================================================
      // <T>添加完成数据后掉用此函数</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function endUpdate():void{
         updatePostion();
         scrollbox.paint();
      }
      
      //===========================================================
      // <T>更新显示列表坐标</T>
      //
      // @author HECNG 20120327
      //===========================================================
      public function updatePostion():void{
         var length:int = items.length;
         for(var i:int = 0; i < length; i++){
            var f:FUiListItem = items[i];
            f.setLocation(0, i * itemHeight);
         }
      }
      
      //============================================================
      // <T>鼠标点击数据项</T>
      //
      // @author HECNG 20120321
      //============================================================
      private function itemClick(e:FItemEvent):void{
         var f:FUiListTextItem = e.item as FUiListTextItem;
         selectedItem = f;
         selectedIndex = findIndex(f);
         var form:FUiForm = this.findParent(FUiForm);
         var evet:FItemEvent = new FItemEvent();
         evet.sender = this;
         evet.item = f;
         var d:Object = form.eventDispatcher;
         var m:Function = d[eventName];
         m.call(d, evet);
      }
      
      //============================================================
      // <T>查询当前列的索引</T>
      //
      // @params f:FUiListItem 数据项
      // return 为-1时此项不存在
      // @author HECNG 20120321
      //============================================================
      private function findIndex(f:FUiListItem):int{
         return items.indexOf(f);
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function paint(p:FUiContext=null):void{
         scrollbox.size.set(size.width, size.height);
         scrollbox.paint();
      }

      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function process(p:FUiContext):void{
         context = p;
         scrollbox.process();
         itemProcess(p);
         if(!dirty){
            paint(p);
            dirty = true;
         }
      }
      
      //============================================================
      // <T>遍历项执行函数</T>
      //
      // @author HECNG 20120321
      //============================================================
      private function itemProcess(p:FUiContext):void{
         var l:int = items.length;
         for(var i:int = 0; i < l; i++){
            items[i].process(p);
         }
      }
      
      //============================================================
      // <T>清楚数据</T>
      //
      // @author HECNG 20120321
      //============================================================
      public override function clear():void{
         items.length = 0;
         scrollbox.clear();
      }
   }
}