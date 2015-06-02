package mo.cm.core.ui
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.FObjects;
   import mo.cm.system.RAllocator;
   import mo.cm.xml.FXmlNode;
   
   public class FComponent extends FObject
   {
      public var parent:FComponent;
      
      public var name:String;
      
      protected var _components:FObjects;
      
      //============================================================
      public function FComponent(pname:String=null) {
         name = pname;
      }
      
      //============================================================
      public function get components():FObjects {
         if (null == _components) {
            _components = RAllocator.create(FObjects);
         }
         return _components;
      }
      
      //============================================================
      public function componentCount():uint {
         return (null != _components) ? _components.count : 0;
      }
      
      //============================================================
      public function component(index:uint):FComponent {
         return (null != _components) ? _components.get(index) as FComponent : null;
      }
      
      //============================================================
      public function push(component:FComponent):void {
         components.push(component);
      }
      
      //============================================================
      public function loadConfig(config:FXmlNode):void {
         name = config.get("name");
      }
      
      //============================================================
      public function saveConfig(config:FXmlNode):void {
         config.set("name", name);
      }     
   }
}