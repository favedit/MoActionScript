package mo.cr.ui.control
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.ui.FSprite;
   import mo.cm.lang.FObjects;
   import mo.cm.system.FEvent;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   import mo.cr.console.resource.ECrResource;
   import mo.cr.console.resource.FCrPictureResource;
   import mo.cr.ui.FNodeEvent;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.layout.FUiScrollBox;
   
   //==========================================================
   // <T> 树</T>
   //
   // @author HECNG 20120323
   //==========================================================
   public class FUiTreeView extends FUiControl3d
   {
      // 偏移量
      public var offset:int = 20;
      
      // 子节点高度
      public var itemHeight:int = 22;
      
      // 根节点
      public var root:FUiTreeNode = new FUiTreeNode();
      
      // 边框
      public var scrollbox:FUiScrollBox = new FUiScrollBox();
      
      // 当前显示的节点
      public var displayNode:FObjects = RAllocator.create(FObjects);
      
      // 显示精灵
      public var contentContainer:FSprite = new FSprite();
      
      // 打开节点图片id
      public var openPicId:int;
      
      // 关闭节点图片id
      public var closePicId:int;
      
      // 打开时节点图片
      public var openPic:FCrPictureResource;
      
      // 关闭时节点图片
      public var closePic:FCrPictureResource;
      
      // 节点点击事件
      public var onnodeclick:String;
      
      // 文本点击事件
      public var ontextclick:String;
      
      // 选中节点
      public var selectedNode:FUiTreeNode;
      
      // 默认选中行颜色
      public var selectedNodeColor:uint = 0xcccccc; 
      
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function FUiTreeView(){
         display = contentContainer;
         type = EUiControlType.TreeView;
         contentContainer.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //==========================================================
      // <T> 初始化树</T>
      //
      // @author HECNG 20120324
      //==========================================================
      public override function setup():void{
         scrollbox.display.tag = this;
         contentContainer.addChild(scrollbox.display);
         scrollbox.setup();
         scrollbox.setLoaction(0, 0);
      }
      
      //============================================================
      // <T>开始更新</T>
      //
      // @author HECNG 20120324
      //============================================================
      public function beginUpdate():void{
      }
      
      //============================================================
      // <T>结束更新</T>
      //
      // @author HECNG 20120324
      //============================================================
      public function endUpdate():void{
         if(ready){
            setPic();
            updatePostition();
            scrollbox.paint(); 
         }
      }
      
      //============================================================
      // <T>设置节点图片</T>
      //
      // @author HECNG 20120302
      //============================================================
      private function setPic():void{
         var c:int = displayNode.count;
         for(var nd:int = 0; nd < c; nd++){
            var node:FUiTreeNode = displayNode.get(nd) as FUiTreeNode;
            if(node.isopen){
               node.setBitmap(openPic.bitmapData);
            }else{
               node.setBitmap(closePic.bitmapData);
            } 
         }
      }
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function paint(p:FUiContext = null):void{ 
         if(ready){
            endUpdate();
            scrollbox.size.set(size.width, size.height);
            scrollbox.paint();
         }
      }
      
      //============================================================
      // <T>添加一个节点。</T>
      //
      // @param child:node  要添加的节点
      // @param parent:node  添加节点的父节点(为NULL默认添加到根结点root下)
      // @author HECNG 20120323
      //============================================================
      public function pushNode(child:FUiTreeNode, parent:FUiTreeNode = null):void{
         if(parent){
            child.parentNode =  parent; 
         }
         addStage(child, parent);
         addNode(child, parent);
      }
      
      //============================================================
      // <T>循环添加节点。</T>
      //
      // @param child:node  要添加的节点
      // @param parent:node  添加节点的父节点(为NULL默认添加到根结点root下)
      // @author HECNG 20120413
      //============================================================
      private function addNode(child:FUiTreeNode, parent:FUiTreeNode = null):void{
         var c:int = child.nodes.count;
         for(var nd:int = 0; nd < c; nd++){
            var node:FUiTreeNode = child.nodes.get(nd) as FUiTreeNode;
            addStage(node, child);
            if(node.nodes.count > 0){
               addNode(node, child);
            }
         }
      }
      
      //============================================================
      // <T>文本点击事件。</T>
      //
      // @author HECNG 20120331
      //============================================================
      private function onTextClick(e:FNodeEvent):void{
         sendEvent(ontextclick, e.text, e.node);
      }
      
      //============================================================
      // <T>节点点击事件。</T>
      //
      // @author HECNG 20120331
      //============================================================
      private function onNodeClick(e:FNodeEvent):void{
         sendEvent(onnodeclick, "", e.node);
         setSelectNode(e.node);
      }
      
      //============================================================
      // <T>设置选中节点。</T>
      //
      // @author HECNG 20120331
      //============================================================
      public function setSelectNode(node:FUiTreeNode):void{
         if(selectedNode){
            selectedNode.removeColor();
            selectedNode.isSelected = false;
         }
         selectedNode = node;
         selectedNode.isSelected = true;
         selectedNode.drawColor(selectedNodeColor); 
      }
      
      //============================================================
      // <T>激活事件。</T>
      //
      // @params name:eventname 事件名称
      // @params t:text 文本
      // @author HECNG 20120331
      //============================================================
      private function sendEvent(name:String, t:String, node:FUiTreeNode):void{
         if(name.length > 0){
            var form:FUiForm = this.findParent(FUiForm);
            var f:FNodeEvent = new FNodeEvent();
            f.node = node;
            f.text = t;
            var d:Object = form.eventDispatcher;
            var m:Function = d[name];
            m.call(d, f);
         }
      }
      
      //============================================================
      // <T>将一个节点添加到舞台上。</T>
      //
      // @param n:node 节点
      // @author HECNG 20120323
      //============================================================
      private function addStage(n:FUiTreeNode, f:FUiTreeNode = null):void{
         scrollbox.addChild(n.display);
         n.openFlistener.register(openNodeClick, this);
         n.textFlistener.register(onTextClick, this);
         n.nodeFlistener.register(onNodeClick, this);
         if(f){
            f.pushNode(n);
            var idex:int = displayNode.indexof(f);
            displayNode.insert(idex + 1, n);
         }else{
            root.pushNode(n);
            displayNode.push(n);
         }
      }
      
      //============================================================
      // <T>更新每一个节点的坐标。</T>
      //
      // @param n:node 节点
      // @author HECNG 20120323
      //============================================================
      public function updatePostition():void{
         var length:int = displayNode.count;
         var num:int = 0;
         root.offset = -offset;  
         for(var i:int = 0; i < length; i++){
            var node:FUiTreeNode = displayNode.get(i) as FUiTreeNode;
            if(node.display.visible){
               var p:FUiTreeNode = node.parentNode;
               node.offset = p.offset  + offset;
               node.size.set(size.width, itemHeight);
               node.setLocation(node.offset, num * node.height);
               num ++ ;
            }else{
               node.setLocation(0, 0);
            }
         }
      }
      
      //============================================================
      // <T>打开节点事件。</T>
      //
      // @author HECNG 20120323
      //============================================================
      private function openNodeClick(e:FEvent):void{
         var node:FUiTreeNode = e.sender as FUiTreeNode;
         if(node.nodes.count > 0){
            ioNode(node);
            updatePostition();
            scrollbox.paint();
            node.isopen = !node.isopen;
         }
      }
      
      //============================================================
      // <T>打开关闭节点。</T>
      //
      // @params n:node 节点
      // @author HECNG 20120323
      //============================================================
      private function ioNode(n:FUiTreeNode):void{
         if(n.isopen){
            n.setBitmap(closePic.bitmapData);
            n.setVisable(n, false, 0);
         }else{
            n.setBitmap(openPic.bitmapData);
            n.setVisable(n, true, 0);
         }
      }
      
      //============================================================
      // <T>清理舞台显示对象。</T>
      //
      // @author HECNG 20120323
      //============================================================
      private function clearStage():void{
         while(contentContainer.numChildren > 0){
            contentContainer.removeChildAt(0);
         }
      }
      
      //============================================================
      // <T>移除一个节点及其子节点。</T>
      //
      // @param n:node 设置信息
      // @author HECNG 20120323
      //============================================================
      public function removeNode(n:FUiTreeNode):void{
         var i:int = displayNode.indexof(n);
         n.reset();
         var length:int = n.nodeCount(n) + i;
         for(var nd:int = i; nd <= length; nd++){
            var node:FUiTreeNode = displayNode.get(nd) as FUiTreeNode;
            scrollbox.removeChild(node.display);
         }
         for(nd = i; nd <= length; nd++){
            var t:FUiTreeNode = displayNode.get(i) as FUiTreeNode;
            displayNode.remove(t);
         }
         n.removeNode();
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120323
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         openPicId = p.getInt("open_rid");
         closePicId = p.getInt("close_rid");
         offset = p.getInt("offset");
         onnodeclick = p.get("onnodeclick");
         ontextclick = p.get("ontextclick");
         var xb:FXmlNode = p.findNode(EUiControlType.ScrollBox);
         if(xb){
            scrollbox.loadConfig(xb);
         }
         setup();
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120326
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("open_rid", openPicId.toString());
         p.set("close_rid", closePicId.toString());
         p.set("offset", offset.toString());
         p.set("onnodeclick", onnodeclick);
         p.set("ontextclick", ontextclick);
         var xb:FXmlNode = p.create(EUiControlType.ScrollBox);
         scrollbox.saveConfig(xb);
      }
      
      //============================================================
      // <T>是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function testReady():Boolean{
         if(openPic && closePic){
            if(openPic.ready && closePic.ready){
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         openPic = null;
         closePic = null;
         scrollbox.setupEnd();
         ready = false;
         dirty = false;
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120302
      //============================================================
      public override function process(p:FUiContext):void{
         scrollbox.process();
         if(openPicId && !openPic){
            openPic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, openPicId.toString());
         }
         if(closePicId && !closePic){
            closePic = RCmConsole.resourceConsole.syncResource(ECrResource.Picture, closePicId.toString());
         }
         if(!ready){
            ready = testReady();
         }
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
      
      //============================================================
      // <T>清理树节点</T>
      //
      // @author HECNG 20120413
      //============================================================
      public override function clear():void{
         root.nodes.clear();
         displayNode.clear();
         scrollbox.clear();
      }
   }
}