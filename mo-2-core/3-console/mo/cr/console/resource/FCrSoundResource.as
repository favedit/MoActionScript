package mo.cr.console.resource
{
   import flash.utils.ByteArray;
   
   import mo.cm.console.loader.ELoader;
   import mo.cm.console.resource.FResource;
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>音效资源。</T>
   //============================================================
   public class FCrSoundResource extends FResource
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FCrSoundResource);
      
      // 数据
      public var data:ByteArray;
      
      //============================================================
      // <T>构造音效资源。</T>
      //============================================================
      public function FCrSoundResource(){
         loaderCd = ELoader.Data;
      }
      
      //============================================================
      // <T>加载事件处理。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public override function onLoaded(pd:ByteArray, po:int, pl:int):void{
         data = new ByteArray();
         data.writeBytes(pd, po, pl); 
      }
   }
}