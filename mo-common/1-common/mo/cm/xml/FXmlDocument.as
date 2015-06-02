package mo.cm.xml
{   
   import flash.xml.XMLDocument;
   import flash.xml.XMLNode;
   import flash.xml.XMLNodeType;
   
   import mo.cm.core.device.RTimer;
   import mo.cm.lang.FObject;
   import mo.cm.lang.FString;
   import mo.cm.logger.RLogger;
   import mo.cm.stream.IInput;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>配置文档。</T>
   //============================================================
   public class FXmlDocument extends FObject
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FXmlDocument);
      
      // 根节点
      public var root:FXmlNode = new FXmlNode("Configuration");
      
      //============================================================
      // <T>构造配置文档。</T>
      //============================================================
      public function FXmlDocument(){
         root.set("name", "root");
      }
      
      //============================================================
      // <T>创建节点。</T>
      //
      // @param p:name 名称
      // @return 节点
      //============================================================
      public function createNode(p:String = null):FXmlNode{
         return new FXmlNode(p);
      }
      
      //============================================================
      // <T>同步元素到节点内。</T>
      //
      // @param pn:node 节点
      // @param pe:element 元素
      //============================================================
      protected function syncNodeFromElement(pn:FXmlNode, pe:XMLNode):void{
         // 读取节点名称
         pn.name = pe.nodeName;
         // 读取所有属性
         for(var name:String in pe.attributes){
            pn.set(name, pe.attributes[name]);
         }
         // 读取所有节点
         var count:int = pe.childNodes.length;
         if(count > 0){
            var value:FString = new FString();
            for (var n:int; n < count; n++ ) {
               var childElement:XMLNode = pe.childNodes[n];
               if(XMLNodeType.ELEMENT_NODE == childElement.nodeType){
                  // 读取文档节点
                  var childNode:FXmlNode = createNode();
                  syncNodeFromElement(childNode, childElement);
                  pn.push(childNode);
               }if (XMLNodeType.TEXT_NODE == childElement.nodeType){
                  // 读取文本节点
                  value.append(childElement.nodeValue);
               }
            }
            // 读取节点内容
            pn.value = value.toString();
         }
      }  
      //============================================================
      // <T>加载XML字符串。</T>
      //
      // @param p:xml 字符串
      //============================================================
      public function loadXml(p:String):void{
         // _logger.debug("loadXml", "load Xml:\n" + xml.substr(0, 1000), null);
         var xd:XMLDocument = new XMLDocument(p);
         var c:int = xd.childNodes.length;
         for(var n:int; n < c; n++){
            var e:XMLNode = xd.childNodes[n];
            if(XMLNodeType.ELEMENT_NODE == e.nodeType){
               syncNodeFromElement(root, e);
               break;
            }
         }
      }
      
      //============================================================
      // <T>从输入流里反序列化数据。</T>
      //
      // @param p:input 输入流
      //============================================================
      public function unserialize(p:IInput):void{
         var st:Number = RTimer.getTick();
         root.unserialize(p);
         _logger.debugTrack("unserialize", RTimer.getTick() - st, "Unserialize config data.");
      }
      
      //============================================================
      // <T>获得XML字符串。</T>
      //
      // @return 字符串
      //============================================================
      public function xml():String{
         return root.xml();
      }
   }  
}