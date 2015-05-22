package mo.cr.message
{
   import flash.utils.ByteArray;

   //============================================================
   // <T>消息工具类。。</T>
   //============================================================
   public class RNetUtility
   {
      //============================================================
      // <T>构造消息工具类。。</T>
      //============================================================
      public function RNetUtility(){
      }
      
      //============================================================
      // <T>计算数据部分的哈希值。</T>
      //
      // @param ps:serial 序列
      // @param pt:tick 时刻
      // @param pd:data 数据
      // @return 哈希值
      //============================================================
      public static function calculateHash(ps:uint, pt:uint, pd:ByteArray):uint{
         var r:uint = ps;
         var c:int = pd.length;
         pd.position = 0;
         for(var n:int = 0; n < c; n++){
            r = (31 * r) + pd.readUnsignedByte();
         }
         return r ^ pt;
      }

      //============================================================
      // <T>遮盖数据。</T>
      //
      // @param pd:data 数据
      // @param ph:hash 哈希
      //============================================================
      public static function markData(pd:ByteArray, ph:int):void{
         // 计算内容
         var v1:int = (ph >>  0) & 0xFF;
         var v2:int = (ph >>  8) & 0xFF;
         var v3:int = (ph >> 16) & 0xFF;
         var v4:int = (ph >> 24) & 0xFF;
         // 逐字节遮盖
         var c:int = pd.length;
         pd.position = 0;
         for(var n:int = 0; n < c; n++){
            // 选择数据
            var v:int = 0;
            switch(n & 0x03){
               case 0:
                  v = v1;
                  break;
               case 1:
                  v = v3;
                  break;
               case 2:
                  v = v2;
                  break;
               case 3:
                  v = v4;
                  break;
            }
            // 遮盖字节
            var r:int = v ^ pd.readUnsignedByte();
            pd.position = n;
            pd.writeByte(r);
         }
      }
   }
}