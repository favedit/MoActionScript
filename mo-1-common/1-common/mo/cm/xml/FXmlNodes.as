package mo.cm.xml
{	
   import mo.cm.lang.FObject;

   //============================================================
   // <T>配置节点列表。</T>
   //============================================================
	public class FXmlNodes extends FObject
	{
      // 节点列表
		protected var _nodes:Vector.<FXmlNode> = new Vector.<FXmlNode>();
		
      //============================================================
      // <T>构造配置节点列表。</T>
      //============================================================
		public function FXmlNodes(){
		}
		
		//============================================================
		// <T>判断是否为空。</T>
		//
		// @return 是否为空
		//============================================================
		public function isEmpty():Boolean{
			return (0 == _nodes.length);
		}
		
		//============================================================
		// <T>获得项目的总数</T>
		//
		// @return 总数
		//============================================================
		public function get count():int{
			return _nodes.length;
		}
		
		//============================================================
      // <T>获得指定索引位置的节点对象。</T>
      //
      // @param p:index 索引位置
      // @return 节点对象
      //============================================================
		public function get(p:int):FXmlNode{
			return _nodes[p];
		}
		
		//============================================================
      // <T>设置指定索引位置的节点对象。</T>
      //
      // @param pi:index 索引位置
      // @param pn:node 节点对象
      //============================================================
		public function set(pi:int, pn:FXmlNode):void{
			_nodes[pi] = pn;
		}		
		
		//============================================================
      // <T>查找指定名称的节点。</T>
      //
      // @param pn:name 节点名称
      // @param pan:attributeName 属性名称
      // @param pav:attributeValue 属性内容
      // @return 节点对象
      //============================================================
		public function find(pn:String, pan:String = null, pav:String = null):FXmlNode{
			var c:int = _nodes.length;
			for(var n:int = 0; n < c; n++){
				var x:FXmlNode = _nodes[n];
				if(x.isName(pn)){
               if(pan && pav){
                  if(x.get(pan) == pav){
                     return x;
                  }
                  continue;
               }
					return x;
				}
			}
			return null;
		}
		
		//============================================================
      // <T>增加一个节点到列表尾部。</T>
      //
      // @param p:node 节点对象
      //============================================================
		public function push(p:FXmlNode):void{
			_nodes.push(p);
		}

      //============================================================
      // <T>清除节点列表。</T>
      //============================================================
      public function clear():void{
         _nodes.splice(0, _nodes.length);
      }
	}
}
