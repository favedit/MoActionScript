package mo.cm.console.transfer
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   
   //============================================================
   // <T>传输器。</T>
   //============================================================
   public class FTransfer extends FObject
   {
      // 准备好
      public var ready:Boolean;
      
      // 准备好
      public var loading:Boolean;

      // 数据大小
      public var size:int;

      // 数据内容
      public var data:ByteArray;

      // 传输块集合
      public var blocks:Vector.<FTransferBlock>;
      
      // 传输数据集合
      public var datas:Vector.<FTransferData>;

      //============================================================
      // <T>构造传输器。</T>
      //============================================================
      public function FTransfer(){
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param p:input 数据内容
      //============================================================
      public function unserialize(pd:FTransferDomain, pi:IInput):void{
         // 读取属性
         size = pi.readInt32();
         // 读取资源列表
         var c:int = pi.readInt32();
         blocks = new Vector.<FTransferBlock>(c, true);
         for(var n:int = 0; n < c; n++){
            var bi:int = pi.readInt32();
            blocks[n] = pd.blocks[bi];
         }
         // 读取数据列表
         datas = new Vector.<FTransferData>();
         for(var i:int = 0; i < c; i++){
            var d:FTransferData = blocks[i].data;
            if(-1 == datas.indexOf(d)){
               datas.push(d);
            }
         }
      }
      
      //============================================================
      // <T>增加一个请求。</T>
      //
      // @param p:request 请求
      //============================================================
      public function pushBlock(p:FTransferBlock):void{
         blocks.push(p);
      }
      
      //============================================================
      // <T>测试是否完成。</T>
      //
      // @return 是否完成
      //============================================================
      public function testReady():Boolean{
         var c:int = blocks.length;
         for(var n:int = 0; n < c; n++){
            var b:FTransferBlock = blocks[n];
            if(!b.testReady()){
               return false;
            }
         }
         return true;
      }

      //============================================================
      // <T>解压处理完成处理。</T>
      //============================================================
      public function uncompress():void{
         data.position = 0;
         data.inflate();
      }
      
      //============================================================
      // <T>完成处理。</T>
      //============================================================
      public function complete():void{
         // 写入数据
         data = new ByteArray();
         data.endian = Endian.LITTLE_ENDIAN;
         var c:int = blocks.length;
         for(var n:int = 0; n < c; n++){
            var b:FTransferBlock = blocks[n];
            var d:FTransferData = b.data;
            data.writeBytes(d.data, b.offset, b.length);
         }
         uncompress();
         // 准备好
         ready = true;
      }
   
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function free():void{
         ready = false;
         loading = false;
         if(null != data){
            data.clear();
            data = null;
         }
      }
   }
}