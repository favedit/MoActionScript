package mo.cm.xml 
{
   import mo.cm.lang.FAttributes;
   import mo.cm.lang.FObject;
   import mo.cm.lang.FString;
   import mo.cm.lang.RBoolean;
   import mo.cm.lang.RFloat;
   import mo.cm.lang.RInteger;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>配置节点。</T>
   //============================================================
   public class FXmlNode extends FObject{
      
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FXmlNode);
      
      // 名称
      public var name:String;
      
      // 内容
      public var value:String;
      
      // 属性列表
      protected var _attributes:FAttributes;
      
      // 节点列表
      protected var _nodes:FXmlNodes;
      
      //============================================================
      // <T>创建实例对象。</T>
      //
      // @param p:name 名称
      // @return 实例对象
      //============================================================
      public function FXmlNode(p:String = "Node"){
         name = p;
      }
      
      //============================================================
      // <T>是否为指定名称。</T>
      //
      // @param p:name 名称
      // @return 是否相等
      //============================================================
      public function isName(p:String):Boolean{
         return (name == p);
      }
      
      //============================================================
      // <T>获得属性列表。</T>
      //
      // @return 属性列表
      //============================================================
      public function get attributes():FAttributes{
         if(!_attributes){
            _attributes = new FAttributes();
         }
         return _attributes;
      }
      
      //============================================================
      // <T>获得节点列表。</T>
      //
      // @return 节点列表
      //============================================================
      public function get nodes():FXmlNodes{
         if(!_nodes){
            _nodes = new FXmlNodes();
         }
         return _nodes;
      }
      
      //============================================================
      // <T>是否含有内容。</T>
      //
      // @return 是否含有
      //============================================================
      public function hasValue():Boolean{
         return value ? (value.length > 0) : false;
      }
      
      //============================================================
      // <T>是否含有任何属性。</T>
      //
      // @return 是否含有
      //============================================================
      public function hasAttribute():Boolean{
         return _attributes ? !_attributes.isEmpty() : false;
      }
      
      //============================================================
      // <T>是否含有指定属性。</T>
      //
      // @param p:name 属性名称
      // @return 是否含有
      //============================================================
      public function contains(p:String):Boolean{
         return _attributes ? _attributes.contains(p) : false;
      }
      
      //============================================================
      // <T>获得指定属性名称的属性内容。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 缺省内容
      // @return 属性内容
      //============================================================
      [Inline]
      public final function get(pn:String, pv:String = null):String{
         if(_attributes){
            var v:String = _attributes.get(pn);
            if(v){
               return v;
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得指定属性名称的整数内容。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 缺省内容
      // @return 属性内容
      //============================================================
      [Inline]
      public final function getBoolean(pn:String, pv:Boolean=false):Boolean{
         if(_attributes){
            var v:String = _attributes.get(pn);
            if(v){
               return RBoolean.isTrue(v);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得指定属性名称的整数内容。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 缺省内容
      // @return 属性内容
      //============================================================
      [Inline]
      public final function getInt(pn:String, pv:int=0):int{
         if(_attributes){
            var v:String = _attributes.get(pn);
            if(v){
               return RInteger.toInt(v);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得指定属性名称的整数内容。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 缺省内容
      // @return 属性内容
      //============================================================
      [Inline]
      public final function getUint(pn:String, pv:uint=0):uint{
         if(_attributes){
            var v:String = _attributes.get(pn);
            if(v){
               return RInteger.toUint(v);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得指定属性名称的整数内容。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 缺省内容
      // @return 属性内容
      //============================================================
      [Inline]
      public final function getHexInt(pn:String, pv:int=0):int{
         if(_attributes){
            var v:String = _attributes.get(pn);
            if(v){
               return RInteger.toInt16(v);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得指定属性名称的浮点数内容。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 缺省内容
      // @return 属性内容
      //============================================================
      [Inline]
      public final function getNumber(pn:String, pv:Number=0):Number{
         if(_attributes){
            var v:String = _attributes.get(pn);
            if(v){
               if(v == "NaN"){
                  return 0;
               }
               return parseFloat(v);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>设定指定属性。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 属性内容
      //============================================================
      [Inline]
      public final function set(pn:String, pv:String):void{
         attributes.set(pn, pv);
      }
      
      //============================================================
      // <T>设定指定属性。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 属性内容
      //============================================================
      [Inline]
      public final function setBoolean(pn:String, pv:Boolean):void{
         var v:String = pv ? "Y" : "N";
         attributes.set(pn, v);
      }
      
      //============================================================
      // <T>设定指定属性。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 属性内容
      //============================================================
      [Inline]
      public final function setInt(pn:String, pv:int):void{
         var v:String = pv.toString();
         attributes.set(pn, v);
      }
      
      //============================================================
      // <T>设定指定属性。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 属性内容
      //============================================================
      [Inline]
      public final function setFloat(pn:String, pv:Number):void{
         var v:String = RFloat.format(pv);
         attributes.set(pn, v);
      }
      
      //============================================================
      // <T>设定指定属性。</T>
      //
      // @param pn:name 属性名称
      // @param pv:value 属性内容
      //============================================================
      [Inline]
      public final function setNumber(pn:String, pv:Number):void{
         var v:String = pv.toString();
         attributes.set(pn, v);
      }
      
      //============================================================
      // <T>是否含有任何节点。</T>
      //
      // @return 是否含有
      //============================================================
      [Inline]
      public final function hasNode():Boolean{
         return _nodes ? !_nodes.isEmpty() : false;
      }
      
      //============================================================
      // <T>获得子节点总数。</T>
      //
      // @return 子节点总数
      //============================================================
      [Inline]
      public final function get nodeCount():int{
         return _nodes ? _nodes.count : 0;
      }
      
      //============================================================
      // <T>获得指定索引位置的节点对象。</T>
      //
      // @param p:index 索引位置
      // @return 节点对象
      //============================================================
      [Inline]
      public final function node(p:int):FXmlNode{
         if(null == _nodes){
            return null;
         }
         return _nodes.get(p);
      }
      
      //============================================================
      // <T>查找指定名称的子节点。</T>
      //
      // @param pn:name 节点名称
      // @param pan:attributeName 属性名称
      // @param pav:attributeValue 属性内容
      // @return 子节点
      //============================================================
      public function findNode(pn:String, pan:String = null, pav:String = null):FXmlNode{
         if(null == _nodes){
            return null;
         }
         return _nodes.find(pn, pan, pav);
      }
      
      //============================================================
      // <T>查找指定名称的子节点文本内容。</T>
      //
      // @param pn:name 节点名称
      // @param pan:attributeName 属性名称
      // @param pav:attributeValue 属性内容
      // @return 文本内容
      //============================================================
      public function findText(pn:String, pan:String = null, pav:String = null):String{
         if(_nodes){
            var n:FXmlNode = _nodes.find(pn, pan, pav);
            if(n){
               return n.value;
            }
         }
         return null;
      }
      
      //============================================================
      // <T>创建当前节点的一个子节点。</T>
      //
      // @param p:name 名称
      // @return 子节点
      //============================================================
      public function create(p:String):FXmlNode{
         var n:FXmlNode = new FXmlNode(p);
         nodes.push(n);
         return n;
      }
      
      //============================================================
      // <T>增加一个子节点到子节点列表。</T>
      //
      // @param p:node 子节点
      //============================================================
      public function push(p:FXmlNode):void{
         nodes.push(p);
      }
      
      //============================================================
      // <T>获得节点的XML字符串。</T>
      //
      // @param px:xml XML字符串
      // @param pl:level 缩进级别
      //============================================================
      protected function toXml(px:FString, pl:int = 0):void{
         // 追加内容
         px.appendRepeat("   ", pl);
         px.append("<", name);
         if(hasAttribute()){
            var ac:int = _attributes.count;
            for(var an:int = 0; an < ac; an++){
               var av:String = _attributes.value(an);
               if(av && av.length){
                  px.append(' ', _attributes.name(an), "=\"", av, "\"");
               }
            }
         }
         // 追加节点结束
         var bn:Boolean = hasNode();
         var bv:Boolean = hasValue();
         if(!bn && !bv){
            px.append('/');
         }
         px.append(">\n");
         // 追加节点
         if(bn){
            var nc:int = _nodes.count;
            for(var nn:int = 0; nn < nc; nn++){
               _nodes.get(nn).toXml(px, pl + 1);
            }
         }
         if(bv){
            px.append(value);
         }
         if(bn || bv){
            if(bn){
               px.appendRepeat("   ", pl);
            }
            px.append("</", name, ">\n");
         }
      }
      
      //============================================================
      // <T>获得节点的XML字符串。</T>
      //
      // @return XML字符串
      //============================================================
      public function xml():String{
         var x:FString = new FString();
         toXml(x);
         return x.toString();
      }
      
      //============================================================
      // <T>从输入流里反序列化数据。</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserialize(p:IInput):void{
         // 读取名称
         name = p.readString();
         // 读取内容
         value = p.readString();
         // 读取属性集合
         var tc:int = p.readInt16();
         if(tc > 0){
            var ts:FAttributes = attributes;
            for(var ti:int = 0; ti < tc; ti++){
               var tn:String = p.readString();
               var tv:String = p.readString();
               ts.set(tn, tv);
            }
         }
         // 读取节点集合
         var nc:int = p.readInt16();
         if(nc > 0){
            var ns:FXmlNodes = nodes;
            for(var ni:int = 0; ni < nc; ni++){
               var nd:FXmlNode = new FXmlNode(null);
               nd.unserialize(p);
               ns.push(nd);
            }
         }
      }
   }
}