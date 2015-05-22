package mo.cm.console.transfer
{
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   
   //============================================================
   // <T>资源域。</T>
   //============================================================
   public class FTransferDomain extends FObject
   {
      // 名称
      public var code:String;
      
      // 传输块集合
      public var blocks:Vector.<FTransferBlock>;
      
      // 传输数据集合
      public var datas:Vector.<FTransferData>;
      
      //============================================================
      // <T>构造资源域。</T>
      //============================================================
      public function FTransferDomain(){
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param p:input 数据内容
      //============================================================
      public function unserialize(p:IInput):void{
         // 读取传输块
         var bc:int = p.readInt32();
         blocks = new Vector.<FTransferBlock>(bc, true);
         for(var bn:int = 0; bn < bc; bn++){
            var b:FTransferBlock = new FTransferBlock();
            b.unserialize(p);
            blocks[bn] = b;
         }
         // 读取传输数据
         var dc:int = p.readInt32();
         datas = new Vector.<FTransferData>(dc, true);
         for(var dn:int = 0; dn < dc; dn++){
            var d:FTransferData = new FTransferData();
            d.domain = this;
            d.unserialize(this, p);
            datas[dn] = d;
         }
      }
   }
}