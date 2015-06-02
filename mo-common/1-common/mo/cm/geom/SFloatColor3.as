package mo.cm.geom
{
   import mo.cm.stream.IInput;
   import mo.cm.xml.FXmlNode;

   public class SFloatColor3
   {
      public var r:Number;
      
      public var g:Number;
      
      public var b:Number;
      
      //============================================================
      public function SFloatColor3(pr:Number = 1.0, pg:Number = 1.0, pb:Number = 1.0){
         r = pr;
         g = pg;
         b = pb;
      }
      
      //============================================================
      public function setAll(pv:Number):void{
         r = pv;
         g = pv;
         b = pv;
      }
      
      //============================================================
      public function set(pr:Number, pg:Number, pb:Number):void{
         r = pr;
         g = pg;
         b = pb;
      }
   
      //============================================================
      public function unserialize(input:IInput):void{
         r = input.readFloat();
         g = input.readFloat();
         b = input.readFloat();
      }
      
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         if(config.contains("r")){
            r = config.getNumber("r");
         }else if(config.contains("cr")){
            r = config.getNumber("cr") / 255;
         }
         if(config.contains("g")){
            g = config.getNumber("g");
         }else if(config.contains("cg")){
            g = config.getNumber("cg") / 255;
         }
         if(config.contains("b")){
            b = config.getNumber("b");
         }else if(config.contains("cb")){
            b = config.getNumber("cb") / 255;
         }
      }
      
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.set("r", r.toString());
         config.set("g", g.toString());
         config.set("b", b.toString());
      }
   }
}