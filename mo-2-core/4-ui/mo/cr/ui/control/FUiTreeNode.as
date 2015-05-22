package mo.cr.ui.control
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObjects;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cr.ui.FNodeEvent;
   import mo.cr.ui.FUiComponent3d;

   //==========================================================
   // <T> 节点</T>
   //
   // @author HECNG 20120323
   //==========================================================
   public class FUiTreeNode extends FUiComponent3d
   {  
      // 关联目标
      public var target:*;
      
      // 子节点集合
      public var nodes:FObjects = RAllocator.create(FObjects);
      
      // 父节点
      public var parentNode:FUiTreeNode;
      
      // 当前节点的高
      public var height:int = 22;
      
      // 文本显示
      public var label:TextField = new TextField();
      
      // 显示对象
      public var display:Sprite = new Sprite();
      
      // 点击图片
      public var selectPic:Sprite = new Sprite();
      
      // 鼠标点击节点文本事件
      public var nodeFlistener:FListeners = RAllocator.create(FListeners);
      
      // 文本点击事件
      public var textFlistener:FListeners = RAllocator.create(FListeners);
      
      // 关闭打开节点
      public var openFlistener:FListeners = RAllocator.create(FListeners);
      
      // 全部子节点个数
      public var nodesCount:int
      
      // 该节点是否隐藏(默认为显示)
      public var visable:Boolean = true;
      
      // 该节点是否打开
      public var isopen:Boolean = true;
	 
	  // 填充色
	  public var filters:uint = 0xffffff;//0xcccccc;  
	  
	  // 宽高
	  public var size:SIntSize2 = new SIntSize2();
	  
	  // 偏移量
	  public var offset:int;
	  
	  // 是否为选中行
	  public var isSelected:Boolean;
      
      //==========================================================
      // <T> 构造函数</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function FUiTreeNode(){
      }
      
      //==========================================================
      // <T>  设置节点关联的目标对象</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function setTarget(obj:*):void{
         target = obj;
      }
      
      //==========================================================
      // <T>  初始化节点</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function setup():void{
         display.addChild(selectPic);
         setTextStyle();
         display.addChild(label);
         label.addEventListener(MouseEvent.CLICK, onNodeClick);
         display.addEventListener(TextEvent.LINK, onTextClick); 
         selectPic.addEventListener(MouseEvent.CLICK, nodeClick);
		   display.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		   display.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
      }
	  
	  //==========================================================
	  // <T>  鼠标划过色</T>
	  //
	  // @author HECNG 20120416
	  //==========================================================
	  private function mouseOver(e:MouseEvent):void{
		  if(!isSelected){
			  drawColor(filters);
		  }
	  }
	  
	  //==========================================================
	  // <T>  鼠标离开</T>
	  //
	  // @author HECNG 20120416
	  //==========================================================
	  private function mouseOut(e:MouseEvent):void{
		  if(!isSelected){
			  removeColor();
		  }
	  }
	  
	  //==========================================================
	  // <T>  移除背景色</T>
	  //
	  // @author HECNG 20120416
	  //==========================================================
	  public function removeColor():void{
		  display.graphics.clear();
	  }
	  
	  //==========================================================
	  // <T>  绘制背景色</T>
	  //
	  // @author HECNG 20120416
	  //==========================================================
	  public function drawColor(color:uint):void{
		 var g:Graphics =  display.graphics;
		 g.clear();
		 g.beginFill(color);
		 g.drawRect(0, 0, size.width, size.height);
		 g.endFill();
	  }
      
      //==========================================================
      // <T> 节点点击事件</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function onNodeClick(e:MouseEvent):void{
         var f:FNodeEvent = RAllocator.create(FNodeEvent);
         f.node = this;
         nodeFlistener.process(f);
      }
      
      //==========================================================
      // <T> 文本点击事件</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function onTextClick(e:TextEvent):void{
        var f:FNodeEvent = RAllocator.create(FNodeEvent);
        f.node = this;
        f.text = e.text;
        textFlistener.process(f);
      }
      
      //===========================================================
      // <T>设置文本</T>
      //
      // @author HECNG 20120327
      //===========================================================
      private function setTextStyle():void{
         label.height = 20;
         label.selectable = false;
         label.wordWrap = false; 
         label.mouseEnabled = true;
         label.autoSize = TextFieldAutoSize.LEFT; 
      }
      
      //==========================================================
      // <T>  添加节点</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function pushNode(n:FUiTreeNode):void{
         if(!nodes.constains(n)){
            nodes.push(n);
            n.parentNode = this;
         }
      }
      
      //==========================================================
      // <T>  点击按钮后更新图片</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function setBitmap(b:BitmapData):void{
         if(b){
            var g:Graphics = selectPic.graphics;
            g.clear();
            if(nodes.count > 0){
               g.beginBitmapFill(b);
               g.drawRect(0, 0, b.width, b.height);
               g.endFill();
            }
         }
         label.x = selectPic.x + selectPic.width;
      }
      
      //==========================================================
      // <T>  点击节点</T>
      //
      // @author HECNG 20120323
      //==========================================================
      private function nodeClick(e:MouseEvent):void{
         var f:FEvent = RAllocator.create(FEvent);
         f.sender = this;
         openFlistener.process(f);
      }
      
      //==========================================================
      // <T>  设置节点的显示内容 (html形式的)</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function setHtmlLabel(str:String):void{
         label.htmlText = str;
      }
      
      //==========================================================
      // <T>  设置节点的显示内容 (非html形式的)</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function setLabel(str:String):void{
         label.text = str;
      }
      
      //==========================================================
      // <T>  将当前节点移除</T>
      //
      // @author HECNG 20120323
      //==========================================================
      public function removeNode():void{
         parentNode.nodes.remove(this);
         parentNode = null;
      }
      
      //==========================================================
      // <T>  重置数据</T>
      //
      // @author HECNG 20120324
      //==========================================================
      public function reset():void{
         nodesCount = 0;
      }
      
      //==========================================================
      // <T>  显示影藏子节点</T>
      //
      // @params nd:node 节点
      // @params bool:Boolean 是否影藏
      // @params i:index 递归次数
      // @author HECNG 20120323
      //==========================================================
      public function setVisable(nd:FUiTreeNode, bool:Boolean, i:int):void{
         var length:int = nd.nodes.count;
         for(var n:int = 0; n < length; n++){
            var node:FUiTreeNode = nd.nodes.get(n) as FUiTreeNode;
            if(i == 0){
               node.visable = bool;
               node.display.visible = bool;
            }else{
               if(bool){
                  node.display.visible = node.visable;
               }else{
                  node.display.visible = bool;
               }
            }
            if(node.nodes.count > 0){
				if(node.isopen){
					setVisable(node, bool, 1);
				}
            }
         }
      }
      
      //==========================================================
      // <T>  设置节点坐标/T>
      //
      // @author HECNG 20120324
      //==========================================================
      public function setLocation(hx:int, hy:int):void{
         display.x = 0;
         display.y = hy;
		 selectPic.x = hx;
		 label.x =  selectPic.width > 0 ? selectPic.x + selectPic.width : hx;
      }
      
      //==========================================================
      // <T> 获取所有子节点的个数</T>
      //
      // @author HECNG 20120323
      // @return 子节点个数
      //==========================================================
      public function nodeCount(node:FUiTreeNode):int{
         var length:int = node.nodes.count;
         for(var n:int = 0; n < length; n++){
            nodesCount++;
            var node:FUiTreeNode = node.nodes.get(n) as FUiTreeNode;
            if(node.nodes.count > 0)
            {
               nodeCount(node);
            }
         }
         return nodesCount;
      }
   }
}