package mo.cm.system
{   
   import flash.display.Stage;
   
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>事件对象。</T>
   //============================================================
   public class FEvent extends FObject
   {
      // 代码
      public var code:String;
      
      // 发送者
      public var sender:*;
      
      // 发送名称
      public var senderName:String;
      
      // 拥有者
      public var owner:*;
      
      // 事件
      public var event:*;
      
      // 附加对象
      public var tag:*;
      
      //============================================================
      // <T>创建事件对象。</T>
      //
      // @param pe:event 事件
      // @param ps:sender 发送者
      // @param pn:sender 发送名称
      //============================================================
      public function FEvent(pe:* = null, ps:* = null, pn:String = null){
         event = pe;
         sender = ps;
         senderName = pn;
      }
      
      //============================================================
      // <T>判断发送者是否为舞台。</T>
      //
      // @return 是否为舞台
      //============================================================
      public function isStage():Boolean{
         var r:Stage = sender as Stage;
         return (null != r);
      }

      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         code = null;
         sender = null;
         senderName = null;
         owner = null;
         event = null;
         tag = null;
         super.dispose();
     }
   }  
}