package mo.cr.ui
{
   import flash.display.DisplayObject;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>基础可视控件。</T>
   //============================================================
   public class FUiControl extends FUiComponent
   {
      // 标签
      public var label:String;
      
      // 是否脏
      public var isDirty:Boolean = true;
      
      // 是否绘制
      public var isDrawed:Boolean;
      
      // 位置
      public var location:SIntPoint2 = new SIntPoint2();
      
      // 大小
      public var size:SIntSize2 = new SIntSize2();

      // 显示对象
      public var display:DisplayObject;
      
      // 鼠标点击
      public var lsnsClick:FListeners;
      
      // 鼠标双击
      public var lsnsDblClick:FListeners;
      
      //============================================================
      // <T>构造可视控件。</T>
      //============================================================
      public function FUiControl(){
      }
      
      //============================================================
      // <T>获得可见性。</T>
      //
      // @return 可见性
      //============================================================
      public function get visible():Boolean{
         return display.visible;
      }
      
      //============================================================
      // <T>设置可见性。</T>
      //
      // @param p:value 可见性
      //============================================================
      public function set visible(p:Boolean):void{
         display.visible = p;
      }
      
      //============================================================
      // <T>设置显示位置。</T>
      //============================================================
      public function setLocation(x:int, y:int):void{
         display.x = x;
         display.y = y;
         location.set(x, y);;
      }
      
      //============================================================
      // <T>设置显示大小。</T>
      //============================================================
      public function setSize(w:Number, h:Number):void{
         size.width = w;
         size.height = h;
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
      // <T>注销一个点击监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 监听器
      //============================================================
      public function unregisterClick(pm:Function, po:Object = null, pc:int = -1):void{
         if(null != lsnsClick){
            lsnsClick.unregister(pm, po);
         }
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
      // <T>注销一个双击监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 监听器
      //============================================================
      public function unregisterDblClick(pm:Function, po:Object = null, pc:int = -1):void{
         if(null != lsnsDblClick){
            lsnsDblClick.unregister(pm, po);
         }
      }
      
      //============================================================
      // <T>测试是否准备好。</T>
      //
      // @return 是否准备好
      //============================================================
      public function testReady():Boolean{
         return true;
      }
      
      //============================================================
      // <T>绘制处理。</T>
      //============================================================
      public function onPaint():void{
      }
      
      //============================================================
      // <T>更新处理。</T>
      //============================================================
      public function onUpdate():void{
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         label = p.get("label");
         size.parse(p.get("size"));
         location.parse(p.get("location"));
         setLocation(location.x, location.y);
      }
      
      //============================================================
      // <T>循环处理过程。</T>
      //============================================================
      public function process():void{
         if(!isReady){
            isReady = testReady();
         }
         if(isReady && isDirty){
            onPaint();
            isDirty = false;
         }
         if(isReady && !isDirty){
            onUpdate();
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         label = null;
         size = null;
         location = null;
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