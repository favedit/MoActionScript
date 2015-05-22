package mo.cm.geom
{
   import flash.utils.ByteArray;
   
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>浮点数4x4矩阵。</T>
   // <P>数据位置
   //       0  1  2  3
   //       4  5  6  7
   //       8  9 10 11
   //      12 13 14 15
   // </P>
   //============================================================
   public class SFloatMatrix
   {
      public static var IdentityData:Vector.<Number> = new Vector.<Number>(16, true);
      
      public static var TargetData:Vector.<Number> = new Vector.<Number>(16, true);
      
      public static var TempData:Vector.<Number> = new Vector.<Number>(16, true);
      
      public var serial:uint = 0;
      
      public var dirtyValue:Boolean = false;
      
      public var dirtyData:Boolean = false;
      
      public var tx:Number = 0;
      
      public var ty:Number = 0;
      
      public var tz:Number = 0;
      
      public var rx:Number = 0;
      
      public var ry:Number = 0;
      
      public var rz:Number = 0;
      
      public var sx:Number = 1;
      
      public var sy:Number = 1;
      
      public var sz:Number = 1;
      
      public var data:Vector.<Number> = new Vector.<Number>(16, true);
      
		//============================================================
		// 数据初始化
		{
			IdentityData[ 0] = 1;
			IdentityData[ 1] = 0;
			IdentityData[ 2] = 0;
			IdentityData[ 3] = 0;
			IdentityData[ 4] = 0;
			IdentityData[ 5] = 1;
			IdentityData[ 6] = 0;
			IdentityData[ 7] = 0;
			IdentityData[ 8] = 0;
			IdentityData[ 9] = 0;
			IdentityData[10] = 1;
			IdentityData[11] = 0;
			IdentityData[12] = 0;
			IdentityData[13] = 0;
			IdentityData[14] = 0;
			IdentityData[15] = 1;
		}
		
      //============================================================
      // <T>构造浮点数4x4矩阵。</T>
      //============================================================
      public function SFloatMatrix(){
         for(var n:int = 0; n < 16; n++){
            data[n] = IdentityData[n]
         }
      }
      
      //============================================================
      public function isChanged():Boolean{
         if (tx || ty || tz || rx || ry || rz) {
            return true;
         }
         if ((sx != 1) || (sy != 1) || (sz != 1)) {
            return true;
         }
         return false;
      }
      
      //============================================================
      public function get angleX():Number{
         return RMath.RadianRate * rx;
      }
      
      //============================================================
      public function set angleX(v:Number):void{
         rx = RMath.DegreeRate * v;
      }

      //============================================================
      public function get angleY():Number{
         return RMath.RadianRate * ry;
      }
      
      //============================================================
      public function set angleY(v:Number):void{
         ry = RMath.DegreeRate * v;
      }
      //============================================================
      public function get angleZ():Number{
         return RMath.RadianRate * rz;
      }
      
      //============================================================
      public function set angleZ(v:Number):void{
         rz = RMath.DegreeRate * v;
      }

      //============================================================
      // <T>设置平移内容。</T>
      //============================================================
      public function translate(x:Number, y:Number, z:Number):void{
         tx = x;
         ty = y;
         tz = z;
         dirtyData = true;
      }
      
      //============================================================
      // <T>设置旋转内容。</T>
      //============================================================
      public function rotation(x:Number, y:Number, z:Number):void{
         rx = x;
         ry = y;
         rz = z;
         dirtyData = true;
      }
      
      //============================================================
      // <T>设置缩放内容。</T>
      //============================================================
      public function scale(x:Number, y:Number, z:Number):void{
         sx = x;
         sy = y;
         sz = z;
         dirtyData = true;
      }
      
      //============================================================
      // <T>判断矩阵是否相等。</T>
      //============================================================
      public function equalsData(p:Vector.<Number>):Boolean{
         for(var n:int = 0; n < 16; n++){
            if(data[n] != p[n]){
               return false;
            }
         }
         return true;
      }
      
      //============================================================
      // <T>判断矩阵是否相等。</T>
      //============================================================
      public function equals(p:SFloatMatrix):Boolean{
         return equalsData(p.data);
      }
      
      //============================================================
      // <T>接收矩阵数据。</T>
      //============================================================
      public function assignData(p:Vector.<Number>):void{
         data[ 0] = p[ 0];
         data[ 1] = p[ 1];
         data[ 2] = p[ 2];
         data[ 3] = p[ 3];
         data[ 4] = p[ 4];
         data[ 5] = p[ 5];
         data[ 6] = p[ 6];
         data[ 7] = p[ 7];
         data[ 8] = p[ 8];
         data[ 9] = p[ 9];
         data[10] = p[10];
         data[11] = p[11];
         data[12] = p[12];
         data[13] = p[13];
         data[14] = p[14];
         data[15] = p[15];
      }

      //============================================================
      // <T>接收矩阵。</T>
      //============================================================
      public function assign(m:SFloatMatrix):void{
         tx = m.tx;
         ty = m.ty;
         tz = m.tz;
         rx = m.rx;
         ry = m.ry;
         rz = m.rz;
         sx = m.sx;
         sy = m.sy;
         sz = m.sz;
         //------------------------------------------------------------
         assignData(m.data);
      }
      
      //============================================================
      // <T>接收数据。</T>
      // <P>返回值决定内部是否发生变化。</P>
      //============================================================
      public function attachData(p:Vector.<Number>):Boolean{
         for(var n:int = 0; n < 16; n++){
            if(data[n] != p[n]){
               data[ 0] = p[ 0];
               data[ 1] = p[ 1];
               data[ 2] = p[ 2];
               data[ 3] = p[ 3];
               data[ 4] = p[ 4];
               data[ 5] = p[ 5];
               data[ 6] = p[ 6];
               data[ 7] = p[ 7];
               data[ 8] = p[ 8];
               data[ 9] = p[ 9];
               data[10] = p[10];
               data[11] = p[11];
               data[12] = p[12];
               data[13] = p[13];
               data[14] = p[14];
               data[15] = p[15];
               return true;
            }
         }
         return false;
      }

      //============================================================
      public function attach(p:SFloatMatrix):Boolean{
         return attachData(p.data);
      }
      
      //============================================================
      // <T>更新内容到数据中。</T>
      //============================================================
      public function identity():void{
         for(var n:int = 0; n < 16; n++){
            data[n] = IdentityData[n]
         }
      }
      
      //============================================================
      // <T>设置平移内容。</T>
      //============================================================
      public function transform(i:Vector.<Number>, o:Vector.<Number>):void{
         var c:int = i.length;
         for(var n:int = 0; n < c; n += 3){
            o[n    ] = (i[n] * data[0]) + (i[n + 1] * data[4]) +(i[n + 2] * data[ 8]) + data[12];
            o[n + 1] = (i[n] * data[1]) + (i[n + 1] * data[5]) +(i[n + 2] * data[ 9]) + data[13];
            o[n + 2] = (i[n] * data[2]) + (i[n + 1] * data[6]) +(i[n + 2] * data[10]) + data[14];
         }
      }

      //============================================================
      // <T>设置平移内容。</T>
      //============================================================
      public function transformPoint3(o:SFloatPoint3, i:SFloatPoint3):void{
         o.x = (i.x * data[0]) + (i.y * data[4]) +(i.z * data[ 8]) + data[12];
         o.y = (i.x * data[1]) + (i.y * data[5]) +(i.z * data[ 9]) + data[13];
         o.z = (i.x * data[2]) + (i.y * data[6]) +(i.z * data[10]) + data[14];
      }

      //============================================================
      // <T>设置平移内容。</T>
      //============================================================
      public function transform3x3Point3(o:SFloatPoint3, i:SFloatPoint3):void{
         o.x = (i.x * data[0]) + (i.y * data[4]) +(i.z * data[ 8]);
         o.y = (i.x * data[1]) + (i.y * data[5]) +(i.z * data[ 9]);
         o.z = (i.x * data[2]) + (i.y * data[6]) +(i.z * data[10]);
      }
      
      //============================================================
      // <T>设置平移内容。</T>
      //============================================================
      public function transform3x3Float3(o:SFloatPoint3, x:Number, y:Number, z:Number):void{
         o.x = (x * data[0]) + (y * data[4]) +(z * data[ 8]);
         o.y = (x * data[1]) + (y * data[5]) +(z * data[ 9]);
         o.z = (x * data[2]) + (y * data[6]) +(z * data[10]);
//         o.x = (x * data[0]) + (y * data[1]) +(z * data[ 2]);
//         o.y = (x * data[4]) + (y * data[5]) +(z * data[ 6]);
//         o.z = (x * data[8]) + (y * data[9]) +(z * data[10]);
      }
      
      //============================================================
      // <T>设置平移内容。</T>
      //============================================================
      public function transformPosition34(pi:SFloatPoint3, po:SFloatPoint4):void{
         po.x = (pi.x * data[0]) + (pi.y * data[4]) +(pi.z * data[ 8]) + data[12];
         po.y = (pi.x * data[1]) + (pi.y * data[5]) +(pi.z * data[ 9]) + data[13];
         po.z = (pi.x * data[2]) + (pi.y * data[6]) +(pi.z * data[10]) + data[14];
         po.w = (       data[3]) + (       data[7]) +(       data[11]) + data[15];
         po.align();
      }

      //============================================================
      //  0  1  2  3
      //  4  5  6  7
      //  8  9 10 11
      // 12 13 14 15
      //============================================================
      public function appendData(v:Vector.<Number>):void{
         // 矩阵计算
         var v00:Number = (data[ 0] * v[0]) + (data[ 1] * v[4]) + (data[ 2] * v[ 8]) + (data[ 3] * v[12]);
         var v01:Number = (data[ 0] * v[1]) + (data[ 1] * v[5]) + (data[ 2] * v[ 9]) + (data[ 3] * v[13]);
         var v02:Number = (data[ 0] * v[2]) + (data[ 1] * v[6]) + (data[ 2] * v[10]) + (data[ 3] * v[14]);
         var v03:Number = (data[ 0] * v[3]) + (data[ 1] * v[7]) + (data[ 2] * v[11]) + (data[ 3] * v[15]);
         var v04:Number = (data[ 4] * v[0]) + (data[ 5] * v[4]) + (data[ 6] * v[ 8]) + (data[ 7] * v[12]);
         var v05:Number = (data[ 4] * v[1]) + (data[ 5] * v[5]) + (data[ 6] * v[ 9]) + (data[ 7] * v[13]);
         var v06:Number = (data[ 4] * v[2]) + (data[ 5] * v[6]) + (data[ 6] * v[10]) + (data[ 7] * v[14]);
         var v07:Number = (data[ 4] * v[3]) + (data[ 5] * v[7]) + (data[ 6] * v[11]) + (data[ 7] * v[15]);
         var v08:Number = (data[ 8] * v[0]) + (data[ 9] * v[4]) + (data[10] * v[ 8]) + (data[11] * v[12]);
         var v09:Number = (data[ 8] * v[1]) + (data[ 9] * v[5]) + (data[10] * v[ 9]) + (data[11] * v[13]);
         var v10:Number = (data[ 8] * v[2]) + (data[ 9] * v[6]) + (data[10] * v[10]) + (data[11] * v[14]);
         var v11:Number = (data[ 8] * v[3]) + (data[ 9] * v[7]) + (data[10] * v[11]) + (data[11] * v[15]);
         var v12:Number = (data[12] * v[0]) + (data[13] * v[4]) + (data[14] * v[ 8]) + (data[15] * v[12]);
         var v13:Number = (data[12] * v[1]) + (data[13] * v[5]) + (data[14] * v[ 9]) + (data[15] * v[13]);
         var v14:Number = (data[12] * v[2]) + (data[13] * v[6]) + (data[14] * v[10]) + (data[15] * v[14]);
         var v15:Number = (data[12] * v[3]) + (data[13] * v[7]) + (data[14] * v[11]) + (data[15] * v[15]);
         // 复制内容
         data[ 0] = v00;
         data[ 1] = v01;
         data[ 2] = v02;
         data[ 3] = v03;
         data[ 4] = v04;
         data[ 5] = v05;
         data[ 6] = v06;
         data[ 7] = v07;
         data[ 8] = v08;
         data[ 9] = v09;
         data[10] = v10;
         data[11] = v11;
         data[12] = v12;
         data[13] = v13;
         data[14] = v14;
         data[15] = v15;
      }
      
      //============================================================
      // <T>更新内容到数据中。</T>
      //  0  1  2  3
      //  4  5  6  7
      //  8  9 10 11
      // 12 13 14 15
      //============================================================
      public function append(p:SFloatMatrix):void{
         appendData(p.data);
      }
      
      //============================================================
      // <T>追加X轴旋转。</T>
      //  1 0 0 0
      //  0 1 0 0
      //  0 0 1 0
      //  x y z 1 
      //============================================================
      public function appendTranslate(px:Number, py:Number, pz:Number):void{
         TempData[ 0] = 1;
         TempData[ 1] = 0;
         TempData[ 2] = 0;
         TempData[ 3] = 0;
         TempData[ 4] = 0;
         TempData[ 5] = 1;
         TempData[ 6] = 0;
         TempData[ 7] = 0;
         TempData[ 8] = 0;
         TempData[ 9] = 0;
         TempData[10] = 1;
         TempData[11] = 0;
         TempData[12] = px;
         TempData[13] = py;
         TempData[14] = pz;
         TempData[15] = 1;
         appendData(TempData);
      }
      
      //============================================================
      // <T>追加Y轴旋转。</T>
      //  1    0   0 0
      //  0  cos sin 0
      //  0 -sin cos 0
      //  0    0   0 1 
      //============================================================
      public function appendRotationX(angle:Number):void{
         var sin:Number = Math.sin(angle);
         var cos:Number = Math.cos(angle);
         TempData[ 0] = cos;
         TempData[ 1] = 0;
         TempData[ 2] = sin;
         TempData[ 3] = 0;
         TempData[ 4] = 0;
         TempData[ 5] = 1;
         TempData[ 6] = 0;
         TempData[ 7] = 0;
         TempData[ 8] = -sin;
         TempData[ 9] = 0;
         TempData[10] = cos;
         TempData[11] = 0;
         TempData[12] = 0;
         TempData[13] = 0;
         TempData[14] = 0;
         TempData[15] = 1;
         appendData(TempData);
      }
      
      //============================================================
      // <T>追加Y轴旋转。</T>
      //  cos   0  sin  0
      //  0     1    0  0
      //  -sin  0  cos  0
      //  0     0    0  1 
      //============================================================
      public function appendRotationY(angle:Number):void{
         var sin:Number = Math.sin(angle);
         var cos:Number = Math.cos(angle);
         TempData[ 0] = cos;
         TempData[ 1] = 0;
         TempData[ 2] = sin;
         TempData[ 3] = 0;
         TempData[ 4] = 0;
         TempData[ 5] = 1;
         TempData[ 6] = 0;
         TempData[ 7] = 0;
         TempData[ 8] = -sin;
         TempData[ 9] = 0;
         TempData[10] = cos;
         TempData[11] = 0;
         TempData[12] = 0;
         TempData[13] = 0;
         TempData[14] = 0;
         TempData[15] = 1;
         appendData(TempData);
      }
      
      //============================================================
      // <T>追加Y轴旋转。</T>
      //  cos  sin  0 0
      //  -sin cos  1 0
      //  0      0  1 0
      //  0      0  0 1 
      //============================================================
      public function appendRotationZ(angle:Number):void{
         var sin:Number = Math.sin(angle);
         var cos:Number = Math.cos(angle);
         TempData[ 0] = cos;
         TempData[ 1] = sin;
         TempData[ 2] = 0;
         TempData[ 3] = 0;
         TempData[ 4] = -sin;
         TempData[ 5] = cos;
         TempData[ 6] = 1;
         TempData[ 7] = 0;
         TempData[ 8] = 0;
         TempData[ 9] = 0;
         TempData[10] = 1;
         TempData[11] = 0;
         TempData[12] = 0;
         TempData[13] = 0;
         TempData[14] = 0;
         TempData[15] = 1;
         appendData(TempData);
      }
      
      //============================================================
      // <T>追加Y轴旋转。</T>
      //  1    0   0 0
      //  0  cos sin 0
      //  0 -sin cos 0
      //  0    0   0 1 
      //============================================================
      public function appendRotation(px:Number, py:Number, pz:Number):void{
         var rsx:Number = Math.sin(px);
         var rcx:Number = Math.cos(px);
         var rsy:Number = Math.sin(py);
         var rcy:Number = Math.cos(py);
         var rsz:Number = Math.sin(pz);
         var rcz:Number = Math.cos(pz);
         TempData[ 0] = rcy * rcz;
         TempData[ 1] = rcy * rsz;
         TempData[ 2] = -rsy;
         TempData[ 3] = 0;
         TempData[ 4] = rsx * rsy * rcz - rcx * rsz;
         TempData[ 5] = rsx * rsy * rsz + rcx * rcz;
         TempData[ 6] = rsx * rcy;
         TempData[ 7] = 0;
         TempData[ 8] = rcx * rsy * rcz + rsx * rsz;
         TempData[ 9] = rcx * rsy * rsz - rsx * rcx;
         TempData[10] = rcx * rcy;
         TempData[11] = 0;
         TempData[12] = 0;
         TempData[13] = 0;
         TempData[14] = 0;
         TempData[15] = 1;
         appendData(TempData);
      }

      //============================================================
      // <T>追加缩放。</T>
      //  scaleX      0      0 0
      //  0      scaleY      0 0
      //  0           0 scaleZ 0
      //  0           0      0 1 
      //============================================================
      public function appendScale(px:Number, py:Number, pz:Number):void{
         TempData[ 0] = px;
         TempData[ 1] = 0;
         TempData[ 2] = 0;
         TempData[ 3] = 0;
         TempData[ 4] = 0;
         TempData[ 5] = py;
         TempData[ 6] = 0;
         TempData[ 7] = 0;
         TempData[ 8] = 0;
         TempData[ 9] = 0;
         TempData[10] = pz;
         TempData[11] = 0;
         TempData[12] = 0;
         TempData[13] = 0;
         TempData[14] = 0;
         TempData[15] = 1;
         appendData(TempData);
      }
      
      //============================================================
      // <T>追加缩放。</T>
      //  scaleX      0      0 0
      //  0      scaleY      0 0
      //  0           0 scaleZ 0
      //  0           0      0 1 
      //============================================================
      public function appendScaleAll(p:Number):void{
         TempData[ 0] = p;
         TempData[ 1] = 0;
         TempData[ 2] = 0;
         TempData[ 3] = 0;
         TempData[ 4] = 0;
         TempData[ 5] = p;
         TempData[ 6] = 0;
         TempData[ 7] = 0;
         TempData[ 8] = 0;
         TempData[ 9] = 0;
         TempData[10] = p;
         TempData[11] = 0;
         TempData[12] = 0;
         TempData[13] = 0;
         TempData[14] = 0;
         TempData[15] = 1;
         appendData(TempData);
      }

      //============================================================
      // <T>向量数乘</T>
      //
      // @params value 要相乘的向量
      //============================================================
      public function move(value:SFloatVector3, distince:Number):void{
         tx += distince * value.x;
         ty += distince * value.y;
         tz += distince * value.z;
         dirtyData = true;
      }
      
      //============================================================
      public function moveXZ(value:SFloatVector3, distince:Number):void{
         tx += distince * value.x;
         tz += distince * value.z;
         dirtyData = true;
      }
      
      //============================================================
      public function moveZX(value:SFloatVector3, distince:Number):void{
         tx += distince * value.z;
         tz += distince * value.x;
         dirtyData = true;
      }
      
      //============================================================
      public function moveY(distince:Number):void{
         ty += distince;
         dirtyData = true;
      }

      //============================================================
      // <T>解析数据到内容中。</T>
      //============================================================
      public function updateForce():void{
         var rsx:Number = Math.sin(rx);
         var rcx:Number = Math.cos(rx);
         var rsy:Number = Math.sin(ry);
         var rcy:Number = Math.cos(ry);
         var rsz:Number = Math.sin(rz);
         var rcz:Number = Math.cos(rz);
         data[ 0] = rcy * rcz * sx;
         data[ 1] = rcy * rsz * sx;
         data[ 2] = -rsy * sx;
         data[ 3] = 0;
         data[ 4] = (rsx * rsy * rcz - rcx * rsz) * sy;
         data[ 5] = (rsx * rsy * rsz + rcx * rcz) * sy;
         data[ 6] = rsx * rcy * sy;
         data[ 7] = 0;
         data[ 8] = (rcx * rsy * rcz + rsx * rsz) * sz;
         data[ 9] = (rcx * rsy * rsz - rsx * rcz) * sz;
         data[10] = rcx * rcy * sz;
         data[11] = 0;
         data[12] = tx;
         data[13] = ty;
         data[14] = tz;
         data[15] = 1;
         dirtyData = false;
      }
      
      //============================================================
      public function update():void{
         if(dirtyData){
            updateForce();
         }
      }
      
      //============================================================
      public function changed():void{
         serial++;
      }
      
      //============================================================
      // <T>解析数据到内容中。</T>
      //============================================================
      public function parse():void{
         if(dirtyValue){
            dirtyValue = false;
         }
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param config 设置信息
      //============================================================
      public function loadConfig(config:FXmlNode):void{
         // 读取坐标信息
         var vt:String = config.get("translation");
         if(vt){
            var vts:Array = vt.split(",");
            tx = parseFloat(vts[0]);
            ty = parseFloat(vts[1]);
            tz = parseFloat(vts[2]);
         }
         // 读取旋转信息
         var ve:String = config.get("euler");
         if(ve){
            var ves:Array = ve.split(",");
            rx = parseFloat(ves[0]) * RMath.DegreeRate;
            ry = parseFloat(ves[1]) * RMath.DegreeRate;
            rz = parseFloat(ves[2]) * RMath.DegreeRate;
         }
         // 读取旋转信息
         var vr:String = config.get("rotation");
         if(vr){
            var vrs:Array = vr.split(",");
            rx = parseFloat(vrs[0]);
            ry = parseFloat(vrs[1]);
            rz = parseFloat(vrs[2]);
         }
         // 读取缩放信息
         var vs:String = config.get("scale");
         if(vs){
            var vss:Array = vs.split(",");
            sx = parseFloat(vss[0]);
            sy = parseFloat(vss[1]);
            sz = parseFloat(vss[2]);
         }
         // 更新信息
         updateForce();
      }
      
      //============================================================
      // <T>存储设置信息。</T>
      //
      // @param config 设置信息
      //============================================================
      public function saveConfig(config:FXmlNode):void{
         parse();
         config.set("translation", tx + "," + ty + "," + tz);
         config.set("rotation", rx + "," + ry + "," + rz);
         config.set("scale", sx + "," + sy + "," + sz);
      }
      
      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize(p:IOutput):void{
         parse();
         // 存储平移信息
         p.writeFloat(tx);
         p.writeFloat(ty);
         p.writeFloat(tz);
         // 存储旋转弧度
         p.writeFloat(rx);
         p.writeFloat(ry);
         p.writeFloat(rz);
         // 存储缩放信息
         p.writeFloat(sx);
         p.writeFloat(sy);
         p.writeFloat(sz);
      }

      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serializeData(p:IOutput):void{
         for(var n:int = 0; n < 16; n++){
            p.writeFloat(data[n]);
         }
      }

      //============================================================
      // <T>存储数据到字节流。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function copyToBytes(p:ByteArray):void{
         for(var n:int = 0; n < 16; n++){
            p.writeFloat(data[n]);
         }
      }

      //============================================================
      // <T>存储数据到字节流。</T>
      //  0  1  2  3
      //  4  5  6  7
      //  8  9 10 11
      // 12 13 14 15
      //
      // @param p:output 输出数据流
      //============================================================
      public function copyToBytes3x4(p:ByteArray):void{
         p.writeFloat(data[ 0]);
         p.writeFloat(data[ 4]);
         p.writeFloat(data[ 8]);
         p.writeFloat(data[12]);
         p.writeFloat(data[ 1]);
         p.writeFloat(data[ 5]);
         p.writeFloat(data[ 9]);
         p.writeFloat(data[13]);
         p.writeFloat(data[ 2]);
         p.writeFloat(data[ 6]);
         p.writeFloat(data[10]);
         p.writeFloat(data[14]);
      }

      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize(p:IInput):void{
         // 读取平移信息
         tx = p.readFloat();
         ty = p.readFloat();
         tz = p.readFloat();
         // 读取旋转弧度
         rx = p.readFloat();
         ry = p.readFloat();
         rz = p.readFloat();
         // 读取缩放信息
         sx = p.readFloat();
         sy = p.readFloat();
         sz = p.readFloat();
         // 更新信息
         updateForce();
      }

      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function updateAll(pt:SFloatPoint3, pd:SFloatVector3, ps:SFloatVector3):void{
         // 读取平移信息
         tx = pt.x;
         ty = pt.y;
         tz = pt.z;
         // 读取旋转弧度
         rx = pd.x;
         ry = pd.y;
         rz = pd.z;
         // 读取缩放信息
         sx = ps.x;
         sy = ps.y;
         sz = ps.z;
         // 更新信息
         updateForce();
      }
   }
}