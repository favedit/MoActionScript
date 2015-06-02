package mo.cm.net
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>网络数据块。</T>
   //============================================================
   public class FNetBlock extends FObject
   {
      // 位置
      public var offset:int;

      // 长度
      public var length:int;

      // 网络数据
      public var data:FNetData;

      //============================================================
      // <T>构造网络数据块。</T>
      //============================================================
      public function FNetBlock(){
      }
   }
}