package mo.cm.console.message
{
   import mo.cm.core.content.RHtml;
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>消息。</T>
   //============================================================
   public class FMessage extends FObject
   {
      // 代码
      public var code:String;
      
      // 内容
      public var message:String;
      
      //============================================================
      // <T>构造消息。</T>
      //============================================================
      public function FMessage(){
      }
      
      //============================================================
      // <T>加载配置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         code = p.get("code");
         message = RHtml.fromat(p.value);
      }
   }
}