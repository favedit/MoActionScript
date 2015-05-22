package mo.cm.console.transfer
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;

   //============================================================
   // <T>数据。</T>
   //============================================================
   public class FTransferData extends FObject
   {
      public var domain:FTransferDomain;
      
      // 编号
      public var id:int

      // 位置
      public var offset:int;
      
      // 长度
      public var length:int;
      
      // 写入位置
      public var position:int;

      // 路径
      public var path:String;

      // 加载中
      public var ready:Boolean;

      // 加载中
      public var loading:Boolean;

      // 数据
      public var data:ByteArray;
      
      // 传输块集合
      public var blocks:Vector.<FTransferBlock>;
      
      // 加载器集合
      public var loaders:Vector.<FTransferContent>;
      
      //============================================================
      // <T>构造数据。</T>
      //============================================================
      public function FTransferData(){
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param p:input 数据内容
      //============================================================
      public function unserialize(pd:FTransferDomain, pi:IInput):void{
         // 读取属性
         id = pi.readInt32();
         offset = pi.readInt32();
         length = pi.readInt32();
         // 读取传输块集合
         var c:int = pi.readInt32();
         blocks = new Vector.<FTransferBlock>(c, true);
         for(var n:int = 0; n < c; n++){
            var bi:int = pi.readInt32();
            var b:FTransferBlock = pd.blocks[bi];
            b.data = this;
            blocks[n] = b;
         }
      }
      
      //============================================================
      // <T>加入传输器。</T>
      //
      // @param p:loader 传输器
      //============================================================
      public function pushLoader(p:FTransferContent):void{
         if(!loaders){
            loaders = new Vector.<FTransferContent>();
         }
         loaders.push(p);
      }

      //============================================================
      // <T>写入读取到的数据。</T>
      //
      // @param pp:position 位置
      // @param pd:data 数据
      // @param po:offset 索引
      // @param pl:length 长度
      //============================================================
      public function writeBytes(pp:int, pd:ByteArray, po:int, pl:int):void{
         // 计算位置
         var wo:int = po;
         var wl:int = pl;
         if(pp < position){
            wo = position - pp + po;
            wl = pp + pl - position;
         }
         // 写入数据
         if(wl > 0){
            data.writeBytes(pd, wo, wl);
            position += wl;
         }
      }
      
      //============================================================
      // <T>加入传输器。</T>
      //
      // @param p:loader 传输器
      //============================================================
      public function load():void{
         position = 0;
         data = new ByteArray();
         data.endian = Endian.LITTLE_ENDIAN;
         loading = true;
      }

      //============================================================
      // <T>加入传输器。</T>
      //
      // @param p:loader 传输器
      //============================================================
      public function complete():void{
         // 取消所有加载器
         for(var n:int = loaders.length - 1; n >= 0; n--){
            loaders[n].valid = false;
         }
         // 数据就绪
         ready = true;
      }
   
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function free():void{
         if(loaders){
            var c:int = loaders.length;
            for(var n:int = 0; n < c; n++){
               var l:FTransferContent = loaders[n];
               l.dispose();
               loaders[n] = null;
            }
            loaders.length = 0;
            loaders = null;
         }
      }
   }
}