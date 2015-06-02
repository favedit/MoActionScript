package mo.cm.console.progress
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   import mo.cm.core.common.FConsole;
   import mo.cm.core.content.RHtml;
   import mo.cm.core.device.RScreen;
   import mo.cm.core.ui.EAlign;
   import mo.cm.system.FListeners;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>进度控制台。</T>
   //============================================================
   public class FProgressConsole extends FConsole
   {
      // 是否可见
      public var visible:Boolean;
      
      // 消息格式
      public var messageFormat:TextFormat = new TextFormat(); 
      
      // 消息标签
      public var messageLabel:TextField;
      
      // 信息集合
      public var infos:Vector.<FProgressInfo> = new Vector.<FProgressInfo>();
      
      // 信息监听器
      public var lsnsProcess:FListeners = new FListeners(); 

      //============================================================
      // <T>构造进度控制台。</T>
      //============================================================
      public function FProgressConsole(){
         name = "common.progress.console";
      }
      
      //============================================================
      // <T>根据代码查找信息。</T>
      //
      // @param p:code 设置信息
      // @return 信息
      //============================================================
      public function get(p:String):FProgressInfo{
         var c:int = infos.length;
         for(var n:int = 0; n < c; n++){
            var i:FProgressInfo = infos[n];
            if(i.code == p){
               return i;
            }
         }
         return null;
      }
      
      //============================================================
      // <T>加载配置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.isName("Info")){
               var i:FProgressInfo = new FProgressInfo();
               i.loadConfig(x);
               infos.push(i);
            }
         }
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public override function setup():void{
         if(RScreen.stage){
            super.setup();
            // 设置字体
            messageFormat.font = "SimSun";
            messageFormat.kerning = false;
            messageFormat.size = 24;
            // 创建标题
            messageLabel = new TextField();
            messageLabel.multiline = true;
            messageLabel.alpha = 0.8;
            messageLabel.setTextFormat(messageFormat);
            // 增加事件
            RScreen.stage.addEventListener(Event.RESIZE, onResize);
         }
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
            messageLabel.x = (RScreen.stage.stageWidth - messageLabel.width) / 2;
            messageLabel.y = (RScreen.stage.stageHeight - messageLabel.height) / 2;
         }
      }
      
      //============================================================
      // <T>设置处理。</T>
      //
      // @param pm:message 消息
      // @param pa:alignCd 对齐方式
      //============================================================
      public function show(pm:String, pa:int = EAlign.Center):void{
         if(setuped){
            // 设置文字内容
            messageLabel.htmlText = pm;
            // 显示消息
            if(!visible){
               RScreen.stage.addChild(messageLabel);
               visible = true;
            }
            // 改变大小
            onResize(null);
         }
      }
      
      //============================================================
      // <T>显示代码。</T>
      //
      // @param pc:code 代码
      // @param pa:alignCd 对齐方式
      //============================================================
      public function showCode(pc:String, pa:int = EAlign.Center):void{
         if(setuped){
            var i:FProgressInfo = get(pc);
            // 设置文字内容
            messageLabel.htmlText = RHtml.fromat(i.note);
            // 显示消息
            if(!visible){
               RScreen.stage.addChild(messageLabel);
               visible = true;
            }
            // 改变大小
            onResize(null);
         }
      }
      
      //============================================================
      // <T>显示信息。</T>
      //
      // @param pm:message 消息
      // @param pp:percent 比率
      //============================================================
      public function showInfo(pm:String, pp:int = -1):void{
         var e:FProgressEvent = new FProgressEvent();
         e.message = pm
         e.percent = pp;
         lsnsProcess.process(e);
         e.dispose();
         e = null;
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function hide():void{
         if(setuped){
            if(visible){
               RScreen.stage.removeChild(messageLabel);
               visible = false;
            }
         }
      }
   }
}