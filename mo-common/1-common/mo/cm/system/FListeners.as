package mo.cm.system
{
   import mo.cm.core.device.RFatal;
   import mo.cm.lang.FObject;
   import mo.cm.logger.RLogger;
   
   //============================================================
   // <T>监听器列表。</T>
   //============================================================
   public class FListeners extends FObject
   {
      // 日志输出对象
      private static var _logger:ILogger = RLogger.find(FListeners);
      
      // 发送对象
      public var statusCd:int = EEventProcessStatus.End;
      
      // 发送对象
      public var sender:*;
      
      // 监听器列表
      public var listeners:Vector.<FListener>;
      
      //============================================================
      // <T>构造监听器列表。</T>
      //
      // @param p:sender 发送对象
      //============================================================
      public function FListeners(p:* = null){
         sender = p;
      }
      
      //============================================================
      // <T>构造资源。</T>
      //============================================================
      public override function construct():void{
         super.construct();
         statusCd = EEventProcessStatus.End;
      }
      
      //============================================================
      // <T>判断是否含有指定的处理函数。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 是否含有
      //============================================================
      protected function innerListeners():Vector.<FListener>{
         if(!listeners){
            listeners = new Vector.<FListener>();
         }
         return listeners;
      }
      
      //============================================================
      // <T>判断是否含有指定的处理函数。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 是否含有
      //============================================================
      public function contains(pm:Function, po:Object = null):Boolean{
         return (null != find(pm, po));
      }
      
      //============================================================
      // <T>查找指定的处理函数。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @return 是否含有
      //============================================================
      public function find(pm:Function, po:Object = null):FListener{
         if(listeners){
            var c:int = listeners.length;
            for(var n:int = 0; n < c; n++){
               var l:FListener =  listeners[n];
               if(pm == l.method){
                  if(po){
                     if(l.owner == po){
                        return l;
                     }
                  }else{
                     return l;
                  }
               }
            }
         }
         return null;
      }
      
      //============================================================
      // <T>增加一个监听器。</T>
      //
      // @param p:listener 监听器
      //============================================================
      public function push(p:FListener):void{
         innerListeners().push(p);
      }
      
      //============================================================
      // <T>关联一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      //============================================================
      public function link(pm:Function, po:Object=null, pc:int = -1):FListener{
         // 清空所有监听器
         clear();
         // 创建消息
         var l:FListener = RAllocator.create(FListener);
         l.method = pm;
         l.owner = po;
         l.count = pc;
         l.total = pc;
         innerListeners().push(l);
         return l;
      }
      
      //============================================================
      // <T>注册一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      // @param pc:count 处理次数
      // @return 监听器
      //============================================================
      public function register(pm:Function, po:Object = null, pc:int = -1):FListener{
         // 检查参数为空
         if(null == pm){
            RFatal.throwFatal("Listener function is null.");
         }
         // 检查存在性
         var l:FListener = find(pm, po);
         if(l){
            //RFatal.throwFatal("Listener function is already exists.");
            return l;
         }
         // 创建消息
         l = RAllocator.create(FListener);
         l.method = pm;
         l.owner = po;
         l.count = pc;
         l.total = pc;
         innerListeners().push(l);
         return l;
      }
      
      //============================================================
      // <T>注销一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      //============================================================
      public function unregister(pm:Function, po:Object = null):void{
         var r:Boolean = false;
         // 执行处理
         if(listeners){
            for(var n:int = listeners.length - 1; n >= 0; n--){
               var l:FListener = listeners[n];
               if(l.method == pm){
                  if(po){
                     // 含有拥有者
                     if(l.owner == po){
                        if(statusCd == EEventProcessStatus.Begin){
                           l.isValid = false;
                        }else{
                           listeners.splice(n, 1);
                           l.dispose();
                        }
                        r = true;
                     }
                  }else{
                     // 不含拥有者
                     if(statusCd == EEventProcessStatus.Begin){
                        l.isValid = false;
                     }else{
                        listeners.splice(n, 1);
                        l.dispose();
                     }
                     r = true;
                  }
               }
            }
         }
         // 检查结果
         if(!r){
            _logger.warn("unregister", "Unregister listener is not exist.");
         }
      }
      
      //============================================================
      // <T>注销一个监听器。</T>
      //
      // @param pm:method 处理函数
      // @param po:owner 拥有对象
      //============================================================
      public function compress():void{
         // 执行处理
         if(listeners){
            for(var n:int = listeners.length - 1; n >= 0; n--){
               var l:FListener = listeners[n];
               if(!l.isValid){
                  listeners.splice(n, 1);
                  l.dispose();
               }
               if(l.total > 0){
                  if(l.count <= 0){
                     listeners[n] = null;
                     listeners.splice(n, 1);
                     l.dispose();
                  }
               }
            }
         }
      }
      
      //============================================================
      // <T>执行处理。</T>
      //
      // @param p:event 事件对象
      //============================================================
      public function process(p:FEvent = null):void{
         if(listeners){
            // 设置发送者
            if(p && sender){
               p.sender = sender;
            }
            // 执行处理
            statusCd = EEventProcessStatus.Begin;
            var c:int = listeners.length;
            for(var n:int = 0; n < c; n++){
               var l:FListener = listeners[n];
               l.process(p);
            }
            statusCd = EEventProcessStatus.End;
            compress();
         }
      }
      
      //============================================================
      // <T>清除所有监听。</T>
      //============================================================
      public function clear():void{
         if(listeners){
            if(statusCd == EEventProcessStatus.Begin){
               for(var m:int = listeners.length - 1; m >= 0; m--){
                  listeners[m].isValid = false;
               }
            }else{
               for(var n:int = listeners.length - 1; n >= 0; n--){
                  listeners[n].dispose();
                  listeners[n] = null;
               }
               listeners.length = 0;
            }
         }
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         // 重置信息
         clear();
         listeners = null;
         sender = null;
         // 释放资源
         super.dispose();
      }
   }
}