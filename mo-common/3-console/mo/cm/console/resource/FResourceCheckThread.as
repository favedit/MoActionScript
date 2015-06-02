package mo.cm.console.resource
{
   import flash.system.System;
   
   import mo.cm.console.thread.FThread;
   import mo.cm.lang.FLooper;
   import mo.cm.logger.RLogger;
   import mo.cm.logger.RTracker;
   import mo.cm.system.ILogger;
   
   //============================================================
   // <T>资源卸载线程。</T>
   //============================================================
   public class FResourceCheckThread extends FThread
   {
      // 日志输出接口
      private static var _logger:ILogger = RLogger.find(FResourceCheckThread);

      // 资源集合
      public var resources:FLooper = new FLooper();
      
      // 内存警戒值（400M）
      public var memoryLimit:Number = 471859200;
      
      // 内存警戒值（450M）
      public var inRelease:Boolean;
      
      // 内存警戒值（450M）
      public var releaseCount:int;
      
      //============================================================
      // <T>构造资源卸载线程。</T>
      //============================================================
      public function FResourceCheckThread(){
         name = "common.resource.check.thread";
         countMin = 8;
         countMax = 128;
      }
      
      //============================================================
      // <T>增加一个监视的资源对象。</T>
      //
      // @param p:resource 资源对象
      //============================================================
      public function push(p:FResource):void{
         if(!resources.contains(p)){
            resources.push(p);
         }
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @return
      //    true: 表示当前处理中不需要后续处理
      //    false: 表示当前处理中需要后续处理，等待下一帧回调
      //============================================================
      public override function execute():Boolean{
         var r:Boolean = true;
         // 检测是否需要加载
         if(RResource.optionTimeout){
            // 当前内存大小超出内存警戒值时执行释放操作
            if(inRelease){
               var rs:FResource = resources.next();
               if(rs){
                  var rc:Boolean = false;
                  if(!rs.requested){
                     // 移除为请求的资源
                     resources.remove();
                  }else if(rs.ready){
                     // 资源关闭
                     releaseCount--;
                     if(releaseCount == 0){
                        inRelease = false;
                     }
                     var rg:FResourceGroup = rs.group;
                     if(null != rg){
                        // 如果组全部超时，则释放整个组
                        if(rg.testInvalid()){
                           if(rg.close()){
                              rc = true;
                           }
                        }
                     }else{
                        // 如果资源超时，则释放整个资源
                        if(!rs.testValid()){
                           if(rs.close()){
                              resources.remove();
                              rc = true;
                           }
                        }
                     }
                     // _logger.debug("execute", "Process resource. (group_code={1}, code={2})", rs.groupCode, rs.code);
                  }
                  r = false;
               }
            }
         }
         return r;
      }
      
      //============================================================
      // <T>线程处理。</T>
      //
      // @return 处理结果
      //============================================================
      public override function processFirst():Boolean{
         // 开始处理
         first = true;
         currentFrameTotal = 0;
         if(!inRelease){
            var mt:Number = System.totalMemory;
            if(mt >= memoryLimit){
               inRelease = true;
               releaseCount = resources.count;
            }
         }
         if(inRelease){
            // 线程处理
            var es:Number = new Date().time;
            for(var n:int = countMin; n > 0; n--){
               result = execute();
               first = false;
               RTracker.threadTotal++;
               if(result){
                  break;
               }
            }
            var ee:Number = new Date().time;
            // 跟踪结束处理
            currentFrameTotal += (ee - es);
         }
         return result;
      }
      
      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return name + " [resource=" + resources.count + "]";
      }
   }
}