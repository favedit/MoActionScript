package mo.cr.console.resource
{
   //============================================================
   // <T>基础资源接口。</T>
   //============================================================
   public interface ICrResource
   {
      // 加载资源内容
      function onLoadContent(p:*):void;

      // 资源处理
      function process():Boolean;
   }
}