package mo.cm.console.progress
{
   import mo.cm.system.FEvent;

   //============================================================
   // <T>进度事件对象。</T>
   //============================================================
   public class FProgressEvent extends FEvent
   {
      // 消息
      public var message:String;
      
      // 比率
      public var percent:int;
      
      //============================================================
      // <T>进度事件对象。</T>
      //
      // @param pe:event 事件
      // @param ps:sender 发送者
      // @param pn:sender 发送名称
      //============================================================
      public function FProgressEvent(pe:* = null, ps:* = null, pn:String = null){
         super(pe, ps, pn);
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         message = null;
         super.dispose();
      }
   }
}