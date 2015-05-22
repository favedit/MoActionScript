package mo.cm.console.track
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RGlobal;
   import mo.cm.core.device.RKeybord;
   import mo.cm.core.device.RScreen;
   import mo.cm.lang.FString;
   import mo.cm.logger.ELogger;
   import mo.cm.logger.FLoggerEvent;
   import mo.cm.logger.RLogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>跟踪控制台。</T>
   //============================================================
   public class FTrackConsole extends FConsole
   {
      // 是否可见
      public var visible:Boolean;

      // 跟踪集合
      public var tracks:Vector.<FTrack> = new Vector.<FTrack>();
      
      // 文本格式
      public var panelFormat:TextFormat = new TextFormat(); 
      
      // 文本标签
      public var panelLabel:TextField;
      
      //============================================================
      // <T>构造跟踪控制台。</T>
      //============================================================
      public function FTrackConsole(){
         name = "common.track.console";
      }
      
      //============================================================
      // <T>加载配置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         RLogger.registerWrite(onWrite, this);
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         if(RScreen.stage){
            super.setup();
            // 设置字体
            panelFormat.font = "SimSun";
            panelFormat.kerning = false;
            panelFormat.size = 20;
            // 创建标题
            panelLabel = new TextField();
            panelLabel.multiline = true;
            panelLabel.border = true;
            panelLabel.borderColor = 0x000000;
            panelLabel.background = true;
            panelLabel.backgroundColor = 0xFFFFFF;
            panelLabel.textColor = 0xFF0000;
            panelLabel.alpha = 0.9;
            panelLabel.setTextFormat(panelFormat);
            // 增加事件
            RScreen.stage.addEventListener(Event.RESIZE, onResize);
            RScreen.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
         }
      }
      
      //============================================================
      // <T>舞台改变大小事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onResize(e:Event):void{
         if(visible){
            panelLabel.width = panelLabel.textWidth + 10;
            panelLabel.height = panelLabel.textHeight + 4;
            panelLabel.x = (RScreen.stage.stageWidth - panelLabel.width) / 2;
            panelLabel.y = (RScreen.stage.stageHeight - panelLabel.height) / 2;
         }
      }
      
      //============================================================
      // <T>舞台按键事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onKeyDown(e:KeyboardEvent):void{
         if(!RGlobal.isOnline){
//            if(e.keyCode == RKeybord.PAD_O){
//               if(visible){
//                  hide();
//               }else{
//                  show();
//               }
//            }
         }
      }
      
      //============================================================
      // <T>日志输出事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function onWrite(e:FLoggerEvent):void{
         if((ELogger.Error == e.levelCd) || (ELogger.Fatal == e.levelCd)){
            // 建立跟踪
            var t:FTrack = new FTrack();
            t.text = e.message;
            if(tracks.length < 256){
               tracks.push(t);
               // 显示信息
               show();
            }
         }
      }

      //============================================================
      // <T>日志输出事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public function makeText():String{
         var m:FString = new FString();
         var c:int = tracks.length;
         var l:int = Math.max(c - 40, 0);
         for(var n:int = c - 1; n >= l; n--){
            var t:FTrack = tracks[n];
            m.appendLine(t.text);
         }
         return "Tracks (count=" + c + ")\n" + m.toString();
      }
      
      //============================================================
      // <T>显示处理。</T>
      //============================================================
      public function show():void{
         if(setuped){
            // 设置文字内容
            panelLabel.htmlText = makeText();
            // 显示消息
            if(!visible){
               RScreen.stage.addChild(panelLabel);
               visible = true;
            }
            // 改变大小
            onResize(null);
         }
      }
      
      //============================================================
      // <T>隐藏处理。</T>
      //============================================================
      public function hide():void{
         if(setuped){
            if(visible){
               RScreen.stage.removeChild(panelLabel);
               visible = false;
            }
         }
      }
   }
}