package com.mason.crushcockroach.displayobject 
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class GameSprite extends Sprite 
	{
		
		public function GameSprite() 
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * addedToStage handler
		 * @param	e
		 */
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		// public ////
		
		public function show(parent:DisplayObjectContainer):void
		{
			
		}
		
		public function hide():void
		{
			
		}
		
		// protected ////
		
		protected function init():void
		{
			drawScreen();
		}
		
		protected function drawScreen():void
		{
			
		}
		
		// private ////
	}

}