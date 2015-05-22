package mo.cm.system
{
   import flash.display.Stage;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   import mo.cm.core.device.RScreen;
   
   //============================================================
   // <T>外部处理器。</T>
   //============================================================
   public class RExternal
   {
      // 是否可用
      public static var ready:Boolean;
      
      // 鼠标右击事件
      public static var lsnsRightClick:FListeners;
      
      // 窗口卸载事件
      public static var lsnsWindowUnload:FListeners;
      
      // 邀请好友成功事件
      public static var lsnsInviteSuccess:FListeners;
      
      //============================================================
      // <T>构造外部处理器。</T>
      //============================================================
      public function RExternal(){
      }
      
      //============================================================
      // <T>注册一个右键点击监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public static function registerRightClick(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsRightClick){
            lsnsRightClick = new FListeners();
         }
         return lsnsRightClick.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注销一个右键点击监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 监听器
      //============================================================
      public static function unregisterRightClick(pm:Function, po:Object = null, pc:int = -1):void{
         if(null != lsnsRightClick){
            lsnsRightClick.unregister(pm, po);
         }
      }
      
      
      //============================================================
      // <T>注册一个窗口卸载监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public static function registerWindowUnload(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsWindowUnload){
            lsnsWindowUnload = new FListeners();
         }
         return lsnsWindowUnload.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注销一个窗口卸载监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 监听器
      //============================================================
      public static function unregisterWindowUnload(pm:Function, po:Object = null, pc:int = -1):void{
         if(null != lsnsWindowUnload){
            lsnsWindowUnload.unregister(pm, po);
         }
      }
      
      //============================================================
      // <T>注册邀请成功监听。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public static function registerInviteSuccess(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(null == lsnsInviteSuccess){
            lsnsInviteSuccess = new FListeners();
         }
         return lsnsInviteSuccess.register(pm, po, pc);
      }
      
      //============================================================
      // <T>注销邀请成功监听。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 监听器
      //============================================================
      public static function unregisterInviteSuccess(pm:Function, po:Object = null, pc:int = -1):void{
         if(null != lsnsInviteSuccess){
            lsnsInviteSuccess.unregister(pm, po);
         }
      }

      //============================================================
      // <T>打开网络地址。</T>
      //
      // @param p:url 网络地址
      //============================================================
      public static function open(p:String):void{
         navigateToURL(new URLRequest(p), "_blank");
      }
      
      //============================================================
      // <T>调用外部函数。</T>
      //
      // @param pm:methos 函数名称
      // @param pp:params 参数集合
      //============================================================
      public static function invoke(pm:String, ... pp):void{
         if(ExternalInterface.available){
            ExternalInterface.call(pm, pp);
         }
      }
      
      //============================================================
      // <T>鼠标右击事件。</T>
      //============================================================
      public static function onRightClick():void{
         var s:Stage = RScreen.stage;
         if(null != s){
            var x:int = s.mouseX;
            var y:int = s.mouseY;
            if((x >= 0) && (x < s.stageWidth) && (y >= 0) && (y < s.stageHeight)){
               // 分发事件
               if(null != lsnsRightClick){
                  var e:FMouseEvent = new FMouseEvent();
                  e.isLeftButton = false;
                  e.isRightButton = true;
                  e.stageX = x;
                  e.stageY = y;
                  lsnsRightClick.process(e);
                  e.dispose();
               }
            }
         }
      }
      
      //============================================================
      // <T>窗口卸载事件。</T>
      //============================================================
      public static function onWindowUnload():void{
         if(null != lsnsWindowUnload){
            var e:FEvent = new FEvent();
            lsnsWindowUnload.process(e);
            e.dispose();
         }
      }
      
      //============================================================
      // <T>好友邀请成功事件。</T>
      //============================================================
      public static function onInviteSuccess():void{
         if(null != lsnsInviteSuccess){
            var e:FEvent = new FEvent();
            lsnsInviteSuccess.process(e);
            e.dispose();
         }
      }
      
      //============================================================
      // <T>处理过程。</T>
      //============================================================
      public static function process():void{
         if(!ready){
            if(ExternalInterface.available){
               if(null != ExternalInterface.objectID){
                  ExternalInterface.addCallback("onRightClick", onRightClick);
                  ExternalInterface.addCallback("onWindowUnload", onWindowUnload);
                  ExternalInterface.addCallback("onInviteSuccess", onInviteSuccess);
                  ready = true;
               }
            }
         }
      }
   }
}