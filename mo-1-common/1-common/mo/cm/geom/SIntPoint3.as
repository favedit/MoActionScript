package mo.cm.geom
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>三维点</T>
   //
   // @version 1.0.1
   //============================================================
   public class SIntPoint3
   {
      public var x:int; 
      
      public var y:int; 
      
      public var z:int; 
      
      //============================================================
      // <T>构造函数</T>
      //
      //============================================================
      public function SIntPoint3(px:int = 0, py:int = 0, pz:int = 0){
         x = px;
         y = py;
         z = pz;
      }
      
      //============================================================
      // <T>三维坐标赋值</T>
      //
      //============================================================
      public function equals(point:SIntPoint3):Boolean{
         return (x == point.x) && (y == point.y) && (z == point.z); 
      }
      
      //============================================================
      // <T>三维坐标赋值</T>
      //
      //============================================================
      public function set(x:int, y:int, z:int):void{
         this.x = x;
         this.y = y;
         this.z = z;
      }
      
      //============================================================
      // <T>三维坐标赋值</T>
      //
      //============================================================
      public function assign(point:SIntPoint3):void{
         x = point.x;
         y = point.y;
         z = point.z;
      }
      
      //============================================================
      // <T>三维坐标赋值</T>
      //
      //============================================================
      public function toPoint():SIntPoint2{
         var p:SIntPoint2 = new SIntPoint2();
         p.x = x;
         p.y = z;
         return p;
      }
      
      //============================================================
      // <T>解析三维坐标</T>
      //
      //============================================================
      public function parse(source:String):void{
         if(null != source && source.length > 0){
            var split:int = source.indexOf(",");
            if(-1 != split){
               x = parseInt(source.substring(0, split)); 
               y = parseInt(source.substring(split + 1)); 
            }else{
               x = y = parseInt(source); 
            }
         }
      }
      
      //============================================================
      // <T>序列化数据部分。</T>
      //
      // @param bytes 数据缓冲
      //============================================================
      public function serialize(output:IOutput):void{
         output.writeInt32(x);
         output.writeInt32(y);
         output.writeInt32(z);
      }
      
      //============================================================
      // <T>反序列化数据部分。</T>
      //
      // @param bytes 数据缓冲
      //============================================================
      public function unserialize(input:IInput):void{
         x = input.readInt32();
         y = input.readInt32();
         z = input.readInt32();
      }
      
      //============================================================
      // <T>构造三维点toString方法</T>
      //
      //============================================================
      public function toString():String{
         return x + "," + y + "," + z;
      }
   }
}