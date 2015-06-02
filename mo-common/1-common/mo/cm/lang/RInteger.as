package mo.cm.lang
{   
   //============================================================
   // <T>整数工具类。</T>
   //============================================================
   public class RInteger
   {
      // 16进制对换字符串
      public static const HEX_CHARS:String = "0123456789abcdef";
      
      //============================================================
      // <T>计算级别。</T>
      //
      // @param pv:value 数值
      // @param pd:length 长度
      // @return 级别
      //============================================================
      public static function level(pv:int, pc:int):int{
         // 计算级别
         var v:int = 1;
         while(true){
            pv = pv / pc;
            if(pv > 0){
               v++
            }else{
               break;
            }
         }
         return v;
      }
      
      //============================================================
      // <T>按照位左侧循环滚动。</T>
      //
      // @param x:value 数值
      // @param n:length 长度
      // @return 数字
      //============================================================
      public static function rol ( x:int, n:int ):int {
         return ( x << n ) | ( x >>> ( 32 - n ) );
      }
      
      //============================================================
      // <T>按照位右侧循环滚动。</T>
      //
      // @param x:value 数值
      // @param n:length 长度
      // @return 数字
      //============================================================
      public static function ror ( x:int, n:int ):uint {
         var nn:int = 32 - n;
         return ( x << nn ) | ( x >>> ( 32 - nn ) );
      }
      
      //============================================================
      // <T>格式化数字为16进制内容。</T>
      //
      // @param pv:value 数值
      // @param pl:length 长度
      // @param pe:bgEndian 编码方式
      // @return 16进制字符串
      //============================================================
      public static function toHex(pv:int, pl:int = 0, pe:Boolean = false):String{
         // 格式转换
         var r:String = "";
         if(pe){
            for( var i:int = 0; i < 4; i++ ) {
               r += HEX_CHARS.charAt( ( pv >> ( ( 3 - i ) * 8 + 4 ) ) & 0x0F ) 
                  + HEX_CHARS.charAt( ( pv >> ( ( 3 - i ) * 8 ) ) & 0x0F );
            }
         }else{
            for( var x:int = 0; x < 4; x++ ) {
               r += HEX_CHARS.charAt( ( pv >> ( x * 8 + 4 ) ) & 0x0F )
                  + HEX_CHARS.charAt( ( pv >> ( x * 8 ) ) & 0x0F );
            }
         }
         // 长度补齐
         if(pl > 0){
            var c:int = pl - r.length;
            if(c > 0){
               for(var n:int = 0; n < c; n++){
                  r = '0' + r;
               }
            }
         }
         return r;
      }
      
      //============================================================
      // <T>转换字符串为有符号数字。</T>
      //
      // @param pv:value 数值字符串
      // @param pd:default 默认值
      // @return 转换后数值
      //============================================================
      public static function toInt(pv:String, pd:uint = 0):int{
         if(!RString.isEmpty(pv)){
            if(0 == pv.indexOf("-")){
               pv = RString.replace(pv.substr(1), "-", "");
               return -parseInt(pv);
            }
            pv = RString.replace(pv, "-", "");
            return parseInt(pv);
         }
         return pd;
      }
      
      //============================================================
      // <T>转换16进制字符串为有符号数字。</T>
      //
      // @param pv:value 数值字符串
      // @param pd:default 默认值
      // @return 转换后数值
      //============================================================
      public static function toInt16(pv:String, pd:uint = 0):int{
         if(!RString.isEmpty(pv)){
            if(0 == pv.indexOf("-")){
               pv = RString.replace(pv.substr(1), "-", "");
               return -parseInt(pv, 16);
            }
            pv = RString.replace(pv, "-", "");
            return parseInt(pv, 16);
         }
         return pd;
      }
      
      //============================================================
      // <T>转换字符串为无符号数字。</T>
      //
      // @param pv:value 数值字符串
      // @param pd:default 默认值
      // @return 转换后数值
      //============================================================
      public static function toUint(pv:String, pd:uint = 0):uint{
         if(!RString.isEmpty(pv)){
            return parseInt(pv);
         }
         return pd;
      }
      
      //============================================================
      // <T>左边补齐0到指定长度。</T>
      //
      // @param value 数值
      // @param length 长度
      // @return 格式化后字符串
      //============================================================
      public static function lpad(value:int, length:int):String{
         var result:String = value.toString();
         var loop:int = length - result.length;
         for(var n:int = 0; n < loop; n++){
            result = '0' + result;
         }
         return result;
      }
      
      //============================================================
      // <T>获得范围内的数值。</T>
      //
      // @param pv:value 内容
      // @param pn:min 最小值
      // @param px:max 最大值
      // @return 数值
      //============================================================
      public static function between(pv:int, pn:int, px:int):int{
         if(pv < pn){
            return pn;
         }
         if(pv > px){
            return px;
         }
         return pv;
      }
      
      //============================================================
      // <T>格式化内存数据。</T>
      //
      // @param p:value 数值
      // @return 格式化后字符串
      //============================================================
      public static function formatMemory(p:uint, pt:String = "a"):String{
         var b:int = p % 1024;
         var k:int = (p / 1024) % 1024;
         var m:int = (p / 1024 / 1024) % 1024;
         var g:int = (p / 1024 / 1024 / 1024) % 1024;
         if(pt == "a"){
            if(g > 0){
               return g + "g" + m + "m" + k + "k" + b + "b";
            }else if(m > 0){
               return m + "m" + k + "k" + b + "b";
            }else if(k > 0){
               return k + "k" + b + "b";
            }else if(b > 0){
               return b + "b";
            }
         }else if(pt == "g"){
            if(g > 0){
               return g + "g";
            }else if(m > 0){
               return m + "m";
            }else if(k > 0){
               return k + "k";
            }else if(b > 0){
               return b + "b";
            }
         }else if(pt == "m"){
            if(g > 0){
               return g + "g" + m + "m";
            }else if(m > 0){
               return m + "m";
            }else if(k > 0){
               return k + "k";
            }else if(b > 0){
               return b + "b";
            }
         }else if(pt == "k"){
            if(g > 0){
               return g + "g" + m + "m" + k + "k";
            }else if(m > 0){
               return m + "m" + k + "k";
            }else if(k > 0){
               return k + "k";
            }else if(b > 0){
               return b + "b";
            }
         }else if(pt == "b"){
            return b + "b";
         }
         return "" + p;
      }
      
      //============================================================
      // <T>格式化内存数据。</T>
      //
      // @param pv:value 数值
      // @param pt:type 类型
      // @return 格式化后字符串
      //============================================================
      public static function formatMemoryPad(pv:uint, pt:String = "a"):String{
         var b:int = pv % 1024;
         var k:int = (pv / 1024) % 1024;
         var m:int = (pv / 1024 / 1024) % 1024;
         var g:int = (pv / 1024 / 1024 / 1024) % 1024;
         var bs:String = RString.lpad(b.toString(), 4, " ");
         var ks:String = RString.lpad(k.toString(), 4, " ");
         var ms:String = RString.lpad(m.toString(), 4, " ");
         var gs:String = RString.lpad(g.toString(), 4, " ");
         if(pt == "a"){
            if(g > 0){
               return gs + "g" + ms + "m" + ks + "k" + bs + "b";
            }else if(m > 0){
               return ms + "m" + ks + "k" + bs + "b";
            }else if(k > 0){
               return ks + "k" + bs + "b";
            }else if(b > 0){
               return bs + "b";
            }
         }else if(pt == "g"){
            return gs + "g" + ms + "m" + ks + "k" + bs + "b";
         }else if(pt == "m"){
            return ms + "m" + ks + "k" + bs + "b";
         }else if(pt == "k"){
            return ks + "k" + bs + "b";
         }else if(pt == "b"){
            return bs + "b";
         }
         return "" + pv;
      }
      
      //============================================================
      // <T>格式化内存数据。</T>
      //
      // @param p:value 数值
      // @return 格式化后字符串
      //============================================================
      public static function formatMemoryM(p:uint):String{
         var b:int = p % 1024;
         var k:int = (p / 1024) % 1024;
         var m:int = (p / 1024 / 1024) % 1024;
         var g:int = (p / 1024 / 1024 / 1024) % 1024;
         if(g > 0){
            return g + "g" + m + "m" + k + "k";
         }else if(m > 0){
            return m + "m" + k + "k";
         }else if(k > 0){
            return k + "k";
         }
         return "0m";
      }
   }  
}