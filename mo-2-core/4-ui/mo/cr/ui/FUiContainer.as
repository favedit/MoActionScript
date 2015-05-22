package mo.cr.ui
{
   import mo.cm.core.ui.FSprite;
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.FObject;
   import mo.cm.system.RAllocator;
   
   public class FUiContainer extends FObject
   {
      protected var _visible:Boolean;
      
      public var id:uint;
      
      public var name:String;
      
      public var label:String;
      
      public var sprite:FSprite = RAllocator.create(FSprite);

	   public var size:SIntSize2 = new SIntSize2();

      public var location:SIntPoint2 = new SIntPoint2();
      
      //============================================================
      public function FUiContainer(){
      }
      
      //============================================================
      public function set visible(value:Boolean):void{
         _visible = value;
         sprite.visible = value;
      }
      
      //============================================================
      public function get visible():Boolean{
         return sprite.visible;
      }
      
      //============================================================
      public function setup():void{
      }
      
      //============================================================
      public function unload():void{
      }
      
      //============================================================
      public function update():void{
      }
   }
}