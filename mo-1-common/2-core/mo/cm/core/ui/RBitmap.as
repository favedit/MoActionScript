package mo.cm.core.ui
{
   import flash.utils.ByteArray;

   //============================================================
   // <T>图片工具类。</T>
   //============================================================
   public class RBitmap
   {
      //============================================================
      // <T>缩小图片数据一倍。</T>
      //============================================================
      public static function compress2(pw:int, ph:int, pdi:Vector.<uint>, pdo:Vector.<uint>, poffset:int = 0):void{
         // 上传纹理
         var w:int = pw >> 1;
         var h:int = ph >> 1;
         for(var y:int = 0; y < h; y++){
            for(var x:int = 0; x < w; x++){
               var n:int = (pw * y + x) << 1;
               var p1:uint = pdi[n         ];
               var p2:uint = pdi[n      + 1];
               var p3:uint = pdi[n + pw    ]
               var p4:uint = pdi[n + pw + 1]
               var b1:uint = (((p1 >> 24) & 0xFF) + ((p2 >> 24) & 0xFF) + ((p3 >> 24) & 0xFF) + ((p4 >> 24) & 0xFF)) * 0.25;
               var b2:uint = (((p1 >> 16) & 0xFF) + ((p2 >> 16) & 0xFF) + ((p3 >> 16) & 0xFF) + ((p4 >> 16) & 0xFF)) * 0.25;
               var b3:uint = (((p1 >>  8) & 0xFF) + ((p2 >>  8) & 0xFF) + ((p3 >>  8) & 0xFF) + ((p4 >>  8) & 0xFF)) * 0.25;
               var b4:uint = (( p1        & 0xFF) + ( p2        & 0xFF) + ( p3        & 0xFF) + ( p4        & 0xFF)) * 0.25;
               pdo[poffset++] = (b1 << 24) + (b2 << 16) + (b3 << 8) + b4;
            }
         }
      }

      //============================================================
      // <T>缩小图片数据一倍。</T>
      //
      // @parma pw:width 宽度
      // @parma ph:height 高度
      // @parma pi:input 输入数据
      // @parma po:output 输出数据
      // @parma pp:position 输入数据位置
      //============================================================
      public static function compressData2(pw:int, ph:int, pi:ByteArray, po:ByteArray, pp:int = 0):void{
         // 计算大小
         var w:int = pw >> 1;
         var h:int = ph >> 1;
         // 处理图形
         var n:int = 0;
         var x:int = 0;
         var y:int = 0;
         var p1:uint = 0;
         var p2:uint = 0;
         var p3:uint = 0;
         var p4:uint = 0;
         var b1:uint = 0;
         var b2:uint = 0;
         var b3:uint = 0;
         var b4:uint = 0;
         if((pw == 1) && (ph == 1)){
            // 不处理
         }else if(pw == 1){
            // 宽度为1
            for(y = 0; y < h; y++){
               n = y << 1;
               // 获得四点颜色
               pi.position = (n << 2) + pp;
               p1 = pi.readUnsignedInt();
               pi.position = ((n + pw) << 2) + pp;
               p2 = pi.readUnsignedInt();
               // 计算平均颜色
               b1 = (((p1 >> 24) & 0xFF) + ((p2 >> 24) & 0xFF)) * 0.5;
               b2 = (((p1 >> 16) & 0xFF) + ((p2 >> 16) & 0xFF)) * 0.5;
               b3 = (((p1 >>  8) & 0xFF) + ((p2 >>  8) & 0xFF)) * 0.5;
               b4 = (( p1        & 0xFF) + ( p2        & 0xFF)) * 0.5;
               // 写出计算平均颜色
               po.writeUnsignedInt((b1 << 24) + (b2 << 16) + (b3 << 8) + b4);
            }
         }else if(ph == 1){
            // 处理所有像素
            for(x = 0; x < w; x++){
               n = x << 1;
               // 获得四点颜色
               pi.position = (n << 2) + pp;
               p1 = pi.readUnsignedInt();
               p2 = pi.readUnsignedInt();
               // 计算平均颜色
               b1 = (((p1 >> 24) & 0xFF) + ((p2 >> 24) & 0xFF)) * 0.5;
               b2 = (((p1 >> 16) & 0xFF) + ((p2 >> 16) & 0xFF)) * 0.5;
               b3 = (((p1 >>  8) & 0xFF) + ((p2 >>  8) & 0xFF)) * 0.5;
               b4 = (( p1        & 0xFF) + ( p2        & 0xFF)) * 0.5;
               // 写出计算平均颜色
               po.writeUnsignedInt((b1 << 24) + (b2 << 16) + (b3 << 8) + b4);
            }
         }else{
            // 处理所有像素
            for(y = 0; y < h; y++){
               for(x = 0; x < w; x++){
                  n = (pw * y + x) << 1;
                  // 获得四点颜色
                  pi.position = (n << 2) + pp;
                  p1 = pi.readUnsignedInt();
                  p2 = pi.readUnsignedInt();
                  pi.position = ((n + pw) << 2) + pp;
                  p3 = pi.readUnsignedInt();
                  p4 = pi.readUnsignedInt();
                  // 计算平均颜色
                  b1 = (((p1 >> 24) & 0xFF) + ((p2 >> 24) & 0xFF) + ((p3 >> 24) & 0xFF) + ((p4 >> 24) & 0xFF)) * 0.25;
                  b2 = (((p1 >> 16) & 0xFF) + ((p2 >> 16) & 0xFF) + ((p3 >> 16) & 0xFF) + ((p4 >> 16) & 0xFF)) * 0.25;
                  b3 = (((p1 >>  8) & 0xFF) + ((p2 >>  8) & 0xFF) + ((p3 >>  8) & 0xFF) + ((p4 >>  8) & 0xFF)) * 0.25;
                  b4 = (( p1        & 0xFF) + ( p2        & 0xFF) + ( p3        & 0xFF) + ( p4        & 0xFF)) * 0.25;
                  // 写出计算平均颜色
                  po.writeUnsignedInt((b1 << 24) + (b2 << 16) + (b3 << 8) + b4);
               }
            }
         }
      }
   }
}