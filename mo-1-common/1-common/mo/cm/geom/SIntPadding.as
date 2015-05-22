package mo.cm.geom
{
   import mo.cm.stream.IInput;
   import mo.cm.stream.IOutput;
   
   //============================================================
   // <T>整数内边框。</T>
   //============================================================
   public class SIntPadding
   {
      // 左距离
      public var left:int; 
      
      // 上距离
      public var top:int; 
      
      // 右距离
      public var right:int; 

      // 下距离
      public var bottom:int; 

      //============================================================
      // <T>构造整数内边框。</T>
      //
      // @param pl:left 左距离
      // @param pt:top 上距离
      // @param pr:right 右距离
      // @param pb:bottom 下距离
      //============================================================
      public function SIntPadding(pl:int = 0, pt:int = 0, pr:int = 0, pb:int = 0){
         left = pl;
         top = pt;
         right = pr;
         bottom = pb;
      }
      
      //============================================================
      // <T>比较和指定对象内容释放相等。</T>
      //
      // @param p:padding 内边框
      //============================================================
      public function equals(p:SIntPadding):Boolean{
         return (left == p.left) && (top == p.top) && (right == p.right) && (bottom == p.bottom); 
      }
      
      //============================================================
      // <T>设置数据内容。</T>
      //
      // @param pl:left 左距离
      // @param pt:top 上距离
      // @param pr:right 右距离
      // @param pb:bottom 下距离
      //============================================================
      public function set(pl:int = 0, pt:int = 0, pr:int = 0, pb:int = 0):void{
         left = pl;
         top = pt;
         right = pr;
         bottom = pb;
      }
      
      //============================================================
      // <T>接收数据。</T>
      //
      // @param p:padding 内边框
      //============================================================
      public function assign(p:SIntPadding):void{
         left = p.left;
         top = p.top;
         right = p.right;
         bottom = p.bottom;
      }
      
      //============================================================
      // <T>序列化数据内容到输出流中。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize16(p:IOutput):void{
         p.writeInt16(left);
         p.writeInt16(top);
         p.writeInt16(right);
         p.writeInt16(bottom);
      }
      
      //============================================================
      // <T>序列化数据内容到输出流中。</T>
      //
      // @param p:output 输出数据流
      //============================================================
      public function serialize32(p:IOutput):void{
         p.writeInt32(left);
         p.writeInt32(top);
         p.writeInt32(right);
         p.writeInt32(bottom);
      }
      
      //============================================================
      // <T>反序列化数据信息。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize16(p:IInput):void{
         left = p.readInt16();
         top = p.readInt16();
         right = p.readInt16();
         bottom = p.readInt16();
      }
      
      //============================================================
      // <T>从输入数据流中反序列化数据内容。</T>
      //
      // @param p:input 输入数据流
      //============================================================
      public function unserialize32(p:IInput):void{
         left = p.readInt32();
         top = p.readInt32();
         right = p.readInt32();
         bottom = p.readInt32();
      }
      
      //============================================================
      // <T>获得运行字符串。</T>
      //
      // @return 运行字符串
      //============================================================
      public function toString():String{
         return left + "," + top + "," + right + "," + bottom;
      }
   }
}