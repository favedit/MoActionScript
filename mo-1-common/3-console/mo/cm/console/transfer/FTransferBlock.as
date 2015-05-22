package mo.cm.console.transfer
{
   import mo.cm.lang.FObject;
   import mo.cm.stream.IInput;
   
   //============================================================
   // <T>数据块。</T>
   //============================================================
   public class FTransferBlock extends FObject
   {
      // 编号
      public var id:int;
      
      // 位置
      public var offset:int;
      
      // 长度
      public var length:int;
      
      // 准备标志
      public var ready:Boolean;
      
      // 数据
      public var data:FTransferData;
      
      //============================================================
      // <T>构造数据块。</T>
      //============================================================
      public function FTransferBlock(){
      }
   
      //============================================================
      // <T>测试是否完成。</T>
      //
      // @return 是否完成
      //============================================================
      public function testReady():Boolean{
         if(!ready){
            if(data.position >= (offset + length)){
               ready = true;
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>从输入流里反序列化数据内容。</T>
      //
      // @param p:input 数据内容
      //============================================================
      public function unserialize(p:IInput):void{
         id = p.readInt32();
         offset = p.readInt32();
         length = p.readInt32();
      }
   }
}