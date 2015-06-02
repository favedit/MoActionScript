package mo.cm.core.ui
{
   import flash.display.BitmapData;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.geom.SIntPadding;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>二进制位图数据。</T>
   //============================================================
   public class FByteBitmap extends FObject
   {
      // 尺寸
      public var size:SIntSize2 = new SIntSize2();
      
      // 内边框
      public var padding:SIntPadding = new SIntPadding();
      
      // 数据
      public var data:ByteArray = new ByteArray();
      
      //============================================================
      // <T>构造二进制位图数据。</T>
      //============================================================
      public function FByteBitmap():void{
         data.endian = Endian.LITTLE_ENDIAN;
      }
      
      //============================================================
      // <T>复制位图数据。</T>
      //
      // @param p:bitmap 位图数据
      //============================================================
      public function copyFrom(p:BitmapData):void{
         // 获得数据
         var d:Vector.<uint> = p.getVector(p.rect);
         // 写入混合数据
         var c:int = d.length;
         data.position = 0;
         for(var n:int = 0; n < c; n++){
            data.writeUnsignedInt(d[n]);
         }
         // 清空数据
         d.length = 0;
         d = null;
      }
      
      //============================================================
      // <T>合并位图数据。</T>
      //
      // @param pc:bitmapColor 位图数据RGB
      // @param pa:bitmapAlpha 位图数据A
      //============================================================
      public function merge(pc:BitmapData, pa:BitmapData = null):void{
         if(pa){
            // 获得数据
            var cd:Vector.<uint> = pc.getVector(pc.rect);
            var ad:Vector.<uint> = pa.getVector(pa.rect);
            // 写入混合数据
            var c:int = cd.length;
            data.position = 0;
            for(var n:int = 0; n < c; n++){
               data.writeUnsignedInt((cd[n] & 0x00FFFFFF) + ((ad[n] & 0x000000FF) << 24));
            }
            // 清空数据
            cd.length = 0;
            cd = null;
            ad.length = 0;
            ad = null;
         }else{
            copyFrom(pc);
         }
      }
      
      //============================================================
      // <T>合并位图数据。</T>
      //
      // @param pc:bitmapColor 位图数据RGB
      // @param pa:bitmapAlpha 位图数据A
      //============================================================
      public function mergeData(pc:Vector.<uint>, pa:Vector.<uint> = null):void{
         var c:int = pc.length;
         data.position = 0;
         var n:int = -1;
         if(pa){
            while(++n < c){
               data.writeUnsignedInt((pc[n] & 0x00FFFFFF) + ((pa[n] & 0x000000FF) << 24));
            }
         }else{
            while(++n < c){
               data.writeUnsignedInt(pc[n]);
            }
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         size = null;
         padding = null;
         data.clear();
         data = null;
      }
   }
}