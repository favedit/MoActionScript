package mo.cm.lang
{
   //============================================================
   // <T>列表入口结构。</T>
   //============================================================
   public class SListEntry
   {
      // 上一个节点
      public var prior:SListEntry;
      
      // 下一个节点
      public var next:SListEntry;
      
      // 关联对象
      public var value:Object;
      
      //============================================================
      // <T>构造列表入口结构。</T>
      //============================================================
      public function SListEntry(){
      }
   }
}