package mo.cm.core.device
{
   import flash.display.Stage;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   import mo.cm.core.ui.EAlign;
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>屏幕消息。</T>
   //============================================================
   public class FScreenMessage extends FObject
   {
      // 是否可见
      public var visible:Boolean;
      
      // 舞台对象
      public var stage:Stage;
      
      // 消息格式
      public var messageFormat:TextFormat = new TextFormat(); 
      
      // 消息标签
      public var messageLabel:TextField;
      
      //============================================================
      // <T>构造屏幕消息。</T>
      //============================================================
      public function FScreenMessage(){
      }
      
      //============================================================
      // <T>舞台改变大小事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onResize(e:Event):void{
         if(visible){
            messageLabel.width = messageLabel.textWidth + 4;
            messageLabel.height = messageLabel.textHeight + 4;
            messageLabel.x = (stage.stageWidth - messageLabel.width) / 2;
            messageLabel.y = (stage.stageHeight - messageLabel.height) / 4;
         }
      }

      //============================================================
      // <T>设置处理。</T>
      //
      // @param p:stage 舞台对象
      //============================================================
      public function setup(p:Stage):void{
         stage = p;
         // 设置字体
         messageFormat.font = "SimSun";
         messageFormat.kerning = false;
         messageFormat.size = 12;
         // 创建标题
         messageLabel = new TextField();
         messageLabel.multiline = true;
         messageLabel.border = true;
         messageLabel.borderColor = 0x333333;
         messageLabel.background = true;
         messageLabel.backgroundColor = 0xF8F0F0;
         messageLabel.textColor = 0x666666;
         messageLabel.alpha = 0.8;
         messageLabel.setTextFormat(messageFormat);
         // 增加事件
         stage.addEventListener(Event.RESIZE, onResize);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //
      // @param pm:message 消息
      // @param pa:alignCd 对齐方式
      //============================================================
      public function show(pm:String, pa:int = EAlign.Center):void{
         // 设置文字内容
         messageLabel.htmlText = pm;
         // 显示消息
         if(!visible){
            stage.addChild(messageLabel);
            visible = true;
         }
         // 改变大小
         onResize(null);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function hide():void{
         if(visible){
            stage.removeChild(messageLabel);
            visible = false;
         }
      }
   }
}