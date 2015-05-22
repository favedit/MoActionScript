package mo.cr.console.process
{
    //============================================================
    // <T>进程命令。</T>
    //============================================================
    public class ECrProcessCommand
    {
        // 链接请求
        public static const ConnectRequest:int = 0x0001;
        
        // 链接应答
        public static const ConnectResponse:int = 0x0002;

        // 断开请求
        public static const DisonnectRequest:int = 0x0003;

        // 断开应答
        public static const DisonnectResponse:int = 0x0004;
    }
}