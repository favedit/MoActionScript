package mo.cm.geom
{
   import mo.cm.lang.RFloat;
   import mo.cm.stream.IInput;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>浮点数颜色。</T>
   //============================================================
   public class SFloatColor4
   {
      // 透明度
      public var a:Number;
      
      // 红色
      public var r:Number;
      
      // 绿色
      public var g:Number;
      
      // 蓝色
      public var b:Number;
      
      //============================================================
      // <T>构造浮点数颜色。</T>
      //============================================================
      public function SFloatColor4(pr:Number = 0.0, pg:Number = 0.0, pb:Number = 0.0, pa:Number = 1.0){
         r = pr;
         g = pg;
         b = pb;
         a = pa;
      }
      
      //============================================================
      public function setAll(pv:Number):void{
         r = pv;
         g = pv;
         b = pv;
         a = pv;
      }
      
      //============================================================
      public function set(pr:Number = 0.0, pg:Number = 0.0, pb:Number = 0.0, pa:Number = 1.0):void{
         r = pr;
         g = pg;
         b = pb;
         a = pa;
      }
      
      //============================================================
      public function add(pr:Number = 0.0, pg:Number = 0.0, pb:Number = 0.0, pa:Number = 0.0):void{
         r += pr;
         g += pg;
         b += pb;
         a += pa;
      }

      //============================================================
      public function prependSubAll(v:Number):void{
         r = v - r;
         g = v - g;
         b = v - b;
         a = v - a;
      }
      
      //============================================================
      // <T>接收全部数据信息。</T>
      //
      // @param p:value 数据信息
      //============================================================
      public function assign(p:SFloatColor4):void{
         r = p.r;
         g = p.g;
         b = p.b;
         a = p.a;
      }

      //============================================================
      public function addTwo(v1:SFloatColor4, v2:SFloatColor4):void{
         r = v1.r + v2.r;
         g = v1.g + v2.g;
         b = v1.b + v2.b;
         a = v1.a + v2.a;
      }

      //============================================================
      public function mulTwo(v1:SFloatColor4, v2:SFloatColor4):void{
         r = v1.r * v2.r;
         g = v1.g * v2.g;
         b = v1.b * v2.b;
         a = v1.a * v2.a;
      }
      
      //============================================================
      public function mulTwoRate(v1:SFloatColor4, v2:SFloatColor4):void{
         a = v1.a * v2.a;
         r = v1.r * v2.r * a;
         g = v1.g * v2.g * a;
         b = v1.b * v2.b * a;
      }
      
      //============================================================
      public function setPower(v:SFloatColor4):void{
         r = v.r * v.a;
         g = v.g * v.a;
         b = v.b * v.a;
         a = v.a;
      }

      //============================================================
      public function mulRgb(v:Number):void{
         r *= v;
         g *= v;
         b *= v;
      }
      
      //============================================================
      public function mul(v:Number):void{
         a *= v;
         r *= v;
         g *= v;
         b *= v;
      }

      //============================================================
      public function mulColor4(v:SFloatColor4):void{
         a *= v.a;
         r *= v.r;
         g *= v.g;
         b *= v.b;
      }

      //============================================================
      public function mulColor3(v:SFloatColor4):void{
         r *= v.r;
         g *= v.g;
         b *= v.b;
      }
      
      //============================================================
      public function mulColor4Power(v:SFloatColor4):void{
         r *= v.r * v.a;
         g *= v.g * v.a;
         b *= v.b * v.a;
      }

      //============================================================
      public function unserialize(input:IInput):void{
         r = input.readFloat();
         g = input.readFloat();
         b = input.readFloat();
         a = input.readFloat();
      }
      
      //============================================================
      public function parse(value:String):void{
         var items:Array = value.split(",");
         r = RFloat.toFloat(items[0]); 
         g = RFloat.toFloat(items[1]); 
         b = RFloat.toFloat(items[2]); 
         a = RFloat.toFloat(items[3]); 
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
         if(config.contains("a")){
            a = config.getNumber("a");
         }else if(config.contains("ca")){
            a = config.getNumber("ca") / 255;
         }
      }

      //============================================================
      public function loadPowerConfig(config:FXmlNode, prefix:String = ""):void{
         if(config.contains(prefix + "r")){
            r = config.getNumber(prefix + "r");
         }else if(config.contains(prefix + "cr")){
            r = config.getNumber(prefix + "cr") / 255;
         }
         if(config.contains(prefix + "g")){
            g = config.getNumber(prefix + "g");
         }else if(config.contains(prefix + "cg")){
            g = config.getNumber(prefix + "cg") / 255;
         }
         if(config.contains(prefix + "b")){
            b = config.getNumber(prefix + "b");
         }else if(config.contains(prefix + "cb")){
            b = config.getNumber(prefix + "cb") / 255;
         }
         if(config.contains(prefix + "a")){
            a = config.getNumber(prefix + "a");
         }else if(config.contains(prefix + "ca")){
            a = config.getNumber(prefix + "ca") / 255;
         }
         if(config.contains(prefix + "power")){
            a = config.getNumber(prefix + "power");
         }else if(config.contains(prefix + "cpower")){
            a = config.getNumber(prefix + "cpower") / 255;
         }
      }
      
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.set("r", r.toString());
         config.set("g", g.toString());
         config.set("b", b.toString());
         config.set("a", a.toString());
      }

      //============================================================
      // <T>存储数据信息到设置节点中。</T>
      //
      // @param p:xconfig 设置节点
      //============================================================
      public function savePowerConfig(p:FXmlNode, prefix:String = ""):void{
         p.set(prefix + "r", r.toString());
         p.set(prefix + "g", g.toString());
         p.set(prefix + "b", b.toString());
         p.set(prefix + "power", a.toString());
      }
   }
}