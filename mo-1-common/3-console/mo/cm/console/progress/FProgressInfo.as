package mo.cm.console.progress
{
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>加载进度信息。</T>
   //============================================================
   public class FProgressInfo extends FObject
   {
      // 代码
      public var code:String;
      
      // 内容
      public var note:String;
      
      //============================================================
      // <T>构造加载进度信息。</T>
      //============================================================
      public function FProgressInfo(){
      }
      
      //============================================================
      // <T>加载配置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         code = p.get("code");
         note = p.value;
      }
   }
}