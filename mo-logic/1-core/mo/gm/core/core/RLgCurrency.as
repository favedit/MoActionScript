package mo.gm.core.core
{
	public class RLgCurrency
	{
		public static function format(value:Number):String{
			var unit:int = 0;
			var result:Number = 0;
			if(value > 100000000){
				unit = (int)(value / 10000);
				result = unit;
			}else{
				unit = (int)(value / 100);
				result = unit / 100;
			}
			return result + "";
		}
	}
}