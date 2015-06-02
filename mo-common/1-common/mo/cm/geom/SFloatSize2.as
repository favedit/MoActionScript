package mo.cm.geom
{
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   public class SFloatSize2
   {
      public var width:Number;
      
      public var height:Number;
      
      //============================================================
      public function SFloatSize2(pw:Number = 0, ph:Number = 0){
         width = pw;
         height = ph;
      }
      
      //============================================================
      public function setAll(pv:Number = 0):void{
         width = pv;
         height = pv;
      }
      
      //============================================================
      public function set(pw:Number = 0, ph:Number = 0):void{
         width = pw;
         height = ph;
      }
      
      //============================================================
      public function isLarge(pw:Number = 0, ph:Number = 0):Boolean{
         return (width > pw) && (height > ph);
      }

      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param config 设置信息
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         width = config.getNumber("width");
         height = config.getNumber("height");
      }
      
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.set("width", width.toString());
         config.set("height", height.toString());
      }
   }
}