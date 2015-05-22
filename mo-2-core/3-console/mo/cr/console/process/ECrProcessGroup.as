package mo.cr.console.process
{
	//============================================================
	// <T>进程分组。</T>
	//============================================================
	public class ECrProcessGroup
	{
		// 系统
		public static const System:int = 0x10000;

		// 进程
		public static const Process:int = 0x20000;
		
		// 线程
		public static const Thread:int = 0x30000;

		// 逻辑
		public static const Logic:int = 0x40000;
		
		// 日志
		public static const Logger:int = 0x50000;

      // 遮挡
      public static const Mask:int = 0xF0000;
	}
}