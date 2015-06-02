package mo.cm.lang
{   
   //============================================================
   // <T>字符串。</T>
   //============================================================
   public class FString extends FObject
   {
      // 字符串存储数组
      protected var items:Vector.<String> = new Vector.<String>();
      
      //============================================================
      // <T>创建字符串。</T>
      //
      // @param p:values 字符串数组
      //============================================================
      public function FString(...p){
         var c:int = p.length;
         for(var n:int = 0; n < c; n++){
            items.push(p[n]);
         }
      }
      
      //============================================================
      // <T>接收字符串列表。</T>
      //
      // @param p:values 字符串列表
      //============================================================
      public function assign(...p):void{
         items.length = 0; 
         var c:int = p.length;
         for(var n:int = 0; n < c; n++){
            items.push(p[n]);
         }
      }
      
      //============================================================
      // <T>接收重复字符串。</T>
      //
      // @param pv:value 字符串
      // @param pc:count 重复次数
      //============================================================
      public function assignRepeat(pv:String, pc:int):void{
         items.length = 0; 
         for(var n:int = 0; n < pc; n++){
            items.push(pv);
         }
      }
      
      //============================================================
      // <T>接收字符串参数集合。</T>
      //
      // @param pv:value 字符串
      // @param pp:parameters 参数集合
      //============================================================
      public function assignParameters(pv:String, ...pp):void{
         items.length = 0; 
         // 替换埋入参数
         var c:int = pp.length;
         for(var n:int = 0; n < c; n++) {
            pv = pv.replace("{" + (n + 1) + "}", pp[n]);
         }
         items.push(pv);
      }
      
      //============================================================
      // <T>追加字符串列表。</T>
      //
      // @param p:values 字符串列表
      //============================================================
      public function append(...p):void{
         var c:int = p.length;
         for(var n:int = 0; n < c; n++){
            items.push(p[n]);
         }
      }
      
      //============================================================
      // <T>追加重复字符串。</T>
      //
      // @param pv:value 字符串
      // @param pc:count 重复次数
      //============================================================
      public function appendRepeat(pv:String, pc:int):void{
         for(var n:int = 0; n < pc; n++){
            items.push(pv);
         }
      }
      
      //============================================================
      // <T>追加字符串参数集合。</T>
      //
      // @param pv:value 字符串
      // @param pp:parameters 参数集合
      //============================================================
      public function appendParameters(pv:String, ...pp):void{
         // 替换埋入参数
         var c:int = pp.length;
         for(var n:int = 0; n < c; n++) {
            pv = pv.replace("{" + (n + 1) + "}", pp[n]);
         }
         items.push(pv);
      }
      
      //============================================================
      // <T>追加字符串列表。</T>
      //
      // @param values 字符串列表
      //============================================================
      public function appendLine(...values):void{
         var count:int = values.length;
         for(var n:int=0; n<count; n++){
            items.push(values[n]);
         }
         items.push("\n");
      }
      
      //============================================================
      // <T>清除字符串。</T>
      //============================================================
      public function clear():void{
         var c:int = items.length;
         for(var n:int = 0; n < c; n++){
            items[n] = null;
         }
         items.length = 0; 
      }
      
      //============================================================
      // <T>刷新字符串内容。</T>
      //
      // @return 字符串
      //============================================================
      public function flush():String{
         var r:String = items.join("");
         clear();
         return r;
      }
      
      //============================================================
      // <T>返回一个字符串。</T>
      //
      // @return 字符串
      //============================================================
      public override function toString():String{
         return items.join("");
      }
      
      //============================================================
      // <T>释放资源。</T>
      //============================================================
      public override function dispose():void{
         super.dispose();
         clear();
         items = null;
      }
   }  
}