package mo.cr.ui
{
   import flash.display.DisplayObject;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.system.FListeners;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   //============================================================
   // <T>可视控件。</T>
   //============================================================
   public class FUiControl3d extends FUiComponent3d
   {
      // 标签
      public var label:String;
      
      // 数据脏
      public var dirty:Boolean;
      
      // 可见性
      public var visible:Boolean = true;
      
      // 位置
      public var location:SIntPoint2 = new SIntPoint2();
      
      // 大小
      public var size:SIntSize2 = new SIntSize2();
      
      // 显示对象
      public var display:DisplayObject;
      
      // 子控件集合
      public var controls:Vector.<FUiControl3d> = new Vector.<FUiControl3d>();

      // 点击监听
      public var lsnClick:FListeners = RAllocator.create(FListeners);
      
      // 显示顺序
      public var displayOrder:int;
      
      // 是否显示在显示列表
      public var isShow:Boolean = false;
      
      // 文本描述
      public var hite:String = "";
      
      // 是否显示提示文本
      public var isHite:Boolean = false;
      
      // 保存文件名称
      public var fileName:String = "";
      
      // 数据
      public var tag:*;
      
      //============================================================
      // <T>构造可视控件。</T>
      //============================================================
      public function FUiControl3d(){
      }
      
      //============================================================
      // <T>初始化组件。</T>
      //============================================================
      public function setup():void{
      }
      
      //============================================================
      // <T>设置显示位置。</T>
      //
      // @param px:x 横坐标
      // @param py:y 纵坐标
      //============================================================
      public function setLocation(px:int, py:int):void{
         display.x = px;
         display.y = py;
         location.set(px, py);
      }
      
      //============================================================
      // <T>设置显示大小。</T>
      //
      // @param pw:width 横坐标
      // @param ph:height 纵坐标
      //============================================================
      public function setSize(pw:Number, ph:Number):void{
         size.set(pw, ph);
      }
      
      //============================================================
      // <T>增加一个组件。</T>
      //
      // @param p:component 组件
      //============================================================
      public override function push(p:FUiComponent3d):void{
         super.push(p);
         // 增加控件
         if(p is FUiControl3d){
            if(!controls){
               controls = new Vector.<FUiControl3d>();
            }
            controls.push(p);
         }
      }
      
      //============================================================
      // <T>删除一个组件。</T>
      //
      // @param p:component 组件
      //============================================================
      public override function remove(p:FUiComponent3d):void{
         super.remove(p)
         if(p is FUiControl3d){
            var index:int = controls.indexOf(p);
            if(index != -1){
               controls.splice(index, 1);
            }
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
      // <T>绘制显示内容。</T>
      //
      // @param p:context 环境
      //============================================================
      public function paint(p:FUiContext = null):void{
      }
      
      //============================================================
      // <T>绘制显示内容。</T>
      //
      // @param p:context 环境
      //============================================================
      public function update(p:FUiContext):void{
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         fileName = p.get("file_name");
         label = p.get("label");
         size.parse(p.get("size"));
         location.parse(p.get("location"));
         tag = p.get("tag");
         isHite = p.getBoolean("ishite");
         setLocation(location.x, location.y);
         hite = p.get("hite");
      }
      
      //============================================================
      // <T>保存设置信息。</T>
      //
      // @param p:config 设置信息
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("label", label);
         p.set("size", size.toString());
         p.set("location", location.toString());
         p.set("tag", tag);
         p.set("ishite", isHite.toString());
         p.set("hite", hite);
         p.set("file_name", fileName);
      }
      
      //============================================================
      // <T>处理自己所有的子控件集合。</T>
      //
      // @param p:context 环境
      //============================================================
      public function processControls(p:FUiContext):void{
         if(null != controls){
            var c:int = controls.length;
            for(var n:int = 0; n < c; n++){
               controls[n].process(p);
            }
         }
      }
      
      //============================================================
      // <T>执行处理过程。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function process(p:FUiContext):void{
         super.process(p);
         if(!ready){
            ready = testReady();
         }
         if(ready && dirty){
            paint(p);
            //dirty = false;
         }
         if(ready && !dirty){
            update(p);
         }
      }
      
      //============================================================
      // <T>设置是否显示。</T>
      //
      // @param p:context 环境
      //============================================================
      public function setVisable(bool:Boolean):void{
         visible = bool;
         display.visible = visible;
      }
      
      //==========================================================
      // <T> </T>
      //
      // @author HECNG 20120427
      //==========================================================
      public function mouseEnable(bool:Boolean):void{
      }
      
      //============================================================
      // <T>执行处理过程。</T>
      //
      // @param p:context 环境
      //============================================================
      public function clear():void{
      }
      
      //============================================================
      // <T>移除操作。</T>
      //
      // @param p:context 环境
      //============================================================
      public function removeDisplay():void{
         if(display.parent){
            display.parent.removeChild(display);
         }
      }
      
      //============================================================
      // <T>释放对象。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
//         location = null;
//         size = null;
         display = null;
         lsnClick.clear();
         lsnClick = null;
      }
   }
}