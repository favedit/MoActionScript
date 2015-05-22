package mo.cr.console.sound
{
   import mo.cm.core.common.FConsole;
   
   //============================================================
   // <T>音效控制台。</T>
   //============================================================
   public class FCrSoundConsole extends FConsole
   {
      public var sounds:Vector.<FCrSound> = new Vector.<FCrSound>();
      
      //============================================================
      // <T>构造音效控制台。</T>
      //============================================================
      public function FCrSoundConsole(){
         name = "core.sound.console";
      }
   }
}