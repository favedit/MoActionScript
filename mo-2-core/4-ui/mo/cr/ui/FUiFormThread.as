package mo.cr.ui
{
   import mo.cm.console.thread.FThread;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   import mo.cr.ui.form.FUiForm;
   
   //============================================================
   // <T>界面处理线程。</T>
   //============================================================
   public class FUiFormThread extends FThread
   {
      // 日志
      public static var _logger:ILogger = RLogger.find(FUiFormThread);

      // 环境
      public var context:FUiContext = new FUiContext();
      
      // 表单集合
      public var forms:Vector.<FUiForm> = new Vector.<FUiForm>();
      
      //============================================================
      // <T>构造界面处理线程。</T>
      //
      // @return 执行结果
      //============================================================
      public function FUiFormThread(){
         name = "core.ui.form.thread";
      }
      
      //============================================================
      // <T>增加表单。</T>
      //
      // @param p:form 表单
      //============================================================
      public function push(p:FUiForm):void{
         if(null != p){
            if(-1 == forms.indexOf(p)){
               forms.push(p);
            }
         }
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return 执行结果
      //============================================================
      public override function execute():Boolean{
         var r:int = 0;
         var c:int = forms.length - 1;
         for(var n:int = 0; n < c; n++){
            var f:FUiForm = forms[n];
            if(f.isShow){
               if(RLogger.debugAble){
                  var ts:Number = new Date().time;
               }
               r++;
               f.process(context);
               if(RLogger.debugAble){
                  var te:Number = new Date().time;
                  var t:Number = te - ts;
                  if(t > 2){
                     _logger.debug("execute", "Execute form delay. (form={1}, child_count={2})", f.name, f.componentAllCount());
                     f.process(context);
                  }
               }
            }
         }
         return true;
      }
   }
}