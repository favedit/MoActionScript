package mo.cm.core.device
{
   import mo.cm.system.FFatalError;
   import mo.cm.system.FFatalUnsupportError;

   //============================================================
   // <T>工厂对象。</T>
   //============================================================
   public class RFatal
   {
      //============================================================
      // <T>构造工厂对象。</T>
      //============================================================
      public function RFatal(){
      }
      
      //============================================================
      // <T>抛出例外。</T>
      //
      // @param p:message 消息
      //============================================================
      public static function throwFatal(p:String, ...rest):void{
         if(!RGlobal.isRelease){
            throw new FFatalError(p, rest);
         }
      }

      //============================================================
      // <T>抛出例外。</T>
      //============================================================
      public static function throwUnsupport():void{
         if(!RGlobal.isRelease){
            throw new FFatalUnsupportError();
         }
      }
   }
}