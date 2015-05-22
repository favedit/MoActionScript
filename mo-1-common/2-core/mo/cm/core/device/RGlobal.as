package mo.cm.core.device
{
   import flash.system.Capabilities;
   
   import mo.cm.lang.RString;

   //============================================================
   // <T>全局定义信息。</T>
   //============================================================
   public class RGlobal
   {
      // 处理方式
      public static var processCd:int = EProcess.Debug;
      
      // 在线模式
      public static var modeOnline:Boolean;

      // 手机模式
      public static var modeMobile:Boolean;

      // 文件模式
      public static var modeFile:Boolean;
      
      // 日志例外信息
      public static var loggerFatal:Boolean;

      // 显示调试信息
      public static var debugInfo:Boolean = true;
      
      // 调试信息
      public static var debugMode:Boolean = true;
      
      // 来源地址
      public static var sourceUrl:String = "http://localhost";
      
      // 来源地址
      public static var clientUrl:String = "http://localhost";
      
      // 来源地址
      public static var serverCode:String;
      
      // 来源地址
      public static var platformCode:String = "qy";
      
      // 帧速率
      public static var frameRate:int = 1000 / 60;

      // 资源跟踪
      public static var sourceTrack:Boolean = false;
      
      // 来源相对地址
      public static var sourceUri:String = "";
      
      // 来源格式
      public static var sourceFormat:String = "";

      // 来源传输地址
      public static var sourceTransfer:String = "";
      
      // 来源路径
      public static var sourcePath:String = "/rs.cl";
      
      // 网络自动
      public static var socketAuto:Boolean = true;

      // 网络主机地址
      public static var socketHost:String = "127.0.0.1";
      
      // 网络主机端口
      public static var socketPort:int = 10000;
      
      // 网络主机链接超时 (20秒)
      public static var socketConnectTimeout:int = 30000;
      
      // 网络主机数据超时 (10分钟)
      public static var socketDataTimeout:int = 600000;

      // 网络主机加密
      public static var socketMask:Boolean = true;

      // 键盘输入灵敏度
      public static var inputSensitivity:Number = 1.0;
      
      // 鼠标输入灵敏度
      public static var mouseSensitivity:Number = 1.0;
      
      // 版本号
      public static var version:String = "microbject";
      
      // 配置版本号
      public static var configVersion:String = "microbject";
      
      // 子版本号
      public static var versionSub:String = "mo";

      // 支持声音
      public static var isSoundAble:Boolean = true;
      
      // 支持音量
      public static var volume:int = 0.5;
      
      // 动画帧渲染方式
      public static var drawMode:int = EDrawMode.Copy;
      
      // 是否登录
      public static var isLogin:Boolean = false;
      
      // 版本112
      public static var versionPlayer112:Boolean;

      // 版本113
      public static var versionPlayer113:Boolean;

      // 版本114
      public static var versionPlayer114:Boolean;

      // 版本115
      public static var versionPlayer115:Boolean;
      
      // 是否需要域名接入
      public static var isGatePermission:Boolean = false;
      
      // 是否可以充值
      public static var isChargeAble:Boolean;
      
      // 是否为审核版本
      public static var isExamineVersion:Boolean;
      
      // 是否可以充值
      public static var isExperienceServer:Boolean = false;
      
      // 游戏名称
      public static var name:String;
      
      // 主页地址
      public static var website:String;
      
      // 客服后台入口地址
      public static var service:String;
      
      // 论坛
      public static var bbs:String;

      //============================================================
      // <T>静态初始化。</T>
      //============================================================
      {
         if(-1 != Capabilities.version.indexOf(" 11,2")){
            versionPlayer112 = true;
         }
         if(-1 != Capabilities.version.indexOf(" 11,3")){
            versionPlayer112 = true;
            versionPlayer113 = true;
         }
         if(-1 != Capabilities.version.indexOf(" 11,4")){
            versionPlayer112 = true;
            versionPlayer113 = true;
            versionPlayer114 = true;
         }
         if(-1 != Capabilities.version.indexOf(" 11,5")){
            versionPlayer112 = true;
            versionPlayer113 = true;
            versionPlayer114 = true;
            versionPlayer115 = true;
         }
      }
      
      //============================================================
      // <T>判断是否调试模式。</T>
      //
      // @return 调试模式
      //============================================================
      public static function get isDebug():Boolean{
         return (processCd == EProcess.Debug);
      }

      //============================================================
      // <T>判断是否发行模式。</T>
      //
      // @return 发行模式
      //============================================================
      public static function get isRelease():Boolean{
         return (processCd == EProcess.Release) || (processCd == EProcess.Online);
      }
      
      //============================================================
      // <T>判断是否在线模式。</T>
      //
      // @return 在线模式
      //============================================================
      public static function get isOnline():Boolean{
         return (processCd == EProcess.Online);
      }
      
      //============================================================
      // <T>判断是否在线模式。</T>
      //
      // @return 在线模式
      //============================================================
      public static function get tgwKey():String{
         return RString.rpad("tgw_l7_forward\r\nHost: " + socketHost + ":" + socketPort + "\r\n\r\n", 64);
      }
      
      //============================================================
      // <T>判断是否在线模式。</T>
      //
      // @return 在线模式
      //============================================================
      public static function get chargeUrl():String{
         switch(platformCode){
            case "qy":
               return "http://www.5ding.com/payment2/add/53/" + serverCode;
         }
         return null;
      }
      
      //============================================================
      // <T>获得全路径。</T>
      //
      // @return 全路径
      //============================================================
      public static function get sourceFullPath():String{
         return sourceUrl + sourceUri;
      }
   }
}