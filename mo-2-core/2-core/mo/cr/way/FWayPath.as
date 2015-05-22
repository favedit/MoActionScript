package mo.cr.way
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>寻路路线。</T>
   //
   // @author HECNG 20120416
   //============================================================
   public class FWayPath extends FObject
   {
      // 节点集合
      public var nodes:Vector.<IWayVender> = new Vector.<IWayVender>();
      
      //============================================================
      // <T>构造寻路路线。</T>
      //============================================================
      public function FWayPath(){
      }

      //============================================================
      // <T>重置数据。</T>
      //============================================================
      public function reset():void{
		  nodes.length = 0;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(nodes){
            var c:int = nodes.length;
            for(var n:int = 0; n < c; n++){
               nodes[n] = null;
            }
            nodes.length = 0;
            nodes = null;
         }
         super.dispose();
      }
   }
}