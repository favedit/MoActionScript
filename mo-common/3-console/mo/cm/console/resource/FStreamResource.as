package mo.cm.console.resource
{
   import flash.utils.ByteArray;
   
   import mo.cm.console.RCmConsole;
   import mo.cm.core.device.RFatal;
   import mo.cm.stream.FInput;
   
   //============================================================
   // <T>数据流资源。</T>
   //============================================================
   public class FStreamResource extends FResource
   {
      // 资源流
      public var stream:FResourceStream;
      
      //============================================================
      // <T>构造数据流资源。</T>
      //============================================================
      public function FStreamResource(){
      }
      
      //============================================================
      // <T>加载事件处理。</T>
      //
      // @param pd:data 数据
      // @param po:offset 位置
      // @param pl:length 长度
      //============================================================
      public override function onLoaded(pd:ByteArray, po:int, pl:int):void{
         // 读取头信息
         var s:FInput = new FInput(pd, po, pl);
         unserializeInfo(s);
         // 读取数据
         if(null != stream){
            RFatal.throwFatal("Stream is already exists.");
         }
         var l:int = s.readInt32();
         stream = RCmConsole.resourceConsole.vendorData.createStream();
         stream.load(s.memory, s.position, l);
         verify(stream.verifyCode);
         RCmConsole.resourceConsole.pushStream(stream);
         // 释放资源
         s.dispose();
         prepared = true;
         loaded = true;
      }
      
      //============================================================
      // <T>处理事件处理。</T>
      //
      // @return 处理结果
      //============================================================
      public override function onProcess():Boolean{
         // 读取数据
         if(null != stream){
            if(stream.ready){
               // 反序列化数据
               unserializeData(stream);
               // 释放数据
               RCmConsole.resourceConsole.vendorData.freeStream(stream);
               stream = null;
               return true;
            }else{
               stream.process();
            }
         }
         return ready;
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function onFree():void{
         if(null != stream){
            RCmConsole.resourceConsole.vendorData.freeStream(stream);
            stream = null;
         }
         super.onFree();
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         if(null != stream){
            RCmConsole.resourceConsole.vendorData.freeStream(stream);
            stream = null;
         }
         super.dispose();
      }
   }
}