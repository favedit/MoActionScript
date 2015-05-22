package mo.cm.console.resource
{
   import mo.cm.lang.FDictionary;
   import mo.cm.lang.RInteger;
   
   //============================================================
   // <T>资源信息。</T>
   //============================================================
   public class SResourceInfo
   {
      // 总数
      public var count:int;
      
      // 加载中总数
      public var loadingCount:int;
      
      // 处理中总数
      public var processCount:int;
      
      // 有效总数
      public var validCount:int;
      
      // 总字节数
      public var totalBytes:int;
      
      // 类型字典
      public var types:FDictionary = new FDictionary();
      
      //============================================================
      // <T>构造资源信息。</T>
      //============================================================
      public function SResourceInfo(){
      }
      
      //============================================================
      // <T>重置数据。</T>
      //============================================================
      public function reset():void{
         var c:int = types.count;
         for(var n:int = 0; n < c; n++){
            var ti:SResourceTypeInfo = types.values[n] as SResourceTypeInfo;
            ti.reset();
         }
      }
      
      //============================================================
      // <T>获得类型集合信息。</T>
      //
      // @return 类型集合信息
      //============================================================
      public function typeInfos():String{
         var r:String = "";
         var c:int = types.count;
         for(var n:int = 0; n < c; n++){
            var ti:SResourceTypeInfo = types.values[n] as SResourceTypeInfo;
            if(n > 0){
               r += ",";
            }
            var tb:String = RInteger.formatMemory(ti.totalBytes, "k"); 
            var mb:String = RInteger.formatMemory(ti.memoryBytes, "k");
            var rb:String = RInteger.formatMemory(ti.memoryRealBytes, "k");
            var cb:String = RInteger.formatMemory(ti.compressBytes, "k");
            r += types.names[n] + "=" + ti.readyCount + "/" + ti.count + "(" + tb + "/" + mb + "[" + mb+ "->" + cb +"])";
         }
         return r;
      }
   }
}