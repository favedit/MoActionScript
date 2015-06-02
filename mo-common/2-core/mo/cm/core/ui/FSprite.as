package mo.cm.core.ui
{
   import flash.display.Sprite;
   
   import mo.cm.geom.SIntPoint2;
   import mo.cm.geom.SIntSize2;
   import mo.cm.lang.IObject;
   import mo.cm.lang.RObject;
   import mo.cm.reflection.RType;
   
   //============================================================
   // <T>绘制精灵。</T>
   //============================================================
   public class FSprite extends Sprite implements IObject
   {
      // 是否已经释放
      public var disposed:Boolean;
      
      // 唯一哈希标识
      public var hashCode:int = RObject.next();
      
      // 位置
      public var location:SIntPoint2 = new SIntPoint2();

      // 大小
      public var size:SIntSize2 = new SIntSize2();
      
      // 附加数据
      public var tag:Object;
      
      //============================================================
      // <T>构造绘制精灵。</T>
      //============================================================
      public function FSprite(){
         tag = this;
      }
      
      //============================================================
      // <T>构造资源。</T>
      //============================================================
      public function construct():void{
      }
      
      //============================================================
      // <T>设置坐标。</T>
      //
      // @param px:x 横坐标
      // @param py:y 纵坐标
      //============================================================
      public function setPosition(px:Number, py:Number):void{
         if(location.x != px){
            location.x = px;
            x = px;
         }
         if(location.y != py){
            location.y = py;
            y = py;
         }
      }
      
      //============================================================
      // <T>清楚显示数据。</T>
      //
      // @author HECNG 20120227
      //============================================================
      public function clear():void{
         graphics.clear();
         while(numChildren > 0){
           removeChildAt(0);
         }
      }

      //============================================================
      // <T>设置大小。</T>
      //
      // @param pw:width 横坐标
      // @param ph:height 纵坐标
      //============================================================
      public function setSize(pw:Number, ph:Number):void{
         width = pw;
         height = ph;
      }
      
      //============================================================
      // <T>获得运行大小。</T>
      //
      // @return 运行大小
      //============================================================
      public function get runtimeSize():int{
         return RType.calculateSize(this);
      }
      
      //============================================================
      // <T>获得运行总大小。</T>
      //
      // @return 运行总大小
      //============================================================
      public function get runtimeTotal():int{
         return RType.calculateTotal(this);
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public function dispose():void{
         disposed = true;
         clear();
         tag = null;
      }
   }
}