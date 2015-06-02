package mo.cm.lang
{
   import flash.utils.ByteArray;
   
   //============================================================
   // <T>字节工具类。</T>
   //============================================================
   public class RByte
   {
      // 缓冲字符串
      protected static var _dump:FString = new FString();
      
      //============================================================
      // <T>读取字节流中从起始位置开始的制定长度的内容，并按指定格式返回字符串。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      // @param pp:prefix 前缀
      // @param pr:rowLength 行长度
      //============================================================
      protected static function formatBytes(pd:ByteArray, po:int, pl:int, pr:int=16):String{
         // 重置数组位置
         pd.position = po;
         var p:int = pd.position;
         // 初始化字符串
         var sc:String = "";
         var sh:String = "";
         while( p++ < (po + pr)){
            if(pd.position < pl){
               var c:uint = pd.readUnsignedByte();
               if(c > 32  && c < 128){
                  sc += String.fromCharCode(c);
               }else{
                  sc += '.';
               }
               sh += RString.lpad(c.toString(16),2,'0') + " ";
            }else{
               sh += "   ";
               sc += " ";
            }
         }
         return "0x" + RString.lpad(po.toString(16), 4, "0") + "(" + RString.lpad(po.toString(), 6, " ") + "): " + sh.toUpperCase() + "[" + sc + "]";
      }
      
      //============================================================
      // <T>格式化字节集合。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      // @param pp:prefix 前缀
      // @param pr:rowLength 行长度
      //============================================================
      public static function format(pd:ByteArray, po:int = 0, pl:int=-1, pp:String="", pr:int=16):String{
         // 修正位置
         pd.position = po;
         if(pl < 0){
            pl = pd.length;
         }
         // 格式化字符串
         for(var n:int=0; n<pl; n += pr){
            _dump.append(pp + formatBytes(pd, n, pl, pr));
            if(n + pr < pl){
               _dump.append('\n');
            }
         }
         // 返回字符串
         var r:String = _dump.toString();
         _dump.clear();
         return r;
      }
      
      //============================================================
      // <T>复制有符号整数集合到字节内。</T>
      //
      // @param pd:data 数据
      // @param pv:value 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public static function copyFromInts(pd:ByteArray, pv:Vector.<int>, po:int = 0, pl:int = -1):void{
         if(pl < 0){
            pl = pv.length;
         }
         for(var n:int = po; n < pl; n++){
            pd.writeUnsignedInt(pv[n]);
         }
      }
      
      //============================================================
      // <T>复制无符号整数集合到字节内。</T>
      //
      // @param pd:data 数据
      // @param pv:value 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public static function copyFromUints(pd:ByteArray, pv:Vector.<uint>, po:int = 0, pl:int = -1):void{
         if(pl < 0){
            pl = pv.length;
         }
         for(var n:int = po; n < pl; n++){
            pd.writeUnsignedInt(pv[n]);
         }
      }
   }
}