package mo.cr.ui
{
   import flash.utils.getQualifiedClassName;
   
   import mo.cm.lang.FObject;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>界面组件。</T>
   //============================================================
   public class FUiComponent3d extends FObject
   {
      // 唯一编号
      public var id:uint;
      
      // 名称
      public var name:String;
      
      // 类型
      public var type:String;
      
      // 设置过
      public var setuped:Boolean;
      
      // 可用性
      public var ready:Boolean;
      
      // 有效性
      public var valid:Boolean = true;
      
      // 父组件
      public var parent:FUiComponent3d;
      
      // 子组件集合
      public var components:Vector.<FUiComponent3d>;
      
      //============================================================
      // <T>构造界面组件。</T>
      //============================================================
      public function FUiComponent3d(){
      }
      
      //============================================================
      // <T>查找父组件。</T>
      //
      // @param p:class 组件类
      //============================================================
      public function findParent(p:Class):*{
         var c:FUiComponent3d = parent;
         while(c){
            if(c is p){
               return c;
            }
            c = c.parent;
         }
         return null;
      }
      
      //============================================================
      // <T>处理自己所有的子控件个数。</T>
      //
      // @return 子控件个数
      //============================================================
      public function componentAllCount():int{
         var r:int = 0;
         if(null != components){
            var c:int = components.length;
            r += c;
            for(var n:int = 0; n < c; n++){
               r += components[n].componentAllCount();
            }
         }
         return r;
      }
      
      //============================================================
      // <T>增加一个组件。</T>
      //
      // @param p:component 组件
      //============================================================
      public function push(p:FUiComponent3d):void{
         p.parent = this;
         if(!components){
            components = new Vector.<FUiComponent3d>();
         }
         components.push(p);
      }
      
      //============================================================
      // <T>删除一个组件。</T>
      //
      // @param p:component 组件
      //============================================================
      public function remove(p:FUiComponent3d):void{
         var index:int = components.indexOf(p);
         if(index != -1){
            components.splice(index, 1);
         }
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function loadConfig(p:FXmlNode):void{
         id = p.getInt("id");
         name = p.get("name");
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public function saveConfig(p:FXmlNode):void{
         p.set("id", id.toString());
         p.set("name", name);
      }
      
      //============================================================
      // <T>开始设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public function setupBegin(p:FUiContext):void{
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public function setupEnd(p:FUiContext = null):void{
      }
      
      //============================================================
      // <T>处理自己所有的子控件集合。</T>
      //
      // @param p:context 环境
      //============================================================
      public function processComponents(p:FUiContext):void{
         if(null != components){
            var c:int = components.length;
            for(var n:int = 0; n < c; n++){
               components[n].process(p);
            }
         }
      }
      
      //============================================================
      // <T>执行处理过程。</T>
      //
      // @param p:context 环境
      //============================================================
      public function process(p:FUiContext):void{
         // 设置处理
         if(!setuped){
            setupBegin(p);
         }
         // 所有子组件集合处理
         if(components){
            var c:int = components.length;
            for(var n:int = 0; n < c; n ++){
               components[n].process(p);
            }
         }
         // 设置处理
         if(!setuped){
            setupEnd(p);
            setuped = true;
         }
      }
      
      //============================================================
      // <T>接收对象信息。</T>
      //
      // @param p:* 接收对象
      //============================================================
      public function assign(p:*):void{
         var s:FUiComponent3d = p;
         id = s.id;
         name = s.name;
         type = s.type;
         setuped = s.setuped;
         ready = s.ready;
         valid = s.valid;
         parent = s.parent;
      }
      
      //============================================================
      // <T>克隆当前对象。</T>
      //============================================================
      public function clone():*{
         // 获取当前类完全类名
         var cn:String = getQualifiedClassName(this);
         // 获取当前类定义
         var t:Class = getQualifiedClassName(cn) as Class;
         var r:FUiComponent3d = new t();
         r.assign(this);
         // 复制自己的子对象
         if(null != components){
            var c:int = components.length;
            for(var n:int = 0; n < c; n++){
               var m:FUiComponent3d = components[n];
               if(null != m){
                  var rm:FUiComponent3d = m.clone();
                  r.push(rm);
               }
            }
         }
         return r;
      }
      
      //============================================================
      // <T>释放对象。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         parent = null;
      }
   }
}