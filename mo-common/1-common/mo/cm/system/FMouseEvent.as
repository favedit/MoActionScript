package mo.cm.system
{
   import flash.events.MouseEvent;
   
   //============================================================
   // <T>鼠标事件对象。</T>
   //============================================================
   public class FMouseEvent extends FEvent
   {
      // 是否鼠标左键
      public var isLeftButton:Boolean; 
      
      // 是否鼠标右键
      public var isRightButton:Boolean; 
      
      // 舞台横位置
      public var stageX:int; 
      
      // 舞台纵位置
      public var stageY:int; 
      
      // 本地横位置
      public var localX:int; 
      
      // 本地纵位置
      public var localY:int; 
      
      // 滑动值
      public var delta:int; 
      
      //============================================================
      // <T>构造鼠标事件对象。</T>
      //
      // @param pe:event 事件
      // @param ps:sender 发送者
      // @param pn:sender 发送名称
      //============================================================
      public function FMouseEvent(pe:* = null, ps:* = null, pn:String = null){
         super(pe, ps, pn);
      }
      
      //============================================================
      // <T>是否CTRL按下。</T>
      //============================================================
      public function get ctrlKey():Boolean{
         return (event as MouseEvent).ctrlKey;
      } 
      
      //============================================================
      // <T>是否ALT按下。</T>
      //============================================================
      public function get altKey():Boolean{
         return (event as MouseEvent).altKey;
      } 
   }
}