package com.mason.crushcockroach.ui {
	import com.mason.crushcockroach.utils.AnimationHelper;
	import starling.animation.IAnimatable;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class GameSprite extends Sprite 
	{
		protected var _active:Boolean;
		
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
			if (parent) parent.addChild(this);
			
			addEvt();
			
			_active = true;
		}
		
		public function hide():void
		{
			_active = false;
			
			if (parent) parent.removeChild(this);
			
			removeEvt();
		}
		
		// protected ////
		
		protected function init():void
		{
			drawScreen();
		}
		
		protected function drawScreen():void
		{
			
		}
		
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
		
		protected function addToJuggler(animateObj:IAnimatable):void
		{
			AnimationHelper.addToJuggler(animateObj);
		}
		
		protected function removeFromJuggler(animateObj:IAnimatable):void
		{
			AnimationHelper.removeFromJuggler(animateObj);
		}
		
		
		// private ////
		
		// getter && setter ////
		/**Wheather this sprite is current screen to display*/
		public function get active():Boolean 
		{
			return _active;
		}
	}

}