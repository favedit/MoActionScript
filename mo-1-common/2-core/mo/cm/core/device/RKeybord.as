package mo.cm.core.device
{
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import mo.cm.system.FKeyEvent;
   import mo.cm.system.FListeners;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>全局键盘信息。</T>
   //============================================================
   public class RKeybord
   {
      public static const STATUS_NORMAL:int = 0x00;
      
      public static const STATUS_PRESSED:int = 0x01; 
      
      public static const PAD_DUMP:int = 220; 

      public static const PAD_SPACE:int = Keyboard.SPACE; 

      public static const PAD_LEFT:int = Keyboard.LEFT; 
      
      public static const PAD_UP:int = Keyboard.UP; 
      
      public static const PAD_RIGHT:int = Keyboard.RIGHT; 
      
      public static const PAD_DOWN:int = Keyboard.DOWN; 
      
      public static const PAD_DOT:int = 27; // KeyCode: `

      public static const PAD_0:int = 48; // KeyCode: 0
      public static const PAD_1:int = 49; // KeyCode: 1
      public static const PAD_2:int = 50; // KeyCode: 2
      public static const PAD_3:int = 51; // KeyCode: 3
      public static const PAD_4:int = 52; // KeyCode: 4
      public static const PAD_5:int = 53; // KeyCode: 5
      public static const PAD_6:int = 54; // KeyCode: 6
      public static const PAD_7:int = 55; // KeyCode: 7
      public static const PAD_8:int = 56; // KeyCode: 8
      public static const PAD_9:int = 57; // KeyCode: 9

      public static const PAD_A:int = 65; // KeyCode: A
      public static const PAD_B:int = 66; // KeyCode: B
      public static const PAD_C:int = 67; // KeyCode: C
      public static const PAD_D:int = 68; // KeyCode: D
      public static const PAD_E:int = 69; // KeyCode: E
      public static const PAD_F:int = 70; // KeyCode: F
      public static const PAD_G:int = 71; // KeyCode: G
      public static const PAD_H:int = 72; // KeyCode: H
      public static const PAD_I:int = 73; // KeyCode: I
      public static const PAD_J:int = 74; // KeyCode: J
      public static const PAD_K:int = 75; // KeyCode: K
      public static const PAD_L:int = 76; // KeyCode: L
      public static const PAD_M:int = 77; // KeyCode: M
      public static const PAD_N:int = 78; // KeyCode: N
      public static const PAD_O:int = 79; // KeyCode: O
      public static const PAD_P:int = 80; // KeyCode: P
      public static const PAD_Q:int = 81; // KeyCode: Q
      public static const PAD_R:int = 82; // KeyCode: R
      public static const PAD_S:int = 83; // KeyCode: S
      public static const PAD_T:int = 84; // KeyCode: T
      public static const PAD_U:int = 85; // KeyCode: U
      public static const PAD_V:int = 86; // KeyCode: V
      public static const PAD_W:int = 87; // KeyCode: W
      public static const PAD_X:int = 88; // KeyCode: X
      public static const PAD_Y:int = 89; // KeyCode: Y
      public static const PAD_Z:int = 90; // KeyCode: Z
		public static const PAD_BL:int = 192; // KeyCode: ~

      public static const PAD_RIDE_WEAPON:int = 49; // KeyCode:1 
      
      public static const PAD_RIDE_ARMOR:int = 50; // KeyCode:2 
      
      public static const PAD_EQUIP:int = 67; // KeyCode:C 
      
      public static const PAD_RIDE:int = 82;  // KeyCode:R
      
      public static const PAD_DANCE:int = 81; // KeyCode:Q
      
      public static const PAD_TEAM:int = 84; // KeyCode:T
      
      public static const PAD_LEAVE:int = 76; // KeyCode:L
      
      public static const PAD_KICK:int = 75; // KeyCode:K
      
      public static const PAD_FRIEND:int = 70; // KeyCode:F
      
      public static const PAD_ENTER:int = 13; // KeyCode:Enter
      
      public static const PAD_SHIFT:int = 16; // KeyCode:Shift
      
      public static const PAD_CTRL:int = 17; // KeyCode:Ctrl
      
      public static const PAD_MAP:int = 77; // KeyCode:Map
      
      public static var pressed:Boolean;

      protected static var status:Vector.<int> = new Vector.<int>(255); 
      
      protected static var _event:FKeyEvent = new FKeyEvent();
      
      // 按键落下监听器
      public static var lsnsKeyDown:FListeners = new FListeners();
      
      // 按键抬起监听器
      public static var lsnsKeyUp:FListeners = new FListeners();

      //============================================================
      // <T>关联舞台。</T>
      //
      // @param p:stage 舞台
      //============================================================
      public static function link(p:Stage):void{
         p.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
         p.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
      }

      //============================================================
      // <T>按键落下处理。</T>
      //
      // @param p:keyCode 代码
      //============================================================
      public static function processDown(p:int):void{
         status[p] = STATUS_PRESSED;
         pressed = true;
      }
      
      //============================================================
      // <T>按键落下事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onKeyDown(e:KeyboardEvent):void{
         // 落下处理
         processDown(e.keyCode);
         // 分发事件
         _event.keyCode = e.keyCode;
         lsnsKeyDown.process(_event);
      }
      
      //============================================================
      // <T>按键抬起处理。</T>
      //
      // @param p:keyCode 代码
      //============================================================
      public static function processUp(p:int):void{
         status[p] = STATUS_NORMAL;
         pressed = isPressed();
      }
      
      //============================================================
      // <T>按键抬起事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public static function onKeyUp(e:KeyboardEvent):void{
         // 落下处理
         processUp(e.keyCode);
         // 分发事件
         _event.keyCode = e.keyCode;
         lsnsKeyUp.process(_event);
      }

      //============================================================
      public static function isPressed():Boolean{
         for(var n:int = status.length - 1; n>=0; n--){
            if(STATUS_PRESSED == status[n]){
               return true;
            }
         }
         return false;
      }

      //============================================================
      public static function isPressedKey(keyCode:int):Boolean{
         return (STATUS_PRESSED == status[keyCode]);
      }
      
      //============================================================
      public static function isPressedLeft():Boolean{
         return (STATUS_PRESSED == status[PAD_LEFT]);
      }
      
      //============================================================
      public static function isPressedUp():Boolean{
         return (STATUS_PRESSED == status[PAD_UP]);
      }
      
      //============================================================
      public static function isPressedRight():Boolean{
         return (STATUS_PRESSED == status[PAD_RIGHT]);
      }
      
      //============================================================
      public static function isPressedDown():Boolean{
         return (STATUS_PRESSED == status[PAD_DOWN]);
      }
      
      //============================================================
      public static function construct():void{
      }
      
      //============================================================
      public static function loadConfig(config:FXmlNode):void{
      }
      
      //============================================================
      public static function setup():void{
      }
      
      //============================================================
      public static function reset():void{
         for(var n:int = status.length - 1; n>=0; n--){
            status[n] = STATUS_NORMAL;
         }
      }
   }
}