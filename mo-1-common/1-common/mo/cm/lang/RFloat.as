package mo.cm.lang
{   
   //============================================================
   // <T>浮点数工具类。</T>
   //============================================================
   public class RFloat
   {
      public static const MaxHalf:Number = Number.MAX_VALUE / 2;
         
      //============================================================
      // <T>解析字符串。</T>
      //
      // @param pv:value 字符串
      // @param pd:default 默认值
      // @return 数值
      //============================================================
      public static function parse(pv:String, pd:Number = 0):Number{
         if(!RString.isEmpty(pv)){
            return parseFloat(pv);
         }
         return pd;
      }

      //============================================================
      public static function toFloat(value:String, valueDefault:Number = 0):Number{
         if(!RString.isEmpty(value)){
            return parseFloat(value);
         }
         return valueDefault;
      }

      //============================================================
      public static function format(value:Number, length:int = 8):String{
         var data:String = value.toString();
         var e:int = data.indexOf("e");
         if(-1 != e){
            return data.substr(0, length) + data.substr(e);
         }
         return data.substr(0, length);
      }
      
      //============================================================
      // <T>保留一个浮点数小数点后几位</T>
      // 
      // @param value 浮点数
      // @param length 保留位数
      //============================================================
      public static function formatRound(value:Number, length:int):String{
         var data:String = value.toString();
         var left:String = RString.left(data, ".");
         var right:String = RString.right(data, ".");
         right = right.substr(0, length);
         return left + "." + right;
      }
   }  
}