package mo.cm.core.ui
{
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.text.TextField;
   
   public class FMessageBox extends FControl{
      //============================================================
      // @structure:结构变量
      //============================================================
      // @structure:绘制精灵
      protected var _sprite:FSprite = new FSprite();
      
      // @structure:消息
      protected var _message:TextField = new TextField();
      
      //============================================================
      // @property:属性变量
      //============================================================
      
      // @property:间隔时间
      protected  var _interval:Number;
      
      // @property:自动隐藏
      protected  var _autoHide:Boolean;
      
      // @property:确认可见
      protected  var _confirmVisible:Boolean = false;
      
      protected  var _cancelVisible:Boolean = false;
      
      //============================================================
      public function FMessageBox(name:String = null){
         super(name);
         display = _sprite;
      }
      
      //============================================================
      public override function setup():void{
         draw();
         buildMessage();
         _sprite.addChild(_message);
      }
      
      //==========================================================
      // <T>初始化label</T>
      //
      // @ params name type label:按钮名称，x，y:坐标,width,height:大小
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      // @ Date  9.13 修改  YUFAL
      //==========================================================
      public function buildMessage():void{
         // 绘制
         var g:Graphics = _sprite.graphics;
         g.lineStyle(1, 0xffffff);
         g.beginFill(0x123456);
         g.drawRoundRect(0, 0, 300, 150, 4, 4);
         g.endFill();
         
         _message.x = 10;
         _message.y = 20;
         _message.textColor = 0xffffff;
         _message.width = 260;
         _message.defaultTextFormat = RStyle.LabelMidleFormat;
      }
      
      //==========================================================
      // <T>获得取消键监听器</T>
      //
      // @return Flisteners监听器 <UL>
      //     		</UL>
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function get cancelVisible():Boolean{
         return _cancelVisible;
      }
      
      //==========================================================
      // <T>获得确定键监听器</T>
      //
      // @return Flisteners监听器 <UL>
      //     		</UL>
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function get confirmVisible():Boolean{
         return _confirmVisible;
      }
      
      //==========================================================
      // <T>设置取消键是否可见</T>
      //
      // @ params boolean 可见/不可见
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function set cancelVisible(value:Boolean):void{
         _cancelVisible = value;
      }
       
      //==========================================================
      // <T>获得确定键监听器</T>
      //
      // @ params boolean 可见/不可见
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function set confirmVisible(value:Boolean):void{
         _confirmVisible = value;
      }
      
      //==========================================================
      // <T>设置显示label内容</T>
      //
      // @ params String 内容字符串
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function set message(value:String):void{
         _message.text = value;
      }
      
      //==========================================================
      // <T>设置是否自动隐藏</T>
      //
      // @ params boolean 是否隐藏
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function set autoHide(autu:Boolean):void{
         _autoHide = autu;
      }
      
      //============================================================
      // 绘制
      public function set interval(time:Number):void{
         _interval = time;
      }
      
      //==========================================================
      // <T>显示messageBox</T>
      //
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function show():void{
         _sprite.visible = true;
      }
      
      //==========================================================
      // <T>隐藏messageBox</T>
      //
      // @ Date  5.14 新建  HANZH
      // @ Date  5.20 修改  HANZH
      //==========================================================
      public function hide():void{
         _sprite.visible = false;
      }
      
      //============================================================
      public function update(frameTime:Number):void{
         if(_autoHide){
            if(frameTime <= _interval){
               _interval -= frameTime;
            }else{
               hide();
            }
         }
      }
      
      //============================================================
      public function onResourceLoaded(event:Event):void{
         
      }
      
      //============================================================
      // 加载资源文件
      public function loadPath(path:String):void{
      }
   }
}