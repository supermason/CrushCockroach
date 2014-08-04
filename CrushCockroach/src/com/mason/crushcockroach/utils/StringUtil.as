package com.mason.crushcockroach.utils 
{
	/**
	 * ...
	 * @author Mason
	 */
	public class StringUtil 
	{
		
		/**
		 * 获取时间字符串(不超过一小时的时间)
		 * @param l 指定的语言包
		 * @param seconds: 时间秒数
		 * @param format: 显示格式
		 * @return 格式化后的字符串(XX:XX)
		 * */
		public static function getSecondStr(seconds:int, format:String=":"):String
		{
			if (seconds < 0) seconds = 0;
			var m:int = int((seconds % 3600) / 60);
			var s:int = int(seconds % 60); 
			
			return (m > 9 ? m : "0" + m) + format + (s > 9 ? s : "0" + s);
		}
		
	}

}