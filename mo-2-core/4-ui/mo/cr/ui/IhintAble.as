package mo.cr.ui
{
   public interface IhintAble
   {
      // 是否显示
      function isHintAble():Boolean;

      // 获取说明文本
      function  get hintText():String;
   }
}