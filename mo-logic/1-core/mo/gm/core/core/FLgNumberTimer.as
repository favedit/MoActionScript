package mo.gm.core.core
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;

	public class FLgNumberTimer
	{
		protected var _timer:Timer;

		protected var _field:TextField;
		
		protected var _value:String;

		protected var _current:Array = new Array();
		
		protected var _values:Array = new Array();

		public function FLgNumberTimer(){
		}
		
		public function start(field:TextField, value:String, interval:Number = 10):void{
			_field = field;
			_value = value;
			_timer = new Timer(interval);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start();
			// 分解字符
			var length:int = _value.length;
			for(var i:int = 0; i < length; i++){
				var charValue:String = _value.charAt(i);
				if(charValue == '.'){
					_current.push('.');
					_values.push('.');
				}else{
					_current.push(0);
					_values.push(charValue);
				}
			}
		}
		
		public function currentValue():String{
			var source:String = "";
			var length:int = _current.length;
			for(var i:int = 0; i < length; i++){
				source += _current[i];
			}
			return source;
		}
		
		public function onTimer(event:Event):void{
			var source:String = "";
			var length:int = _current.length;
			for(var i:int = 0; i < length; i++){
				var charValue:String = _current[i];
				if(charValue != '.'){
					if(charValue != _values[i]){
						_current[i] = parseInt(charValue) + 1;
						break;
					}
				}
			}
			var currentValue:String = currentValue();
			_field.text = currentValue;
			//trace(currentValue);
			if(currentValue == _value){
				_timer.removeEventListener(TimerEvent.TIMER, onTimer);
				_timer.stop();
			}
		}
	}
}