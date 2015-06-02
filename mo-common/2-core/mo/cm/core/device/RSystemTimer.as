package mo.cm.core.device
{
   import mo.cm.lang.RInteger;
   
   import org.osmf.events.TimeEvent;

   //============================================================
   // <T>系统时间。</T>
   //============================================================
   public class RSystemTimer
   {
      // 服务器时刻
      public static var serverTick:Number; 
      
      // 当前时刻
      public static var serverSpan:Number = 0; 
       
      //============================================================
      // <T>更新系统时间。</T>
      //============================================================
      public static function get currentServerTick():Number{
         return RTimer.realTick + serverSpan;
      } 

      //============================================================
      // <T>更新系统时间。</T>
      //============================================================
      public static function update(p:Number):void{
         serverTick = p;
         serverSpan = serverTick - RTimer.realTick;
      } 
      
      //============================================================
      // <T>更新系统时间。</T>
      //============================================================
      public static function changTime(s:String):Number{
         var year:String = s.substr(0,4);
         var month:String = s.substr(4,2);
         var m:int = int(month) - 1;
         var day:String = s.substr(6,2);
         var hour:String = s.substr(8,2);
         var minute:String = s.substr(10,2);
         var second:String = s.substr(12,2);
         var ds:Date = new Date(year,m,day,hour,minute,second);
         var t:Number = ds.time;
         return t;
      }
      
      //============================================================
      // <T>将数字时间转换为分钟。</T>
      //
      // @params  cd 时间
      // @author HECNG 20120507
      //============================================================
      public static function timeToString(cd:Number):String{
         var str:String = "";
         var t:Number = cd;
         var arr:Array = updateTime(t, 3600000, true);
         str += arr[1].toString();
         arr = updateTime(int(arr[0]), 60000, true);
         str += arr[1].toString();
         arr = updateTime(int(arr[0]), 1000, false);
         str += arr[1].toString();
         return str;
      }
		
		//============================================================
      private static function updateTime(currTimer:Number, date:Number, bool:Boolean):Array{
         var str:String = "";
         var arr:Array = [];
         var m:int = currTimer / date;
         if(m > 0){
            currTimer = currTimer % date;
            str = m >= 10 ? m.toString() : "0" + m;
            str += bool ? ":" : "";
         }else{
            str += bool ? "00:" : "00";
         }
         arr.push(currTimer);
         arr.push(str);
         return arr;
      }
		
		//============================================================
		public static function getCurrTime():String{
			var time:Number = RTimer.currentTick + serverSpan;
		   var date:Date = new Date(time);			
			var y:Number = date.fullYear;
			var m:Number = date.month + 1;
			var d:Number = date.date;
			var h:Number = date.hours;
			var mm:Number = date.minutes;
			var dd:Number = date.seconds;
			return 	RInteger.lpad(y,2) +""	+RInteger.lpad(m,2)+""	+RInteger.lpad(d,2)+""
				+RInteger.lpad(h,2)+""+RInteger.lpad(mm,2)+""+RInteger.lpad(dd,2);
		}
   }
}