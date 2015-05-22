package mo.cr.way
{
   import mo.cm.geom.SIntPoint2;
   import mo.cm.lang.FObject;
   
   //============================================================
   // <T>道路节点。</T>
   //
   // @author HECNG 20120416
   //============================================================
   public class FWayNode extends FObject
   {
      // 绑定类
      public var vender:IWayVender;
      
      // 是否阻碍
      public var blocked:Boolean;
      
      // 父节点
      public var parent:FWayNode;
      
      // 检查类别
      public var checkStatus:int;
      
      // 索引
      public var index:SIntPoint2 = new SIntPoint2();
      
      // 方向
      public var drection:String;
      
      // G和H的和
      public var F:int = 0;
      
      // 移动代价
      public var G:int = 0;
      
      // 估算成本
      public var H:int = 0;
      
      //============================================================
      // <T>构造道路节点。</T>
      //
      // @author HECNG 20120416
      //============================================================
      public function FWayNode(){
      }
      
      //============================================================
      // <T>更新信息。</T>
      //
      // @author HECNG 20120416
      //============================================================
      public function update():void{
         blocked = vender.isBlock();
      }
   }
}