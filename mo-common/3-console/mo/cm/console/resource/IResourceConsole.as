package mo.cm.console.resource
{
   public interface IResourceConsole
   {
      //============================================================
      // <T>设置处理。</T>
      //============================================================
      function setup():void;
      
      //============================================================
      // <T>获得资源信息。</T>
      //
      // @return 资源信息
      //============================================================
      function updateInfo():SResourceInfo;
      
      //============================================================
      // <T>同步一个资源域。</T>
      //
      // @param p:name 名称
      // @return 资源域
      //============================================================
      function findDomain(p:String):FResourceDomain;
      
      //============================================================
      // <T>同步一个资源域。</T>
      //
      // @param p:name 名称
      // @return 资源域
      //============================================================
      function syncDomain(p:String):FResourceDomain;
      
      //============================================================
      // <T>查找一个资源组。</T>
      //
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源组
      //============================================================
      function findGroup(pc:String, pd:String):FResourceGroup;
      
      //============================================================
      // <T>同步一个资源组。</T>
      //
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源组
      //============================================================
      function syncGroup(pc:String, pd:String):FResourceGroup;
      
      //============================================================
      // <T>同步一个资源组。</T>
      //
      // @param pi:id 编号
      // @param pd:domainName 主域名称
      // @return 资源组
      //============================================================
      function syncGroupById(pi:int, pd:String):FResourceGroup;
      
      //============================================================
      // <T>放入一个资源组到资源池。</T>
      //
      // @param pr:resourceGroup 资源组
      // @param pc:code 代码
      //============================================================
      function pushGroup(pg:FResourceGroup, pc:String = null):void;
      
      //============================================================
      // <T>查找一个资源。</T>
      //
      // @param pt:typeName 类型名称
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源
      //============================================================
      function findResource(pt:String, pc:String, pd:String):*;
      
      //============================================================
      // <T>同步一个资源。</T>
      //
      // @param pt:typeName 类型名称
      // @param pc:code 代码
      // @param pd:domainName 主域名称
      // @return 资源
      //============================================================
      function syncResource(pt:String, pc:String, pd:String):*;
      
      //============================================================
      // <T>同步一个资源。</T>
      //
      // @param pt:typeName 类型名称
      // @param pi:id 编号
      // @param pd:domainName 主域名称
      // @return 资源域
      //============================================================
      function syncById(pt:String, pi:int, pd:String):*;
      
      //============================================================
      // <T>同步一个图片资源。</T>
      //
      // @param pi:id 编号
      // @return 资源域
      //============================================================
      function syncPictureById(pi:int):*;
      
      //============================================================
      // <T>同步一个内容。</T>
      //
      // @param p:url 内容
      // @return 内容
      //============================================================
      function syncContent(p:String):FContent;
      
      //============================================================
      // <T>放入一个资源到资源池。</T>
      //
      // @param pr:resource 资源
      // @param pc:code 代码
      //============================================================
      function pushResource(pr:FResource, pc:String = null):void;
      
      //============================================================
      // <T>增加一个加载资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      function pushLoading(p:FResource):void;
      
      //============================================================
      // <T>增加一个处理资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      function pushProcess(p:FResource):void;
      
      //============================================================
      // <T>输出调试信息。</T>
      //============================================================
      function dump():void;
   }
}