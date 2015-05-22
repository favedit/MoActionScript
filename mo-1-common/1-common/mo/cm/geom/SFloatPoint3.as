package mo.cm.geom
{
   import mo.cm.lang.RFloat;
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   import mo.cm.xml.FXmlNode;

   //============================================================
   // <T>三维浮点数。</T>
   //============================================================
   public class SFloatPoint3
   {
      // x点坐标
      public var x:Number;
      
      // y点坐标
      public var y:Number;
      
      // z点坐标
      public var z:Number;
      
      //============================================================
      // <T>构造三维浮点数。</T>
      //============================================================
      public function SFloatPoint3(px:Number = 0, py:Number = 0, pz:Number = 0){
         x = px;
         y = py;
         z = pz;
      }
      
      //============================================================
      // <T>初始化为最小数值。</T>
      //============================================================
      public function initializeMin():void{
         x = y = z = Number.NEGATIVE_INFINITY;
      }
      
      //============================================================
      // <T>初始化为最大数值。</T>
      //============================================================
      public function initializeMax():void{
         x = y = z = Number.POSITIVE_INFINITY;
      }

      //============================================================
      // <T>获得三维。</T>
      //============================================================
      public function get length():Number{
         return Math.sqrt((x * x) + (y * y) + (z * z));
      }
      
      //============================================================
      // <T>比较和目标点是否相等。</T>
      //
      // @params p:value 目标点
      // @return 是否相等
      //============================================================
      public function equals(p:SFloatPoint3):Boolean{
         return (x == p.x) && (y == p.y) && (z == p.z);
      }
      
      //============================================================
      //<T>获得三维浮点最小坐标</T>
      //
      //@params p:设置的坐标
      //============================================================
      public function innerMin(p:SFloatPoint3):void{
         x = (x > p.x) ? p.x : x; 
         y = (y > p.y) ? p.y : y; 
         z = (z > p.z) ? p.z : z; 
      }
      
      //============================================================
      //<T>获得三维浮点最大坐标</T>
      //
      //@params p:设置的坐标
      //============================================================
      public function innerMax(p:SFloatPoint3):void{
         x = (x < p.x) ? p.x : x; 
         y = (y < p.y) ? p.y : y; 
         z = (z < p.z) ? p.z : z; 
      }
      
      //============================================================
      //<T>三维浮点坐标增加</T>
      //
      //@params value:改变的坐标大小
      //============================================================
      public function innerAdd(value:SFloatPoint3):void{
         x += value.x; 
         y += value.y; 
         z += value.z; 
      }

      //============================================================
      //<T>三维浮点坐标减小</T>
      //
      //@params value:改变的坐标大小
      //============================================================
      public function innerSub(value:SFloatPoint3):void{
         x -= value.x; 
         y -= value.y; 
         z -= value.z; 
      }
      
      //============================================================
      // <T>乘法处理。</T>
      //
      // @param p:value 数值
      //============================================================
      public function mul(p:Number):void{
         x *= p; 
         y *= p; 
         z *= p; 
      }
      
      //============================================================
      // <T>除法处理。</T>
      //
      // @param p:value 数值
      //============================================================
      public function div(p:Number):void{
         x /= p; 
         y /= p; 
         z /= p; 
      }
      
      //============================================================
      //<T>获得两点间距离</T>
      //
      //@params value:另一点的位置
      //============================================================
      public function distance(value:SFloatPoint3):Number{
         var cx:Number = x - value.x; 
         var cy:Number = y - value.y; 
         var cz:Number = z - value.z;
         return Math.sqrt((cx * cx) + (cy * cy) + (cz * cz));
      }
      
      //============================================================
      //<T>获得两点间距离</T>
      //
      //@params px:另一点的x坐标
      //        py:另一点的y坐标
      //        pz:另一点的z坐标
      //============================================================
      public function distance3(px:Number, py:Number, pz:Number):Number{
         var cx:Number = x - px; 
         var cy:Number = y - py; 
         var cz:Number = z - pz;
         return Math.sqrt((cx * cx) + (cy * cy) + (cz * cz));
      }

      //============================================================
      // <T>设置全部数据。</T>
      //
      // @params value 坐标数据
      //============================================================
      public function setAll(value:Number = 0):void{
         x = value;
         y = value;
         z = value;
      }
      
      //============================================================
      // <T>设置坐标某一参数数据。</T>
      //
      //@params px x点坐标
      //        py y点坐标
      //        pz z点坐标
      //============================================================
      public function set(px:Number = 0, py:Number = 0, pz:Number = 0):void{
         x = px;
         y = py;
         z = pz;
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
         z += pd.z * pl;
      }

      //============================================================
      // <T>设置浮点坐标</T>
      //
      //@params value 设置的坐标
      //============================================================
      public function assign(value:SFloatPoint3):void{
         x = value.x;
         y = value.y;
         z = value.z;
      }

      //============================================================
      public function transform3x3(matrix:SFloatMatrix):void{
         //x = (x * matrix.get(0, 0) + y * matrix.get(0, 1) + z * matrix.get(0, 2));
         //y = (x * matrix.get(1, 0) + y * matrix.get(1, 1) + z * matrix.get(1, 2));
         //z = (x * matrix.get(2, 0) + y * matrix.get(2, 1) + z * matrix.get(2, 2));
      }
      
      //============================================================
      public function transform4x3(matrix:SFloatMatrix):void{
      } 
      
      //============================================================
      public function transform4x4(matrix:SFloatMatrix):void{
         x = (x * matrix.data[0]) + (y * matrix.data[4]) + (z * matrix.data[ 8]) + matrix.data[12];
         y = (x * matrix.data[1]) + (y * matrix.data[5]) + (z * matrix.data[ 9]) + matrix.data[13];
         z = (x * matrix.data[2]) + (y * matrix.data[6]) + (z * matrix.data[10]) + matrix.data[14];
      }
      
      //============================================================
      public function interpolateTo(value:SFloatPoint3, rate:Number):void{
         x += (value.x - x) * rate;
         y += (value.y - y) * rate;
         z += (value.z - z) * rate;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         x = p.getNumber("x");
         y = p.getNumber("y");
         z = p.getNumber("z");
      }
   
      //============================================================
      // <T>存储设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function saveConfig(p:FXmlNode):void{
         p.set("x", x.toString());
         p.set("y", y.toString());
         p.set("z", z.toString());
      }

      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize(p:IOutput):void{
         p.writeFloat(x);
         p.writeFloat(y);
         p.writeFloat(z);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize(p:IInput):void{
         x = p.readFloat();
         y = p.readFloat();
         z = p.readFloat();
      }
      
      //============================================================
      // <T>获得格式化内容。</T>
      //
      // @return 格式化内容
      //============================================================
      public function format():String{
         return RFloat.format(x) + "," + RFloat.format(y) + "," + RFloat.format(z); 
      }
   }
}