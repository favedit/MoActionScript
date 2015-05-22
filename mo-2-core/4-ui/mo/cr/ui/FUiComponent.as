package mo.cr.ui
{
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>界面组件。</T>
   //============================================================
   public class FUiComponent extends FObject
   {
      // 编号
      public var id:String;
      
      // 名称
      public var name:String;
      
      // 有效性
      public var isValid:Boolean = true;
      
      // 准备好
      public var isReady:Boolean;
      
      //============================================================
      // <T>构造界面组件。</T>
      //============================================================
      public function FUiComponent(){
      }
      
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      public function onSetup():void{
      }
      
      //============================================================
      // <T>处理环境。</T>
      //
      // @param p:context 环境
      //============================================================
      public function processContext(p:FUiContext):void{
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         id = p.get("id");
         name = p.get("name");
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         id = null;
         name = null;
         super.dispose();
      }
   }
}