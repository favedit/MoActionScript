package mo.cm.geom
{
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   public class SFloatSize3
   {
      public var width:Number;
      
      public var height:Number;
      
      public var deep:Number;
      
      //============================================================
      public function SFloatSize3(w:Number = 0, h:Number = 0, d:Number = 0){
         width = w;
         height = h;
         deep = d;
      }
      
      //============================================================
      public function setAll(value:Number = 0):void{
         width = value;
         height = value;
         deep = value;
      }
      
      //============================================================
      public function set(w:Number = 0, h:Number = 0, d:Number = 0):void{
         width = w;
         height = h;
         deep = d;
      }
      
      //============================================================
      public function length():Number{
         return Math.sqrt(width * width + height * height + deep * deep);
      }

      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param config 设置信息
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         width = config.getNumber("width");
         height = config.getNumber("height");
         deep = config.getNumber("deep");
      }
      
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.set("width", width.toString());
         config.set("height", height.toString());
         config.set("deep", deep.toString());
      }
   }
}