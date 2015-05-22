package mo.cr.ui.control
{
   import flash.display.Sprite;
   
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.system.FEvent;
   import mo.cm.system.FListeners;
   import mo.cm.xml.FXmlNode;
   import mo.cr.ui.FUiComponent3d;
   import mo.cr.ui.FUiContainer3d;
   import mo.cr.ui.FUiContext;
   import mo.cr.ui.FUiControl3d;
   import mo.cr.ui.form.FUiForm;
   
   //==========================================================
   // <T> 分页控件</T>
   //
   // @author HECNG 20120314
   //==========================================================
   public class FUiPageControl extends FUiContainer3d
   {
      public static const UP:String = "up";
      
      public static const DOWN:String = "down";
      
      public static const RIGHT:String = "right";
      
      public static const LEFT:String = "left";
      
      public var buttons:Vector.<FUiPageButton> = new Vector.<FUiPageButton>();
      
      public var pages:Vector.<FUiPage> = new Vector.<FUiPage>();
      
      public var containerDisplay:FSprite = new FSprite();
      
      // 按钮拜访位置 上，下，左，右
      public var station:String = UP;
      
      // 第一个按钮的位置
      public var groundLoaction:SIntPoint2 = new SIntPoint2();
      
      // 按钮间隔
      public var space:int = 0;
      
      // 页面按钮切换事件
      public static var pageButtonListener:FListeners = new FListeners();
      
      // 按钮宽高
      public var buttonSize:SIntSize2 = new SIntSize2();
      
      // 切换事件
      public var changeName:String;
      
      public var context:FUiContext;
      
      //============================================================
      // <T>构造函数。</T>
      //
      // @author HECNG 20120314
      //============================================================
      public function FUiPageControl(){
         type = EUiControlType.PageControl;
         display = containerDisplay;
         containerDisplay.tag = this;
         controls = new Vector.<FUiControl3d>();
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120314
      //============================================================
      public override function loadConfig(p:FXmlNode):void{
         super.loadConfig(p);
         groundLoaction.parse(p.get("button_location"));
         space = p.getInt("space");
         station = p.get("station");
         buttonSize.parse(p.get("button_size"));
         changeName = p.get("onchange");
         var c:int = p.nodeCount;
         for(var n:int = 0; n < c; n++){
            var x:FXmlNode = p.node(n);
            if(x.name == "Page"){
               var page:FUiPage = new FUiPage();
               page.loadConfig(x);
               addPage(page);
            }
         }
         setChildPostion();
         setup();
         ready = true;
      }
      
      //============================================================
      // <T>增加页</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120314
      //============================================================
      public function addPage(p:FUiPage):void{
         var button:FUiPageButton = new FUiPageButton();
         button.size.set(buttonSize.width, buttonSize.height);
         buttons.push(button);
         pages.push(p);
         containerDisplay.addChild(p.display);
         containerDisplay.addChild(button);
         p.display.visible = p.defaultVisable;
         button.pageName = p.name;
         p.setButton(button);
         push(p); 
         setChildPostion();
      }
      
      //============================================================
      // <T>加载设置信息。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120314
      //============================================================
      public override function saveConfig(p:FXmlNode):void{
         super.saveConfig(p);
         p.set("button_location", groundLoaction.toString());
         p.set("space", space.toString());
         p.set("station", station);
         p.set("button_size", buttonSize.toString());
         p.set("onchange", changeName);
         var length:int = pages.length;
         for(var n:int = 0; n < length; n++){
            var xb:FXmlNode = p.create("Page");
            pages[n].saveConfig(xb);
         }
      }
      
      //============================================================
      // <T>通过名称查找相关的页面信息。</T>
      //
      // @param name:String 页面名称
      // @author HECNG 20120314
      //============================================================
      public function findPageByName(name:String):FUiPage{
         var page:FUiPage = null;
         for each(var n:FUiComponent3d in controls){
            if(n.name == name){
               page = n as FUiPage;
            }
         }
         return page;
      }
      
      //============================================================
      // <T>设置页面和切换按钮坐标。</T>
      //
      // @param p:config 设置信息
      // @author HECNG 20120314
      //============================================================
      public function setChildPostion():void{
         switch(station){
            case UP:
            case DOWN:
               setButton(UP);
               break;
            case LEFT:
            case RIGHT:
               setButton(LEFT);
               break;
         }
      }
      
      //============================================================
      // <T>设置按钮坐标。</T>
      //
      // @param direction:String 按钮方位
      // @author HECNG 20120314
      //============================================================
      public function setButton(direction:String):void{
         var length:int = buttons.length;
         for(var n:int = 0; n < length; n++){
            if(direction == UP){
               buttons[n].x = groundLoaction.x + (buttonSize.width + space) * n;
               buttons[n].y = groundLoaction.y;
            }else{
               buttons[n].x = groundLoaction.x;
               buttons[n].y = groundLoaction.y + (buttonSize.height+space) * n;
            }
         }
      }
      
      //============================================================
      // <T>初始化组件。</T>
      //
      // @author HECNG 20120314
      //============================================================
      public override function setup():void{
         pageButtonListener.register(changePage, this);
      }
      
      //============================================================
      // <T>页面切换。</T>
      //
      // @author HECNG 20120314
      //============================================================
      public function changePage(f:FEvent):void{
         var name:String = f.senderName;
         visablePage(name);
         if(changeName){
            paint(context);
            var form:FUiForm = this.findParent(FUiForm);
            var d:Object = form.eventDispatcher;
            if(d){
               var m:Function = d[changeName];
               m.call(d, f); 
            } 
         }
      }
      
      //============================================================
      // <T>显示当前面板。</T>
      //
      // @param name:String 当前面板名称
      // @author HECNG 20120314
      //============================================================
      public function visablePage(name:String):void{
         for each(var n:FUiPage in pages){
            if(n.name == name){
               n.setVisable(true);
               n.isSelect = true;
            }else{
               n.setVisable(false); 
               n.isSelect = false;
            }
         }
      } 
      
      //============================================================
      // <T>绘制图形</T>
      //
      // @author HECNG 20120314
      //============================================================
      public override function paint(p:FUiContext = null):void{
         if(ready){
            for each(var n:FUiPage in controls){
               n.paint();
            }
            setChildPostion();
         }
      }
      
      //============================================================
      // <T>结束设置界面组件。</T>
      //
      // @param p:context 环境
      //============================================================
      public override function setupEnd(p:FUiContext = null):void{
         ready = true;
         paint();
      }
      
      //============================================================
      // <T>查看当前的显示元素是否加载完成</T>
      //
      // @author HECNG 20120314
      //============================================================
      public override function process(p:FUiContext):void{
         for each(var n:FUiPage in pages){
            n.process(p);
         }
         if(ready && !dirty){
            paint(p);
            dirty = true;
         }
      }
   }
}