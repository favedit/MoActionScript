package mo.cm.console.resource
{
   import flash.display.Bitmap;
   
   import mo.cm.lang.FDictionary;
   
   //============================================================
   // <T>内容对象。</T>
   //============================================================
   public class FBitmapContent extends FContent
   {
      // 位图字典
      public var bitmaps:FDictionary = new FDictionary();
      
      //============================================================
      // <T>构造内容对象。</T>
      //============================================================
      public function FBitmapContent(){
         display = loader;
      }
      
      //============================================================
      // <T>同步一个指定大小的图片。</T>
      //
      // @param pw:width 宽度
      // @param ph:height 高度
      //============================================================
      public function syncBitmap(pw:int, ph:int):Bitmap{
         var c:String = pw + "x" + ph;
         var b:Bitmap = bitmaps.get(c);
         if(null == b){
            var cb:Bitmap = loader.content as Bitmap;
            if(null != cb){
               b = new Bitmap(cb.bitmapData);
               b.width = pw;
               b.height = ph;
               bitmaps.set(c, b);
            }
         }
         return b;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != bitmaps){
            bitmaps.clear();
            bitmaps = null;
         }
         super.dispose();
      }
   }
}
