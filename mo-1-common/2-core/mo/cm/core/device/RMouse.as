package mo.cm.core.device
{
   import flash.display.Stage;
   import flash.events.MouseEvent;
   
   import mo.cm.system.FListeners;
   import mo.cm.system.FMouseEvent;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>鼠标设备。</T>
   //============================================================
   public class RMouse
   {
      // 事件对象
      public static var event:FMouseEvent = new FMouseEvent();
      
      // 鼠标点击监听器
      public static var lsnsClick:FListeners = new FListeners();

      // 鼠标落下监听器
      public static var lsnsMouseDown:FListeners = new FListeners();
      
      // 鼠标移动监听器
      public static var lsnsMouseMove:FListeners = new FListeners();
      
      // 鼠标抬起监听器
      public static var lsnsMouseUp:FListeners = new FListeners();
      
      // 鼠标移出监听器
      public static var lsnsMouseOut:FListeners = new FListeners();

      // 鼠标滑动监听器
      public static var lsnsMouseWheel:FListeners = new FListeners();

      //============================================================
      // <T>关联舞台。</T>
      //============================================================
      public static function link(p:Stage):void{
         p.addEventListener(MouseEvent.CLICK, onClick);
         p.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
         p.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
         p.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
         p.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
         p.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
      }
      
      //============================================================
      // <T>鼠标点击事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onClick(e:MouseEvent):void{
         event.event = e;
         event.sender = e.target;
         event.isLeftButton = true;
         event.isRightButton = false;
         event.stageX = e.stageX;
         event.stageY = e.stageY;
         event.localX = e.localX;
         event.localY = e.localY;
         lsnsClick.process(event);
      }
      
      //============================================================
      // <T>鼠标落下事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onMouseDown(e:MouseEvent):void{
         event.event = e;
         event.sender = e.target;
         event.isLeftButton = true;
         event.isRightButton = false;
         event.stageX = e.stageX;
         event.stageY = e.stageY;
         event.localX = e.localX;
         event.localY = e.localY;
         lsnsMouseDown.process(event);
      }
      
      //============================================================
      // <T>鼠标移动事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onMouseMove(e:MouseEvent):void{
         event.event = e;
         event.sender = e.target;
         event.isLeftButton = false;
         event.isRightButton = false;
         event.stageX = e.stageX;
         event.stageY = e.stageY;
         event.localX = e.localX;
         event.localY = e.localY;
         lsnsMouseMove.process(event);
      }
      
      //============================================================
      // <T>鼠标抬起事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onMouseUp(e:MouseEvent):void{
         event.event = e;
         event.sender = e.target;
         event.isLeftButton = true;
         event.isRightButton = false;
         event.stageX = e.stageX;
         event.stageY = e.stageY;
         event.localX = e.localX;
         event.localY = e.localY;
         lsnsMouseUp.process(event);
      }
      
      //============================================================
      // <T>鼠标移出事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onMouseOut(e:MouseEvent):void{
         event.event = e;
         event.sender = e.target;
         event.isLeftButton = false;
         event.isRightButton = false;
         event.stageX = e.stageX;
         event.stageY = e.stageY;
         event.localX = e.localX;
         event.localY = e.localY;
         lsnsMouseOut.process(event);
      }
      
      //============================================================
      // <T>鼠标滑动事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onMouseWheel(e:MouseEvent):void{
         event.delta = e.delta
         event.event = e;
         event.sender = e.target;
         event.isLeftButton = true;
         event.isRightButton = false;
         event.stageX = e.stageX;
         event.stageY = e.stageY;
         event.localX = e.localX;
         event.localY = e.localY;
         lsnsMouseWheel.process(event);
      }
      
      //============================================================
      // <T>构造处理。</T>
      //============================================================
      public static function construct():void{
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public static function loadConfig(p:FXmlNode):void{
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public static function setup():void{
      }
   }
}