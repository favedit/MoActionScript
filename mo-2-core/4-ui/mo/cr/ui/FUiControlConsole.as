package mo.cr.ui
{
   import mo.cm.console.RCmConsole;
   import mo.cm.core.common.FConsole;
   import mo.cm.core.device.RScreen;
   import mo.cm.lang.FDictionary;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.control.FUiPanel;
   import mo.cr.ui.form.FUiBar;
   import mo.cr.ui.form.FUiForm;
   import mo.cr.ui.form.FUiWindow;

   //============================================================
   // <T>控件控制台。</T>
   //============================================================
   public class FUiControlConsole extends FConsole
   {
      public var templates:FDictionary = new FDictionary();
      
      public var forms:FDictionary = new FDictionary();

      public var thread:FUiFormThread = new FUiFormThread();
      
      //============================================================
      // <T>构造控件控制台。</T>
      //============================================================
      public function FUiControlConsole(){
         name = "core.ui.console";
      }
      
      //============================================================
      // <T>隐藏显示表单。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function visableForm(bool:Boolean, name:String = ""):void{
         var c:int = forms.count;
         for(var n:int = 0; n < c; n++ ){
            var v:FUiControl3d = forms.values[n] as FUiControl3d;
//            var names:String = name;
//            names = names == "" ? "teaching.movie.window" : name;
            if(v.name != "teaching.movie.window"){
               v.setVisable(bool);
            }
         }
      }
      
      //============================================================
      // <T>创建一个预先定义的表单。</T>
      //
      // @param p:name 名称
      // @return 表单
      //============================================================
      public function createPanel(p:String):FUiPanel{
         var x:FXmlNode = templates.get(p);
         var r:FUiPanel = new FUiPanel();
         r.loadConfig(x);
         return r;
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         // 启动线程
         RCmConsole.threadConsole.start(thread);
         // 加载列表
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            var xn:String = x.get("name");
            if(x.isName("Form")){
               var f:FUiForm = new FUiForm();
               f.loadConfig(x);
               addForm(f);
            }else if(x.isName("Bar")){
               var bar:FUiBar = new FUiBar();
               bar.loadConfig(x);
               addForm(bar);
            }else if(x.isName("Window")){
               var window:FUiWindow = new FUiWindow();
               window.loadConfig(x);
               addForm(window);
            }else if(x.isName("Panel")){
               templates.set(xn, x);
            }
         }
      }
      
      //============================================================
      // <T>添加表单</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function addForm(f:FUiForm):void{
         forms.set(f.name, f);
         thread.push(f);
      }
      
      //============================================================
      // <T>对ui进行排序。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function sortForm():void{
        var l:int = thread.forms.length;
        var arr:Array = [];
        for(var i:int = 0; i < l; i ++){
           var fui:FUiForm = thread.forms[i] as FUiForm;
           if(fui.isOrder){
              if(fui.display.stage){
                 RScreen.stage.removeChild(fui.display);
              }
           }
           arr.push(fui); 
        }
        arr.sort(checkIndex);
        l = arr.length;
        for(i = 0; i < l; i++){
           var form:FUiForm = arr[i] as FUiForm;
           if(form.isOrder){
              if(form.isShow){
                 RScreen.stage.addChild(form.display);
                 form.visible = true;
              }
           }
        }
      }
      
      //============================================================
      // <T>检查排序。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function checkIndex(a:FUiForm, b:FUiForm):Number{
         if(a.displayOrder > b.displayOrder){
            return 1;
         }else if(a.displayOrder < b.displayOrder){
            return -1;
         }else{
            return 0;
         }
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function createByNode(p:FXmlNode):FUiForm{
         var f:FUiForm = new FUiForm();
         f.loadConfig(p);
         forms.set(f.name, f);
         thread.push(f);
         return f;
      }
      
      //============================================================
      public function get(name:String):FUiForm{
         return forms.get(name);
      }
   }
}