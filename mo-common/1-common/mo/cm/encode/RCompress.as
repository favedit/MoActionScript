package mo.cm.encode
{
   import flash.utils.ByteArray;
   
   //============================================================
   // <T>压缩工具。</T>
   //============================================================
   public class RCompress
   {
      // 提供商
      public static var vendor:ICompressVendor = new FCompressVendor();
      
      //============================================================
      // <T>构造函数。</T>
      //============================================================
      public function RCompress(){
      }
      
      //============================================================
      // <T>RLE压缩。</T>
      //
      // @param pi:input 输入数据
      // @param pl:length 输入长度
      // @param po:output 输出数据
      // @return 输出长度
      // @Date 20120107 YUFAL 创建
      //============================================================
      public static function lreEncode(pi:ByteArray, pl:int, po:ByteArray):int{
         var j:int = 0;   // 压缩后数据长度
         var m:int = 0;   // 控制符中间变量
         var n:int = 0;   // 控制符中间变量
         var p:int = 0;   // 控制符中间变量
         var q:int = 0;   // 控制符中间变量
         var sign:uint;   // 数据块头部控制符
         // 声明一个 0-255的数组
         var number:Array = new Array(256);
         for(var nl:int = 0; nl < 256; nl++){
            number.push(0);
         }
         // 统计传入数据块字符出现的次数
         for(var lc:int = 0; lc < pl; lc++){
            q = number[pi[lc]];
            q++;
            number[pi[lc]] = q;
         }
         // 找到出现次数最少的字符做为控制符
         sign = n;
         p = number[n];
         for(var ls:int = 0; ls < 256; ls++){
            m = number[ls];
            if(m < p){
               p = m;
               sign = ls;
            }
         }
         // 获取控制符
         po[1] = sign;
         j++;
         
         // 开始压缩
         for(var i:int = 0; i < pl; i++){
            if(pi[i] == sign){
               // 如果当前字符为控制符
               po[++j] = sign;
               var tc:int = 1;
               for(var pm:int = i + 1; pm < pl; pm++){
                  if(pi[pm] == sign){
                     tc++;
                     i = pm;
                     if(tc == 255){
                        break;
                     }
                  }else{
                     break;
                  }
               }
               // 连续控制符出现的次数
               po[++j] = sign;
               po[++j] = tc;
            }else{
               // 如果当前不为控制符
               var oc:int = 1;
               for(var lp:int = i + 1; lp < pl; lp++){
                  if(pi[lp] == pi[i]){
                     oc++;
                     i = lp;
                     if(oc == 255){
                        break;
                     }
                  }else{
                     break;
                  }
               }
               // 当前字符连续重复的次数
               if(oc > 1){
                  po[++j] = sign;
                  po[++j] = pi[i];
                  po[++j] = oc;
               }else{
                  po[++j] = pi[i]
               }
            }
         }
         
         // 是否返回压缩数据 
         // 78：N的ascii码表示未压缩
         // 89：Y的ascii码标识已经压缩
         if(j > pl){
            // 如果压缩后的长度大于传入的长度则返回原数据
            po.clear();
            po[0] = 78;
            for(var re:int = 0; re < pi.length; re++){
               po[re + 1] = pi[re];
            }
         }else{
            // 如果压缩后的长度小于传入的长度则返回压缩后的数据
            po[0] = 89;
         }
         return po.length;
      } 
      
      //============================================================
      // <T>解压缩。</T>
      //
      // @param pi:input 输入数据
      // @param pl:length 输入长度
      // @param po:output 输出数据
      // @return 输出长度
      // @Date 20120107 YUFAL 创建
      //============================================================
      public static function lreDecode(pi:ByteArray, pl:int, po:ByteArray):void{
         // 读取标志
         var f:int = pi.readUnsignedByte();
         // 未压缩   78   0   1    2    3    4    5
         if(f == 78){
            po.writeBytes(pi, 1, pl - 1);
         }else{
            // 解压  89   0    0    5    10
            var s:int = pi.readUnsignedByte();
            for(var n:int = 2; n < pl; n++){
               var c:int = pi.readUnsignedByte();
               if(c == s){
                  //如果是标识符，找到重复字符，和重复次数
                  var cv:int = pi.readUnsignedByte();
                  var cc:int = pi.readUnsignedByte();
                  //解开数据
                  for(var i:int = 0; i < cc; i++){
                     po.writeByte(cv);
                  }
                  n += 2;
               }else{
                  //如果不是标识符，直接输出
                  po.writeByte(c);
               }
            }
         }
      }
   }
}