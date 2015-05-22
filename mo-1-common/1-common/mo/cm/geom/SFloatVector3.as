package mo.cm.geom
{
   import mo.cm.lang.RFloat;
   import mo.cm.stream.IInput;
   import mo.cm.xml.FXmlNode;

   //==========================================================
   // <T>三维向量。</T>
   //
   // @tool SFloatVector
   // @author WEIFH
   // @Date 日期 11.8.25
   // @version 1.0.1
   //==========================================================
   public class SFloatVector3
   {
      // 横轴值
      public var x:Number;
      
      // 竖轴值
      public var y:Number;
      
      // 深度轴
      public var z:Number;
      
      //============================================================
      // <T>构造。</T>
      //============================================================
      public function SFloatVector3(px:Number = 0, py:Number = 0, pz:Number = 0){
         x = px;
         y = py;
         z = pz;
      }
      
      //============================================================
      // <T>接收三维向量并赋值。</T>
		//
		// @params point:SFloatPoint3 接收的三维向量
      //============================================================
      public function assignPoint3(point:SFloatPoint3):void{
         x = point.x;
         y = point.y;
         z = point.z;
      }

      //============================================================
      // <T>根据开始坐标和结束坐标计算方向。</T>
      //
      // @param ps:source 开始坐标
      // @param pt:target 结束坐标
      //============================================================
      public function assignDirection(ps:SFloatPoint3, pt:SFloatPoint3):void{
         x = pt.x - ps.x;
         y = pt.y - ps.y;
         z = pt.z - ps.z;
      }
      
      //============================================================
      // <T>设定各方向轴的值。</T>
      //
      // @params px:Number 横轴值
      //         py:Number 竖轴值
      //         pz:Number 深度值
      //============================================================
      public function set(px:Number, py:Number, pz:Number):void{
         x = px;
         y = py;
         z = pz;
      }
      
      //============================================================
      // <T>设置所有向量值。</T>
      //
      // @ params value:Number 要设置的数据
      //============================================================
      public function setAll(value:Number):void{
         x = y = z = value;
      }
      
      //============================================================
      // <T>判断向量是否相等。</T>
      //
		// @params point:SFloatPoint3 要比较的向量
		// @return Boolean 返回值
      //============================================================
      public function equals(value:SFloatVector3):Boolean{
         return ((x == value.x) && (y == value.y) && (z == value.z));
      }
      
      //============================================================
      // <T>返回向量的模</T>
      // 
		// @return Number 返回值
      //============================================================
      public function absolute():Number{
         return Math.sqrt((x * x) + (y * y) + (z * z));
      }
      
      //============================================================
      // <T>标准化处理。<T/>
      //
      // @param p:value 单位
      //============================================================
      public function normalize(p:Number = 1.0):void{
         var a:Number = Math.sqrt((x * x) + (y * y) + (z * z));
         var r:Number = p / a;
         x *= r;
         y *= r;
         z *= r;
      }
      
      //============================================================
      // <T>增加一个向量</T>
      // 
      // @params value:SFloatVector 要相加的向量
      //============================================================
      public function add(value:SFloatVector3):void{
         x += value.x;
         y += value.y;
         z += value.z;
      }
      
      //============================================================
      // <T>计算两向量之和,以一个新的矩阵返回</T>
      // 
      // @params value:SFloatVector3 要相加的向量
		// @return SFloatVector3 返回值
      //============================================================
      public function addAs(value:SFloatVector3):SFloatVector3{
         return new SFloatVector3(x + value.x, y + value.y, z + value.z);
      }
      
      //============================================================
      // <T>计算两向量之差</T>
      // 
      // @params value:SFloatVector 要相除的向量
      //============================================================
      public function sub(value:SFloatVector3):void{
         x -= value.x;
         y -= value.y;
         z -= value.z;
      }
      
      //============================================================
      // <T>计算两向量之差,以一个新的矩阵返回</T>
      // 
      // @params value:SFloatVector 要相减的向量
		// @return SFloatVector3 返回值
      //============================================================
      public function subAs(value:SFloatVector3):SFloatVector3{
         return new SFloatVector3(x - value.x, y - value.y, z - value.z);
      }
      
      //============================================================
      // <T>向量数乘</T>
      //
      // @params value:Number 要相乘的向量
      //============================================================
      public function mul(value:Number):void{
         x = x * value;
         y = y * value;
         z = z * value;
      }
      
      //============================================================
      // <T>向量叉乘</T>
      //
      // @params value:SFloatVector3 要相乘的向量
      //============================================================
      public function innerCross(value:SFloatVector3):void{
         x = (y * value.z) - (z * value.y);
         y = (z * value.x) - (x * value.z);
         z = (x * value.y) - (y * value.x);
      }
      
      //============================================================
      // 
      //
      //============================================================
      public function cross(input:SFloatVector3, output:SFloatVector3):void{
         output.x = (y * input.z) - (z * input.y);
         output.y = (z * input.x) - (x * input.z);
         output.z = (x * input.y) - (y * input.x);
      }

      //============================================================
      // <T>向量点乘</T>
      //
      // @params value:SFloatVector3 要相乘的向量
      //============================================================
      public function dot(value:SFloatVector3):Number{
         return (x * value.x) + (y * value.y) + (z * value.z);
      }
      
      //============================================================
      // <T>向量点乘</T>
      //
      // @params value:SFloatVector3 要相乘的向量
      //============================================================
      public function dotPoint3(value:SFloatPoint3):Number{
         return (x * value.x) + (y * value.y) + (z * value.z);
      }
      
      //============================================================
      // <T>向量除法。</T>
      //
      // @ params value:SFloatVector3 除数
      //============================================================
      public function div(value:SFloatVector3):void{
         x /= value.x;
         y /= value.y;
         z /= value.z;
      }
      
      //============================================================
      // <T>向量除法，不改变自身，产生一个新的向量。</T>
      //
      // @ params value:Number 要设置的数据
      //============================================================
      public function divAs(value:SFloatVector3):SFloatVector3{
         return new SFloatVector3(x / value.x, y / value.y, z / value.z)
      }
      
      //============================================================
      // <T>向量之间的夹角。</T>
      //
      // @ params value:SFloatVector 要设置的数据
      // @ return Number 返回值
      //============================================================
      public function angle(value:SFloatVector3):Number{
         var result:Number = dot(value);
         return Math.acos(result);
      }
      
      //============================================================
      // <T>向量取反。</T>
      //
      // @ params value:Number 要设置的数据
      //============================================================
      public function negative():void{
         x = -x;
         y = -y;
         z = -z;
      }
      
      //============================================================
      // <T>获得当前向量的反向量。</T>
      //
      // @ return SFloatVector3 返回值
      //============================================================
      public function negativeAs():SFloatVector3{
         return new SFloatVector3(-x, -y, -z);
      }
      
      //============================================================
      // <T>向量清零。</T>
      //
      //============================================================
      public function reset():void{
         x = y = z = 0;
      }
      
      
      //============================================================
      // <T>复制一个向量到自己。</T>
      //
      // @params value:SFloatVector 指定的向量
      //============================================================
      public function assign(value:SFloatVector3):void{
         x = value.x
         y = value.y;
         z = value.z;
      }
      
      //============================================================
      // <T>获得当前向量的克隆体。</T>
      //
      // @ return SFloatVector3 返回值
      //============================================================
      public function clone():SFloatVector3{
         return new SFloatVector3(x, y, z);
      }
   
      //============================================================
      public function format():String{
         return RFloat.format(x) + "," + RFloat.format(y) + "," + RFloat.format(z); 
      }

      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param config:FXmlNode 设置信息
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         x = config.getNumber("x");
         y = config.getNumber("y");
         z = config.getNumber("z");
      }
   
      //============================================================
      // <T>存储信息</T>
      //
      // @param config:FXmlNode 存储信息
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         config.set("x", x.toString());
         config.set("y", y.toString());
         config.set("z", z.toString());
      }

      //============================================================
      // <T>分列信息</T>
      //
      // @param value:String 要分列的信息
      //============================================================
      public function parse(value:String):void{
         var items:Array = value.split(",");
         x = parseFloat(items[0]);
         y = parseFloat(items[1]);
         z = parseFloat(items[2]);
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
      // <T>插入信息</T>
      //
      // @params value:SFloatVector3 要篡改的向量
      //         rete:Number 要插入的信息
      //============================================================
      public function interpolateTo(value:SFloatVector3, rate:Number):void{
         x += (value.x - x) * rate;
         y += (value.y - y) * rate;
         z += (value.z - z) * rate;
      }
      
      //============================================================
      // <T>向量数乘</T>
      //
      // @params value:SFloatVector3 要相乘的向量
      //         distince:Number 
      //============================================================
      public function move(value:SFloatVector3, distince:Number):void{
         x += distince * value.x;
         y += distince * value.y;
         z += distince * value.z;
      }
      
      //============================================================
      public function moveXZ(value:SFloatVector3, distince:Number):void{
         x += distince * value.x;
         z += distince * value.z;
      }

      //============================================================
      public function moveZX(value:SFloatVector3, distince:Number):void{
         x += distince * value.z;
         z += distince * value.x;
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
      // <T>得到字符串</T>
      //
      // @return String 返回值
      //============================================================
      public function toString():String{
         return x.toString() + "," + y.toString() + "," + z.toString();
      }
   }
}