package mo.cm.core.ui
{   
   import flash.display.DisplayObject;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObjects;
   import mo.cm.logger.RLogger;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>可视控件。</T>
   //============================================================
   public class FControl extends FComponent
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FControl);
      
      public var index:int;
      
      protected var _controls:FObjects;
      
      public var display:DisplayObject;
      
      public var canvas:FGraphics;
      
      public var position:SIntPoint2 = new SIntPoint2();
      
      public var size:SIntSize2 = new SIntSize2();
      
      // 鼠标点击
      public var lsnsClick:FListeners;
      
      // 鼠标双击
      public var lsnsDblClick:FListeners;

      //============================================================
      public function FControl(name:String=null) {
         super(name);
      }
      
      //============================================================
      // <T>注册一个点击监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function registerClick(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsClick){
            lsnsClick = new FListeners(this);
         }
         return lsnsClick.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注册一个双击监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function registerDblClick(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsDblClick){
            lsnsDblClick = new FListeners(this);
         }
         return lsnsDblClick.register(pm, po, pc);
      }
      
      //============================================================
      public function get controls():FObjects {
         if (null == _controls) {
            _controls = new FObjects();
         }
         return _controls;
      }
      
      //============================================================
      public function get hasControl():Boolean{
         return (null != _controls) ? !_controls.isEmpty() : false;
      }

      //============================================================
      public function get controlCount():uint {
         return (null != _controls) ? _controls.count : 0;
      }
      
      //============================================================
      public function control(index:uint):FControl {
         return (null != controls) ? _controls.get(index) as FControl : null;
      }
      
      //============================================================
      public function setPosition(x:Number, y:Number):void {
         position.set(x, y);
         if(null != display){
            display.x = x;
            display.y = y;
         }
      }
      
      //============================================================
      public function setScale(x:Number, y:Number):void {
         if(null != display){
            display.scaleX = x;
            display.scaleY = y;
         }
      }
      
      //============================================================
      public function setBounds(left:Number, top:Number, width:Number, height:Number):void {
         setPosition(left, top);
         size.set(width, height);
      }
      
      //============================================================
      public function get visible():Boolean {
         if(null != display){
            return display.visible;
         }
         return false;
      }
      
      //============================================================
      public function set visible(visible:Boolean):void {
         if(null != display){
            display.visible = visible;
         }
      }
      
      //============================================================
      public function fill(color:uint = 0xFFFFFF, alpha:Number = 1):void {
         //canvas.fillRectangle(0, 0, _width, _height, color, alpha);
      }
      
      //============================================================
      public override function loadConfig(config:FXmlNode):void {
         super.loadConfig(config);
         // 读取样式
         //_style.unpack(config.get(PropertyStyle));
      }
      
      //============================================================
      public override function saveConfig(config:FXmlNode):void {
         super.saveConfig(config);
         // 存储样式
         //config.set(PropertyStyle, _style.pack());
      }
      
      //============================================================
      public function setup():void {
      }
      
      //============================================================
      public function draw():void {
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         size = null;
         display = null;
         if(null != lsnsClick){
            lsnsClick.dispose();
            lsnsClick = null;
         }
         if(null != lsnsDblClick){
            lsnsDblClick.dispose();
            lsnsDblClick = null;
         }
         super.dispose();
      }
   }
}