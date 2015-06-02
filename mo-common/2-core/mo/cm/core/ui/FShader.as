package mo.cm.core.ui
{
   import flash.display.Graphics;
   import flash.display.Shader;
   
   import mo.cm.system.ILogger;
   import mo.cm.logger.RLogger;
   
   public class FShader extends Shader
   {
      private static var _logger:ILogger = RLogger.find(FShader);
      
      public var _name:String;

      public var _url:String;

      //============================================================
      public function FShader(){
      }

      //============================================================
      public function fillRect(graphics:Graphics, left:Number, top:Number, width:Number, height:Number):void{
         graphics.clear();
         graphics.beginShaderFill(this);
         graphics.drawRect(left, top, width, height);
         graphics.endFill();
      }
      
      //============================================================
      public function dump():void{
         for(var name:String in data){
            var param:* = data[name];
            _logger.debug("dump", "Param. (name={1}, param={2})", name, param);
            for(var pname:String in param){
               _logger.debug("dump", " => {1} = {2})", pname, param[pname]);
            }
         }
      }
   }
}