package mo.cm.console.resource
{
   import flash.utils.ByteArray;
   
   import mo.cm.console.loader.FLoaderEvent;
   
   //============================================================
   // <T>资源接口。</T>
   //============================================================
   public interface IResource
   {
      //============================================================
      // <T>加载资源数据。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      function load(pd:ByteArray, po:int = 0, pl:int = -1):void;
      
      //============================================================
      // <T>加载资源事件</T>
      //
      // @param p:event 加载事件
      //============================================================
      function loadContent(p:FLoaderEvent):void;
   }
}