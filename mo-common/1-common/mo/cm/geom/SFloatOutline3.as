package mo.cm.geom
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>三维轮廓。</T>
   //============================================================
   public class SFloatOutline3
   {
      // 最小点坐标
      public var min:SFloatPoint3 = new SFloatPoint3();
      
      // 最大点坐标
      public var max:SFloatPoint3 = new SFloatPoint3();
      
      //============================================================
      // <T>构造三维轮廓。</T>
      //============================================================
      public function SFloatOutline3(){
      }
      
      //============================================================
      // <T>初始化为最小数值。</T>
      //============================================================
      public function initializeMin():void{
         min.initializeMax();
         max.initializeMin();
      }
      
      //============================================================
      // <T>初始化为最大数值。</T>
      //============================================================
      public function initializeMax():void{
         min.initializeMin();
         max.initializeMax();
      }
      
      //============================================================
      // <T>计算X轴长度。</T>
      //
      // @return 长度
      //============================================================
      public function get lengthX():Number{
         return max.x - min.x;
      }
      
      //============================================================
      // <T>计算Y轴长度。</T>
      //
      // @return 长度
      //============================================================
      public function get lengthY():Number{
         return max.y - min.y;
      }
      
      //============================================================
      // <T>计算Z轴长度。</T>
      //
      // @return 长度
      //============================================================
      public function get lengthZ():Number{
         return max.z - min.z;
      }
      
      //============================================================
      // <T>计算当前轮廓和指定轮廓的最小轮廓。</T>
      //
      // @param p:outline 轮廓
      //============================================================
      public function innerMin(p:SFloatOutline3):void{
         min.innerMax(p.min);
         max.innerMin(p.max);
      }
      
      //============================================================
      // <T>计算当前轮廓和指定轮廓的最大轮廓。</T>
      //
      // @param p:outline 轮廓
      //============================================================
      public function innerMax(p:SFloatOutline3):void{
         min.innerMin(p.min);
         max.innerMax(p.max);
      }
      
      //============================================================
      // <T>计算中心点坐标。</T>
      //
      // @param p:center 中心点
      //============================================================
      public function calculateCenter(p:SFloatPoint3):void{
         p.x = (min.x + max.x) / 2;
         p.y = (min.y + max.y) / 2;
         p.z = (min.z + max.z) / 2;
      }
      
      //============================================================
      // <T>计算三维尺寸。</T>
      //
      // @param p:center 三维尺寸
      //============================================================
      public function calculateSize(p:SFloatPoint3):void{
         p.x = (max.x - min.x) / 2;
         p.y = (max.y - min.y) / 2;
         p.z = (max.z - min.z) / 2;
      }
      
      //============================================================
      // <T>接受传入的对象信息。</T>
      //
      // @param p:value 对象信息
      //============================================================
      public function assign(p:SFloatOutline3):void{
         min.assign(p.min);
         max.assign(p.max);
      }
      
      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize(p:IOutput):void{
         min.serialize(p);
         max.serialize(p);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize(p:IInput):void{
         min.unserialize(p);
         max.unserialize(p);
      }
      
      //============================================================
      // <T>获得格式化内容。</T>
      //
      // @return 格式化内容
      //============================================================
      public function format():String{
         return min.format() + " - " + max.format() + " (" + lengthX + "," + lengthY + "," + lengthZ + ")"; 
      }
      
      //============================================================
      // <T>获得字符串内容。</T>
      //
      // @return 字符串内容
      //============================================================
      public function toString():String{
         return min.format() + ":" + max.format(); 
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function dispose():void{
         min = null;
         max = null;
      }
   }
}