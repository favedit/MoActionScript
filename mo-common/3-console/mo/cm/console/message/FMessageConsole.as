package mo.cm.console.message
{
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.lang.FDictionary;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>消息控制台。</T>
   //============================================================
   public class FMessageConsole extends FConsole
   {
      // 消息字典
      public var messages:FDictionary = new FDictionary();
      
      //============================================================
      // <T>构造消息控制台。</T>
      //============================================================
      public function FMessageConsole(){
         name = "common.message.console";
      }
      
      //============================================================
      // <T>加载配置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 加载消息
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Message")){
               var m:FMessage = new FMessage();
               m.loadConfig(x);
               messages.set(m.code, m);
            }
         }
      }

      //============================================================
      // <T>获得代码内容。</T>
      //
      // @param p:code 代码
      //============================================================
      public function get(p:String):String{
         var m:FMessage = messages.get(p);
         if(!m){
            RFatal.throwFatal("Message code is invalid. (code={1})", p);
         }
         return m.message;
      }

      //============================================================
      // <T查找得代码内容。</T>
      //
      // @param p:code 代码
      //============================================================
      public function find(p:String):String{
         var m:FMessage = messages.get(p);
         return m ? m.message : null;
      }
   }
}