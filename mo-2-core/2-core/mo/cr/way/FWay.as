package mo.cr.way
{
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>道路。</T>
   //
   // @author HECNG 20120416
   //============================================================
   public class FWay extends FObject
   {
      // 直线移动代价
      protected const COST_STRAIGHT:int = 10;
      
      // 对角移动付出的代价
      protected const	COST_DIAGONAL:int	= 14;
      
      // 待检测单元格列表
      protected var openNodes:Vector.<FWayNode> = new Vector.<FWayNode>();
      
      // 已检测单元格列表
      protected var closeNodes:Vector.<FWayNode> = new Vector.<FWayNode>();
      
      // 节点个数
      public var count:SIntSize2 = new SIntSize2();
      
      // 节点集合
      public var nodes:Vector.<FWayNode> = new Vector.<FWayNode>();
      
      // 节点宽高
      public var nodeWidth:int;
      
      // 当前格子周围路点
      public var aroundNode:Array = [];
      
      //============================================================
      // <T>构造道路。</T>
      //
      // @author HECNG 20120416
      //============================================================
      public function FWay(){
      }
      
      // =================================================================
      // <T>将单元格添加到开放列表中。</T>
      //
      // @author HECNG 20120416
      // =================================================================
      public function addOpenList(node:FWayNode):void{
         node.checkStatus = 1;
         openNodes.push(node);
         headSort(openNodes.length);
      }
      
      // =================================================================
      // <T>将单元格添加到关闭列表中。</T>
      //
      // @author HECNG 20120416
      // =================================================================
      public function addCloseList(node:FWayNode):void{
         node.checkStatus = 2;
         closeNodes.push(node);
      }
      
      // =================================================================
      // <T>获得二叉堆中第一个地图格(F值最小的)。</T>
      //
      // @author HECNG 20120416
      protected function getTopNode():FWayNode{
         var openCount:int = openNodes.length;
         var topCell:FWayNode = openNodes[0];
         openNodes[0] = openNodes[openCount - 1];
         openNodes.pop();
         addCloseList(topCell);
         backSort(openNodes.length);
         return topCell;
      }
      
      // =================================================================
      // <T>从二叉堆取出地图格进行排序。</T>
      //
      // @author HECNG 20120416
      // =================================================================
      protected function backSort(openCount:int):void{
         //尾部的节点被移到最前面
         var checkIndex:int = 1;
         var tmpIndex:int;
         var tmpCell:FWayNode;
         while(true){
            tmpIndex = checkIndex;
            //如果有子节点
            if (2 * tmpIndex - 1 < openCount){
               //如果子节点的F值更小
               if(openNodes[checkIndex - 1].F > openNodes[2 * tmpIndex - 1].F){
                  //记节点的新位置为子节点位置
                  checkIndex = 2 * tmpIndex;
               }
               //如果有两个子节点
               if (2 * tmpIndex < openCount){
                  //如果第二个子节点F值更小
                  if(openNodes[checkIndex - 1].F > openNodes[2 * tmpIndex].F){
                     //更新节点新位置为第二个子节点位置
                     checkIndex = 2 * tmpIndex + 1;
                  }
               }
            }
            //如果节点位置没有更新结束排序
            if (tmpIndex == checkIndex){
               break;
            }else{
               //反之和新位置交换，继续和新位置的子节点比较F值
               tmpCell = openNodes[tmpIndex - 1];
               openNodes[tmpIndex - 1] = openNodes[checkIndex - 1];
               openNodes[checkIndex - 1] = tmpCell;
            }
         }
      }
      
      // =================================================================
      // <T>重置信息.</T>
      //
      // @author HECNG 20120416
      // =================================================================
      public function reset():void{
         for each(var n:FWayNode in openNodes){
            n.checkStatus = 0;
         }
         for each(var d:FWayNode in closeNodes){
            d.checkStatus = 0;
         }
         openNodes.length = 0;
         aroundNode.length = 0;
         closeNodes.length = 0;
      }
      
      
      // =================================================================
      // <T>新加入二叉堆地图格进行排序。</T>
      //
      // @author HECNG 20120416
      // =================================================================
      protected function headSort(cellIndex:int):void{
         var childIndex:int = cellIndex;
         var parentIndex:int;
         var tmpCell:FWayNode;
         while(childIndex > 1){
            // 取得父节点索引
            parentIndex = Math.floor(childIndex/2);
            // 比较F值若子节点F值比父节点F值小交换位置，否则结束
            if(openNodes[childIndex - 1].F < openNodes[parentIndex - 1].F){
               tmpCell = openNodes[childIndex - 1];
               openNodes[childIndex - 1] = openNodes[parentIndex - 1];
               openNodes[parentIndex - 1] = tmpCell;
               childIndex = parentIndex;
            }else{
               break;
            }
         }
      }
      
      //============================================================
      // <T>改变大小。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      // @author HECNG 20120416
      //============================================================
      public function resize(pw:int, ph:int):void{
      }
      
      //============================================================
      // <T>更新信息。</T>
      //
      // @author HECNG 20120416
      //============================================================
      public function update():void{
         var c:int = nodes.length;
         for(var n:int = 0; n < c; n++){
            nodes[n].update();
         }
      }
      
      //============================================================
      // <T>根据坐标获取格子。</T>
      //
      // @params x， y坐标
      // @author HECNG 20120416
      //============================================================
      public function findNodeByPoint(x:int, y:int):FWayNode{
         var cx:int = x / nodeWidth;
         var cy:int = y / nodeWidth;
         return nodes[cy *　count.width + cx];
      }
      
      //============================================================
      // <T>根据索引获取格子。</T>
      //
      // @params x， y索引
      // @author HECNG 20120416
      //============================================================
      public function findNodeByIndex(x:int, y:int):FWayNode{
         var node:FWayNode;
         var index:int = y *　count.width + x;
         if(index >= 0 ){
            node = nodes[index];
         }
         return node;
      }
      
      // =================================================================
      // <T>获得从出发点到目标点的路点列表。</T>
      //
      // @params path 路径
      // @parmas currNode 当前节点
      // @params startNode 开始节点
      // @author HECNG 20120416
      // =================================================================
      public function getPath(path:FWayPath, currNode:FWayNode, startNode:FWayNode):void{
         while(currNode.parent	!= startNode.parent){
            path.nodes.push(currNode.vender);
            currNode = currNode.parent;
         }
      }
      
      // =================================================================
      // <T>根据坐标添加单元格。</T>
      //
      // @parmas x, y 索引
      // @author HECNG 20120416
      // =================================================================
      private function addAroundNodes(x:int, y:int):void{
         if(x >= count.width || y >= count.height || x < 0 || y < 0){
            return;
         }
         var checkCell:FWayNode = findNodeByIndex(x, y);
         if(checkCell){
            if(checkCell.blocked == false && checkCell.checkStatus != 2){
               aroundNode.push(checkCell);
            }
         } 
      }
      
      // =================================================================
      // <T>获得当前单元格的周围单元格。</T>
      //
      // @params node 当前节点
      // @author HECNG 20120416
      // =================================================================
      protected function getAroundNodes(node:FWayNode):void{
         var currentX:int = node.index.x;
         var currentY:int = node.index.y;
         aroundNode.length = 0;
         var checkX:int;
         var checkY:int;
         // 左
         checkX = currentX - 1;
         checkY = currentY;
         addAroundNodes(checkX, checkY);
         // 右
         checkX = currentX	+ 1;
         checkY = currentY;
         addAroundNodes(checkX, checkY);
         // 上
         checkX = currentX;
         checkY = currentY - 1;
         addAroundNodes(checkX, checkY);
         // 下
         checkX = currentX;
         checkY = currentY	+ 1;
         addAroundNodes(checkX, checkY);
         //		  // 左上
         //		  checkX = currentX	- 1;
         //		  checkY = currentY	- 1;
         //		  addAroundNodes(checkX, checkY);
         //		  // 左下
         //		  checkX = currentX	- 1;
         //		  checkY = currentY	+ 1;
         //		  addAroundNodes(checkX, checkY);
         //		  // 右上
         //		  checkX = currentX	+ 1;
         //		  checkY = currentY	- 1;
         //		  addAroundNodes(checkX, checkY);
         //		  // 右下
         //		  checkX = currentX	+ 1;
         //		  checkY = currentY	+ 1;
         //		  addAroundNodes(checkX, checkY);
      }
      
      // =================================================================
      // <T>计算H值的启发函数。</T>
      //
      // @params node 当前节点
      // @params endNode 结束节点
      // @author HECNG 20120416
      // =================================================================
      public function calculateH(node:FWayNode, endNode:FWayNode):int{
         // H值的计算
         var	dx:Number = Math.abs(node.index.x - endNode.index.x);
         var	dy:Number =	Math.abs(node.index.y - endNode.index.y);
         return	Math.sqrt(dx*dx +	dy*dy)*COST_STRAIGHT
      }
      
      //============================================================
      // <T>检测当前单元格的周围单元格。</T>
      //
      // @param pp:path 路线
      // @param psx:sourceX 起点横坐标
      // @param psY:sourceY 起点纵坐标
      // @param ptx:targetX 终点横坐标
      // @param ptY:targetY 终点纵坐标
      // @param isIndex:Boolean 是否以索引开始
      // @author HECNG 20120416
      //============================================================
      public function search(pp:FWayPath, psx:int, psy:int, ptx:int, pty:int, isIndex:Boolean = false):void{
         reset();
         pp.reset();
         // 路径单元格列表
         var startNode:FWayNode;
         var endNode:FWayNode;
         if(isIndex){
            startNode = findNodeByIndex(psx, psy);
            endNode = findNodeByIndex(ptx, pty);
         }else{
            startNode = findNodeByPoint(psx, psy);
            endNode = findNodeByPoint(ptx, pty);
         }
         if(!startNode || !endNode){
            return;
         }
         if(startNode.index.x == endNode.index.x && startNode.index.y == endNode.index.y){
            pp.nodes.push(endNode.vender);
            return;
         }
         var costG:int;
         var costH:int;
         var costF:int;
         var aroundCells:Array
         startNode.parent = null;
         // 将开始单元格加入到待检测列表
         addOpenList(startNode);
         // 开始寻路
         while(0 != openNodes.length){
            var _currentNode:FWayNode = getTopNode();
            // 如果已到达目标，返回路径
            if(_currentNode == endNode){
               getPath(pp, _currentNode, startNode);
               return;
            }
            // 获取周围八个格子
            getAroundNodes(_currentNode);
            var cellCount:int = aroundNode.length;
            for each(var node:FWayNode in aroundNode){
               costG = (node.index.x == _currentNode.index.x || node.index.y == _currentNode.index.y) ? _currentNode.G + COST_STRAIGHT : _currentNode.G + COST_DIAGONAL;
               costH = calculateH(node, endNode);
               costF = costG + costH;
               if(1 ==	node.checkStatus){
                  if(costF < node.F){
                     node.G = costG;
                     node.H = costH;
                     node.F = costF;
                     node.parent = _currentNode;
                  }
               }else{
                  //	将单元格加入到开放列表
                  node.G = costG;
                  node.H = costH;
                  node.F = costF;
                  node.parent = _currentNode;
                  addOpenList(node);
               }
            }
         }
      }
   }
}