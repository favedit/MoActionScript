package mo.cm.system
{
   import mo.cm.lang.FObject;

   //============================================================
   // <T>速度测试。</T>
   //============================================================
   public class FSpeed extends FObject
   {
      //============================================================
      // 开始日期
      public var startDate:Date; 
      
      //============================================================
      // 结束日期
      public var endDate:Date; 

      //============================================================
      // 备注信息
      public var note:String; 

      //============================================================
      // <T>创建实例对象。</T>
      //
      // @param note 备注
      // @return 实例对象
      //============================================================
      public function FSpeed(pnote:String=null){
         startDate = new Date();
         note = pnote;
      }

      //============================================================
      // <T>记录当前结果。</T>
      //============================================================
      public function record():void{
         endDate = new Date();
         var spend:int = endDate.getTime() - startDate.getTime();
         if(!note){
            note = "Speed";
         }
         trace("[" + note + "] spend " + spend + "ms.");
      }
   }
}