package mo.cm.console.transfer
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.console.loader.FNetContent;
   import mo.cm.console.loader.FNetLoader;
   
   //============================================================
   // <T>传输加载器。</T>
   //============================================================
   public class FTransferContent extends FNetContent
   {
      // 传输数据
      public var data:FTransferData;
      
      // 数据位置
      public var offset:int;

      // 缓冲数据
      public var buffer:ByteArray = new ByteArray();;
      
      //============================================================
      // <T>构造传输加载器。</T>
      //============================================================
      public function FTransferContent(){
         buffer.endian = Endian.LITTLE_ENDIAN;
      }
      
      //============================================================
      // <T>加载中处理。</T>
      //
      // @param p:loader 加载器
      //============================================================
      public override function loadProgress(p:FNetLoader):void{
         super.loadProgress(p);
         // 写入加载数据
         buffer.position = 0;
         var l:int = p.readBytes(buffer);
         if(l){
            data.writeBytes(offset, buffer, 0, l);
         }
         offset += l;
      }
      
      //============================================================
      // <T>加载完成。</T>
      //
      // @param p:loader 加载器
      //============================================================
      public override function loadComplete(p:FNetLoader):void{
         super.loadComplete(p);
         // 写入加载数据
         buffer.position = 0;
         var l:int = p.readBytes(buffer);
         if(l){
            data.writeBytes(offset, buffer, 0, l);
         }
         offset += l;
         // 完成处理
         data.complete();
         buffer.clear();
         buffer = null;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         data = null;
         if(buffer){
            buffer.clear();
            buffer = null;
         }
      }
   }
}