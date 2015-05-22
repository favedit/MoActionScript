package mo.cm.geom
{
   import mo.cm.lang.RFloat;
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>二维浮点数。</T>
   //============================================================
   public class SFloatPoint2
   {
      // x点坐标
      public var x:Number;
      
      // y点坐标
      public var y:Number;
      
      //============================================================
      // <T>构造二维浮点数。</T>
      //============================================================
      public function SFloatPoint2(px:Number = 0, py:Number = 0){
         x = px;
         y = py;
      }
      
      //============================================================
      // <T>初始化为最小数值。</T>
      //============================================================
      public function initializeMin():void{
         x = y = Number.NEGATIVE_INFINITY;
      }
      
      //============================================================
      // <T>初始化为最大数值。</T>
      //============================================================
      public function initializeMax():void{
         x = y = Number.POSITIVE_INFINITY;
      }
      
      //============================================================
      // <T>获得三维。</T>
      //============================================================
      public function get length():Number{
         return Math.sqrt((x * x) + (y * y));
      }
      
      //============================================================
      // <T>比较和目标点是否相等。</T>
      //
      // @params p:value 目标点
      // @return 是否相等
      //============================================================
      public function equals(p:SFloatPoint2):Boolean{
         return (x == p.x) && (y == p.y);
      }
      
      //============================================================
      //<T>三维浮点坐标增加</T>
      //
      //@params value:改变的坐标大小
      //============================================================
      public function innerAdd(p:SFloatPoint2):void{
         x += p.x; 
         y += p.y; 
      }
      
      //============================================================
      //<T>三维浮点坐标减小</T>
      //
      //@params value:改变的坐标大小
      //============================================================
      public function innerSub(p:SFloatPoint2):void{
         x -= p.x; 
         y -= p.y; 
      }
      
      //============================================================
      //<T>获得三维浮点最小坐标</T>
      //
      //@params p:设置的坐标
      //============================================================
      public function innerMin(p:SFloatPoint2):void{
         x = (x > p.x) ? p.x : x; 
         y = (y > p.y) ? p.y : y; 
      }
      
      //============================================================
      //<T>获得三维浮点最大坐标</T>
      //
      //@params p:设置的坐标
      //============================================================
      public function innerMax(p:SFloatPoint2):void{
         x = (x < p.x) ? p.x : x; 
         y = (y < p.y) ? p.y : y; 
      }
      
      //============================================================
      //<T>获得两点间距离</T>
      //
      //@params value:另一点的位置
      //============================================================
      public function distance(p:SFloatPoint2):Number{
         var cx:Number = x - p.x; 
         var cy:Number = y - p.y; 
         return Math.sqrt((cx * cx) + (cy * cy));
      }
      
      //============================================================
      //<T>获得两点间距离</T>
      //
      //@params px:另一点的x坐标
      //        py:另一点的y坐标
      //        pz:另一点的z坐标
      //============================================================
      public function distance3(px:Number, py:Number):Number{
         var cx:Number = x - px; 
         var cy:Number = y - py; 
         return Math.sqrt((cx * cx) + (cy * cy));
      }
      
      //============================================================
      // <T>设置全部数据。</T>
      //
      // @params value 坐标数据
      //============================================================
      public function setAll(p:Number = 0):void{
         x = p;
         y = p;
      }
      
      //============================================================
      // <T>设置坐标某一参数数据。</T>
      //
      //@params px x点坐标
      //        py y点坐标
      //        pz z点坐标
      //============================================================
      public function set(px:Number = 0, py:Number = 0):void{
         x = px;
         y = py;
      }
      
      //============================================================
      // <T>三维坐标移动</T>
      //
      // @param pd:direction 方向
      // @param pl:length 长度
      //============================================================
      public function move(pd:SFloatVector3, pl:Number):void{
         x += pd.x * pl;
         y += pd.y * pl;
      }
      
      //============================================================
      // <T>设置浮点坐标</T>
      //
      //@params value 设置的坐标
      //============================================================
      public function assign(value:SFloatPoint2):void{
         x = value.x;
         y = value.y;
      }
      
      //============================================================
      public function transform3x3(matrix:SFloatMatrix):void{
         //x = (x * matrix.get(0, 0) + y * matrix.get(0, 1) + z * matrix.get(0, 2));
         //y = (x * matrix.get(1, 0) + y * matrix.get(1, 1) + z * matrix.get(1, 2));
         //z = (x * matrix.get(2, 0) + y * matrix.get(2, 1) + z * matrix.get(2, 2));
      }
      
      //============================================================
      public function interpolateTo(value:SFloatPoint2, rate:Number):void{
         x += (value.x - x) * rate;
         y += (value.y - y) * rate;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         x = p.getNumber("x");
         y = p.getNumber("y");
      }
      
      //============================================================
      // <T>存储设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function saveConfig(p:FXmlNode):void{
         p.set("x", x.toString());
         p.set("y", y.toString());
      }
      
      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize(p:IOutput):void{
         p.writeFloat(x);
         p.writeFloat(y);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize(p:IInput):void{
         x = p.readFloat();
         y = p.readFloat();
      }
      
      //============================================================
      // <T>获得格式化内容。</T>
      //
      // @return 格式化内容
      //============================================================
      public function format():String{
         return RFloat.format(x) + "," + RFloat.format(y); 
      }
   
      //============================================================
      public function parse(p:String):void{
         if(p && p.length > 0){
            var s:int = p.indexOf(",");
            if(-1 != s){
               x = parseFloat(p.substring(0, s)); 
               y = parseFloat(p.substring(s + 1)); 
            }else{
               x = y = parseFloat(p); 
            }
         }
      }
   }
}