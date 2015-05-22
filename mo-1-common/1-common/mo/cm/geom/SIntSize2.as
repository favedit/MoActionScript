package mo.cm.geom
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>整数二维尺寸。</T>
   //============================================================
   public class SIntSize2
   {
      // 宽度
      public var width:int; 
      
      // 高度
      public var height:int; 
      
      //============================================================
      // <T>构造整数二维尺寸。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      //============================================================
      public function SIntSize2(pw:int = 0, ph:int = 0){
         width = pw;
         height = ph;
      }
      
      //============================================================
      // <T>判断是否为空。</T>
      //
      // @return 是否为空
      //============================================================
      public function isEmpty():Boolean{
         return (0 == width) && (0 == height);
      }
      
      //============================================================
      // <T>是否相等。</T>
      //
      // @param p:value 尺寸对象
      // @return 是否相等
      //============================================================
      public function equals(p:SIntSize2):Boolean{
         return ((width == p.width) && (height == p.height));
      }

      //============================================================
      // <T>是否相等。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      // @return 是否相等
      //============================================================
      public function equalsValue(pw:int, ph:int):Boolean{
         return ((width == pw) && (height == ph));
      }
      
      //============================================================
      // <T>计算面积。</T>
      //
      // @return 面积
      //============================================================
      public function square():int{
         return width * height;
      }
      
      //============================================================
      // <T>设置整数尺寸宽高。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      //============================================================
      public function set(pw:int, ph:int):void{
         width = pw;
         height = ph;
      }
      
      //============================================================
      // <T>接收对象数据。</T>
      //
      // @param p:value 对象数据
      //============================================================
      public function assign(p:SIntSize2):void{
         width = p.width;
         height = p.height;
      }
      
      //============================================================
      // <T>解析字符串。</T>
      //
      // @param p:source 字符串
      //============================================================
      public function parse(p:String):void{
         if(null != p && p.length > 0){
            var split:int = p.indexOf(",");
            if(-1 != split){
               width = parseInt(p.substring(0, split)); 
               height = parseInt(p.substring(split + 1)); 
            }else{
               width = height = parseInt(p); 
            }
         }
      }
      
      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize(p:IOutput):void{
         p.writeInt32(width);
         p.writeInt32(height);
      }
      
      //============================================================
      // <T>序列化数据信息。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize16(p:IOutput):void{
         p.writeInt16(width);
         p.writeInt16(height);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize(p:IInput):void{
         width = p.readInt32();
         height = p.readInt32();
      }
      
      //============================================================
      // <T>反序列化16位数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize16(p:IInput):void{
         width = p.readUint16();
         height = p.readUint16();
      }
      
      //============================================================
      // <T>重置数据。</T>
      //============================================================
      public function reset():void{
         width = 0;
         height = 0;
      }
      
      //============================================================
      // <T>获得字符串信息</T>
      //
      // @return 字符串信息
      //============================================================
      public function toString():String{
         return width + "," + height; 
      }
   }
}