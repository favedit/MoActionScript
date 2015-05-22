package mo.cm.console.resource
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   import mo.cm.lang.FObject;

   //============================================================
   // <T>资源组块。</T>
   //============================================================
   public class FResourceBlock extends FObject
   {
      // 网络地址
      public var url:String;
      
      // 位置
      public var offset:int;

      // 大小
      public var size:int;
      
      // 有效标志
      public var valid:Boolean;
      
      // 准备标志
      public var ready:Boolean;
      
      // 读取位置
      public var positionRead:int;
      
      // 写入位置
      public var positionWrite:int;
      
      // 数据内容
      public var data:ByteArray;

      //============================================================
      // <T>构造资源组块。</T>
      //============================================================
      public function FResourceBlock(){
      }
   
      //============================================================
      // <T>写入读取到的数据。</T>
      //
      // @param pp:position 位置
      // @param pd:data 数据
      // @param po:offset 索引
      // @param pl:length 长度
      //============================================================
      public function write(pp:int, pd:ByteArray, po:int, pl:int):void{
         // 创建数据
         if(!data){
            positionRead = 0;
            positionWrite = 0;
            data = new ByteArray();
            data.endian = Endian.LITTLE_ENDIAN;
         }
         // 计算位置
         if(pp < positionWrite){
            pp = positionWrite;
            po = positionWrite - pp;
            pl = pl - po;
         }
         // 写入数据
         if(pl > 0){
            data.position = pp;
            data.writeBytes(pd, po, pl);
            positionWrite += pl;
            // 当前状态有效
            valid = true;
            if(positionWrite == size){
               ready = true;
            }
         }
      }

      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         url = null;
         if(data){
            data.clear();
            data = null;
         }
      }
   }
}