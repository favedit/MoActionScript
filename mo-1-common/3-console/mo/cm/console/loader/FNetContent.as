package mo.cm.console.loader
{
   import mo.cm.lang.FObject;
   import mo.cm.system.FListener;
   import mo.cm.system.FListeners;
   
   //============================================================
   // <T>数据内容加载器。</T>
   //============================================================
   public class FNetContent extends FObject
   {
      // 网络地址
      public var url:String;
      
      // 是否有效
      public var valid:Boolean = true;

      // 是否就绪
      public var ready:Boolean;

      // 优先权重 (值越大越先被加载)
      public var priority:int;
      
      // 超时次数
      public var timeoutCount:int;

      // 完成监听器
      public var lsnsComplete:FListeners;
      
      //============================================================
      // <T>构造数据内容加载器。</T>
      //============================================================
      public function FNetContent(){
      }
      
      //============================================================
      // <T>注册完成监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      //============================================================
      public function registerComplete(pm:Function, po:Object = null, pc:int = -1):FListener{
         if(!lsnsComplete){
            lsnsComplete = new FListeners(this);
         }
         return lsnsComplete.register(pm, po, pc);
      }
      
      //============================================================
      // <T>获取加载进度。</T>
      //============================================================
      public function get processRate():Number{
         return 0;
      }
      
      //============================================================
      // <T>加载中处理。</T>
      //
      // @param p:loader 加载器
      //============================================================
      public function loadProgress(p:FNetLoader):void{
      }
      
      //============================================================
      // <T>加载完成。</T>
      //
      // @param p:loader 加载器
      //============================================================
      public function loadComplete(p:FNetLoader):void{
         ready = true;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         url = null;
         if(lsnsComplete){
            lsnsComplete.dispose();
            lsnsComplete = null;
         }
      }
   }
}