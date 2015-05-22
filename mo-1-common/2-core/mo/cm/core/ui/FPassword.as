package mo.cm.core.ui
{
   public class FPassword extends FEdit
   {
      //============================================================
      public function FPassword(name:String=null, label:String=null){
         super(name, label);
      }
      
      //============================================================
      public override function setLabel(label:String = null):void{
         super.setLabel(label);
         _editFormat = RStyle.PasswordFormat;
         _edit.displayAsPassword = true;
      }
   }
}