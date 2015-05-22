package mo.cm.stream
{
   public class RStream
   {
      protected static var _stream:FByteStream = new FByteStream();

      protected static var _input:FByteStream = new FByteStream();

      protected static var _output:FByteStream = new FByteStream();

      public static function get instance():FByteStream{
         _stream.clear();
         return _stream;
      }
      
      public static function get input():FByteStream{
         _input.clear();
         return _input;
      }
      
      public static function get output():FByteStream{
         _output.clear();
         return _output;
      }
   }
}