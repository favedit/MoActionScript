package mo.cm.lang
{	
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   //============================================================
   // <T>字符串工具类。</T>
   //============================================================
   public class RString
   {
      // 缓冲字节流
      public static var buffer:ByteArray = new ByteArray();
      
      //============================================================
      // <T>构造字符串工具类。</T>
      //============================================================
      {
         buffer.endian = Endian.LITTLE_ENDIAN;
      }
      
      //============================================================
      // <T>判断字符串内容是否为空。</T>
      //
      // @param p:value 字符串
      // @return 是否为空
      //============================================================
      public static function isEmpty(p:String):Boolean {
         return p ? (0 == p.length) : true;
      }
      
      //============================================================
      // <T>判断字符串内容是否为空。</T>
      //
      // @param p:value 字符串
      // @return 是否为空
      //============================================================
      public static function isBlank(p:String):Boolean {
         return p ? (0 == trim(p).length) : true;
      }
      
      //============================================================
      // <T>获得字符串的字节大小。</T>
      //
      // @param p:value 字符串
      // @return 字节个数
      //============================================================
      public static function sizeOf(p:String):int{
         var r:int = 0;
         if(p){
            buffer.length = 0;
            buffer.writeUTFBytes(p);
            r = buffer.length;
         }
         return r;
      }
      
      //============================================================
      // <T>获得字符串字符个数。</T>
      //
      // @param p:value 字符串
      // @return 字符个数
      //============================================================
      public static function lengthOf(value:String):int{
         var len:int = 0;
         var count:int = value.length;
         for(var i:int=0;i < count; i++){
            if(value.charCodeAt(i) < 256){
               len += 1;
            }else{
               len += 2;
            }
         }
         return len
      }
      
      //============================================================
      // <T>截取制定字节数长度的字符串。</T>
      //
      // @param p:value 字符串
      // @return 字符个数
      //============================================================
      public static function substr(value:String, len:int):String{
         var str:String = value.substring(0, value.length - 1);
         while(lengthOf(str) > len){
            str = value.substring(0, str.length - 1);
         }
         return str;
      }
      
      //============================================================
      // <T>判断字符串是否以指定字符串开始。</T>
      //
      // @param ps:source 来源字符串
      // @param pv:value 开头字符串
      // @return 是否开头
      //============================================================
      public static function startsWith(ps:String, pv:String):Boolean{
         if(ps && pv){
            return (0 == ps.indexOf(pv));
         }
         return false;
      }
      
      //============================================================
      // <T>判断字符串是否以指定字符串结尾。</T>
      //
      // @param ps:source 来源字符串
      // @param pv:value 结尾字符串
      // @return 是否结尾
      //============================================================
      public static function endsWith(ps:String, pv:String):Boolean{
         if(ps && pv){
            return ps.lastIndexOf(pv) == (ps.length - pv.length);
         }
         return false;
      }
      
      //============================================================
      // <T>比较两个字符串大小。</T>
      //
      // @param ps:source 来源
      // @param pt:target 目标
      // @return 大小
      //============================================================
      public static function compare(ps:String, pt:String):int{
         if(ps > pt){
            return 1;
         }else if(pt > ps){
            return -1;
         }
         return 0;
      }
      
      //============================================================
      // <T>获得非空字符串。</T>
      //
      // @param pv:value 内容字符串
      // @param pd:default 缺省字符串
      // @return 非空字符串
      //============================================================
      public static function nvl(pv:String, pd:String = ""):String {
         if (null == pv) {
            return pd;
         }
         return (pv.length > 0) ? pv : pd;
      }
      
      //============================================================
      // <T>删除左侧非可见字符。</T>
      //
      // @param p:value 字符串
      // @return 字符串
      //============================================================
      public static function replaceBlank(s:String):String{
         return s.replace(/\s|/g, "");
      }
      
      //============================================================
      // <T>删除左侧非可见字符。</T>
      //
      // @param p:value 字符串
      // @return 字符串
      //============================================================
      public static function ltrim(p:String, s:String = null):String {
         if(null != p){
            var c:int = p.length;
            var n:int = 0;
            if(null == s){
               while((n < c) && (p.charCodeAt(n) <= 32)){
                  n++;
               }
            }else{
               while((n < c) && ((p.charCodeAt(n) <= 32) || (-1 != s.indexOf(p.charAt(n))))){
                  n++;
               }
            }
            if(n != 0){
               p = p.substr(n, c - n);
            }
         }else{
            p = "";
         }
         return p;
      }
      
      //============================================================
      // <T>删除右侧非可见字符。</T>
      //
      // @param p:value 字符串
      // @return 字符串
      //============================================================
      public static function rtrim(p:String, s:String = null):String{
         if(null != p){
            var c:int = p.length - 1;
            var n:int = c;
            if(null == s){
               while((n >= 0) && (p.charCodeAt(n) <= 32)){
                  n--;
               }
            }else{
               while((n >= 0) && ((p.charCodeAt(n) <= 32) || (-1 != s.indexOf(p.charAt(n))))){
                  n--;
               }
            }
            if(n != c){
               p = p.substr(0, n + 1);
            }
         }else{
            p = "";
         }
         return p;
      }
      
      //============================================================
      // <T>删除两侧非可见字符。</T>
      //
      // @param p:value 字符串
      // @return 字符串
      //============================================================
      public static function trim(value:String, s:String = null):String {
         return ltrim(rtrim(value, s), s);
      } 
      
      //============================================================
      // <T>删除所有空格。</T>
      //
      // @param p:value 字符串
      // @return 字符串
      //============================================================
      public static function atrim(s:String):String {
         s = replace(s, "　", "");
         return s.replace(/([ ]{1})/g, "");
      }
      
      //============================================================
      // <T>左补齐字符到指定长度。</T>
      //
      // @param pv:value 字符串
      // @param pl:length 长度
      // @param pp:pad 补齐字符
      // @return 字符串
      //============================================================
      public static function lpad(pv:String, pl:int, pp:String = " "):String {
         var r:String = "";
         if(null != pv){
            r = pv.toString();
         }
         var c:int = pl - r.length;
         if (c > 0) {
            for (var n:int = 0; n < c; n++ ) {
               r = pp + r;
            }
         }
         return r;
      }
      
      //============================================================
      // <T>右补齐字符到指定长度。</T>
      //
      // @param pv:value 字符串
      // @param pl:length 长度
      // @param pp:pad 补齐字符
      // @return 字符串
      //============================================================
      public static function rpad(pv:String, pl:int, pp:String = " "):String {
         var r:String = "";
         if(null != pv){
            r = pv.toString();
         }
         var c:int = pl - r.length;
         if (c > 0) {
            for (var n:int = 0; n < c; n++ ) {
               r += pp;
            }
         }
         return r;
      }	
      
      //============================================================
      // <T>字符串中替换一个字符串为另外一个字符串。</T>
      //
      // @param pv:value 字符串
      // @param pf:source 来源字符串
      // @param pt:target 目标字符串
      // @return 字符串
      //============================================================
      public static function replace(pv:String, ps:String, pt:String):String {
         if(pv){
            if(ps != pt){
               while(-1 != pv.indexOf(ps)){
                  pv = pv.replace(ps, pt);
               }
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得字符串中，查找到字符串的左侧部分字符串。</T>
      //
      // @param pv:value 内容字符串
      // @param pf:find 查找字符串
      // @return 左侧字符串
      //============================================================
      public static function left(pv:String, pf:String):String{
         if(pv && pf){
            var n:int = pv.indexOf(pf);
            if(-1 != n){
               return pv.substr(0, n);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得字符串中，查找到字符串的右侧部分字符串。</T>
      //
      // @param pv:value 内容字符串
      // @param pf:find 查找字符串
      // @return 左侧字符串
      //============================================================
      public static function right(pv:String, pf:String):String{
         if(pv && pf){
            var n:int = pv.lastIndexOf(pf);
            if(-1 != n){
               return pv.substr(n + pf.length);
            }
         }
         return pv;
      }
      
      //============================================================
      // <T>获得字符串中，查找到字符串的右侧部分字符串。</T>
      //
      // @param pv:value 内容字符串
      // @param pf:find 查找字符串
      // @return 左侧字符串
      //============================================================
      public static function replaceHtml(v:String):String{
         while(v.indexOf("[") != -1){
            v = v.replace("[","<");
            v = v.replace("]",">");
         }
         return v;
      }
      
      //============================================================
      // <T>获得字符串中，查找到字符串的左侧和左侧后中间部分字符串。</T>
      //
      // @param pv:value 内容字符串
      // @param pl:left 左侧字符串
      // @param pr:right 右侧字符串
      // @return 中间字符串
      //============================================================
      public static function sub(pv:String, pl:String, pr:String):String{
         if(pv && pl && pr){
            var s:int = pv.indexOf(pl);
            if(-1 == s){
               s = 0;
            }
            var e:int = pv.indexOf(pr, s);
            if(-1 == e){
               e = pv.length;
            }
            return pv.substr(s + pl.length, e - s - pl.length);
         }
         return pv;
      }
      
      //============================================================
      // <T>获得字符串中，查找到字符串的左侧和右侧中间部分字符串。</T>
      //
      // @param pv:value 内容字符串
      // @param pl:left 左侧字符串
      // @param pr:right 右侧字符串
      // @return 中间字符串
      //============================================================
      public static function mid(pv:String, pl:String, pr:String):String{
         if(pv && pl && pr){
            var s:int = pv.indexOf(pl);
            if(-1 == s){
               s = 0;
            }
            var e:int = pv.lastIndexOf(pr);
            if(-1 == e){
               e = pv.length;
            }
            return pv.substr(s + pl.length, e - s - pl.length);
         }
         return pv;
      }
      
      //============================================================
      // <T>格式化字符串为行号字符串。</T>
      //
      // @param ps:source 来源字符串
      // @param pl:length 行号宽度
      // @return 格式化后字符串
      //============================================================
      public static function formatLineCode(ps:String, pl:int = 4):String{
         ps = rtrim(ps);
         var ls:Array = ps.split("\n");
         var s:FString = new FString();
         var c:int = ls.length;
         for(var n:int = 0; n < c; n++){
            s.append(RInteger.lpad(n + 1, pl));
            s.append(": ");
            s.appendLine(ls[n]);
         }
         return s.toString();
      }
      
      //============================================================
      // <T>转换字符串为UTF-8编码。</T>
      //
      // @param ps:source 来源字符串
      // @param pl:length 行号宽度
      // @return 格式化后字符串
      //============================================================
      public static function utf8Encode(p:String):String {
         // 获得位置
         p = p.replace(/\r\n/g,'\n');
         p = p.replace(/\r/g,'\n');
         // 转换字符
         var c:int = p.length;
         var r:String = '';
         for (var n:int = 0 ; n < c; n++){
            var v:Number = p.charCodeAt(n);
            if(v < 128){
               r += String.fromCharCode(v);
            }else if((v > 127) && (v < 2048)){
               r += String.fromCharCode((v >> 6) | 192);
               r += String.fromCharCode((v & 63) | 128);
            }else{
               r += String.fromCharCode((v >> 12) | 224);
               r += String.fromCharCode(((v >> 6) & 63) | 128);
               r += String.fromCharCode((v & 63) | 128);
            }
         }
         return r;
      }
      
   }	
}