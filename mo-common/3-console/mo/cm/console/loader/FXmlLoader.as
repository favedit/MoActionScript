package mo.cm.console.loader
{
   import flash.events.Event;
   import flash.utils.ByteArray;
   
   import mo.cm.logger.RLogger;
   import mo.cm.system.ILogger;
   import mo.cm.xml.FXmlDocument;
   
   //============================================================
   // <T>设置数据加载器。</T>
   //============================================================
   public class FXmlLoader extends FUrlLoader
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FXmlLoader);
      
      //============================================================
      // <T>构造设置数据加载器。</T>
      //============================================================
      public function FXmlLoader(){
      }
      
      //============================================================
      // <T>内容加载完成事件。</T>
      //
      // @param e:event 事件
      //============================================================
      public override function onContentComplete(e:Event):void{
         _logger.debug("onContentComplete", "Load content complete. (url={1})", uri);
         // 加载配置信息
         isOpen = false;
         loading = false;
         var d:ByteArray = loader.data;
         var xd:FXmlDocument = new FXmlDocument();
         xd.loadXml(d.toString());
         var le:FLoaderEvent = new FLoaderEvent();
         le.loader = this;
         le.sender = this;
         le.data = d;
         le.content = xd;
         if(onComplete(le)){
            lsnsComplete.process(le);
         }
         d.clear();
         loader.data = null;
         loader.close();
         le.dispose();
      }
   }
}