package com.mason.crushcockroach.ui 
{
	import starling.animation.IAnimatable;
	import starling.display.DisplayObjectContainer;
	/**
	 * ...
	 * @author Mason
	 */
	public class GameWindow extends GameSprite 
	{
		protected var _active:Boolean;
		
		public function GameWindow() 
		{
			super();
			
		}
		
		// public ////
		
		public function show($parent:DisplayObjectContainer=null, childIndex:int=-1):void
		{
			if ($parent) 
			{
				if (childIndex != -1)
				{
					$parent.addChildAt(this, childIndex);
				}
				else
				{
					$parent.addChild(this);
				}
			}
			
			addEvt();
			
			_active = true;
		}
		
		public function hide():void
		{
			_active = false;
			
			if (parent) parent.removeChild(this);
			
			removeEvt();
			
			removeAllAnimateObjsFromJuggler();
		}
		
		public function timeElapsed():void
		{
			
		}
		
		// protected ////
		
		protected function addEvt():void
		{
			
		}
		
		protected function removeEvt():void
		{
			
		}
		
		protected function removeEvent(type:String, handler:Function):void
		{
			if (hasEventListener(type)) removeEventListener(type, handler);
		}
		
		// getter && setter ////
		/**Wheather this window is current screen to display*/
		public function get active():Boolean 
		{
			return _active;
		}
		
	}

}