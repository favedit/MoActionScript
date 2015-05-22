package mo.cm.console.thread
{
   import mo.cm.lang.FObject;
   import mo.cm.lang.RObject;
   import mo.cm.logger.RTracker;

   //============================================================
   // <T>线程处理基类。</T>
   //============================================================
   public class FThread extends FObject implements IThread
   {
      // 名称
      public var name:String;

      // 运行状态
      public var statusCd:int;

      // 当前帧运行间隔
      public var currentFrameTick:Number = 0;
      
      // 当前帧运行总间隔
      public var currentFrameTotal:Number = 0;

      // 可用空闲时刻
      public var idleTick:Number = 0;

      // 首次运行
      public var first:Boolean;

      // 单次循环最小次数
      public var countMin:int = 1;

      // 单次循环最大次数
      public var countMax:int = 1;

      // 单次循环次数
      public var countCurrent:int = 0;

      // 运行状态
      public var result:Boolean;

      //============================================================
      // <T>构造线程处理基类。</T>
      //============================================================
      public function FThread(){
      }

      //============================================================
      // <T>判断是否指定状态。</T>
      //============================================================
      public function isStatus(p:int):Boolean{
         return statusCd == p;
      }

      //============================================================
      // <T>判断是否繁忙。</T>
      //
      // @return 是否繁忙
      //============================================================
      public function testBusy():Boolean{
         return countCurrent > 1;
      }

      //============================================================
      // <T>开始执行处理。</T>
      //============================================================
      public function start():void{
         statusCd = EThreadStatus.Processing;
      }

      //============================================================
      // <T>结束执行处理。</T>
      //============================================================
      public function stop():void{
         statusCd = EThreadStatus.Stop;
      }

      //============================================================
      // <T>结束空闲处理。</T>
      //============================================================
      public function idle():void{
         statusCd = EThreadStatus.Idle;
      }

      //============================================================
      // <T>执行处理。</T>
      //
      // @return true:处理已经完毕
      //         false:处理未完成，如果还有空闲时间，继续执行
      //============================================================
      public function execute():Boolean{
         return true;
      }

      //============================================================
      // <T>线程处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function processFirst():Boolean{
         // 开始处理
         first = true;
         countCurrent = 0;
         currentFrameTotal = 0;
         // 线程处理
         var es:Number = new Date().time;
         for(var n:int = countMin; n > 0; n--){
            result = execute();
            countCurrent++;
            first = false;
            RTracker.threadTotal++;
            if(result){
               break;
            }
         }
         var ee:Number = new Date().time;
         // 跟踪结束处理
         currentFrameTick = ee - es;
         currentFrameTotal += currentFrameTick;
         return result;
      }

      //============================================================
      // <T>线程处理。</T>
      //
      // @return 处理结果
      //============================================================
      public function process():Boolean{
         // 线程处理
         var es:Number = new Date().time;
         result = execute();
         countCurrent++;
         RTracker.threadTotal++;
         var ee:Number = new Date().time;
         // 跟踪结束处理
         currentFrameTick = ee - es;
         currentFrameTotal += currentFrameTick;
         return result;
      }

      //============================================================
      // <T>获得内容字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return RObject.toString(this) + " (name=" + name + ", tick=" + currentFrameTotal + ", count=" + countCurrent + ", result=" + result + ")";
      }
   }
}