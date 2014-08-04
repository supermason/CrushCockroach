package com.mason.crushcockroach.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class NavigationEvent extends Event 
	{
		/** Change of a screen. */		
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		/** Custom object to pass parameters to the screens. */
		public var params:Object;
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}