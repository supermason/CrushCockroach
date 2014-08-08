package com.mason.crushcockroach.ui {
	import com.mason.crushcockroach.utils.AnimationHelper;
	import starling.display.MovieClip;
	
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
		protected var _animateObjList:Vector.<IAnimatable>;
		
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
		
		// protected ////
		
		protected function init():void
		{
			_animateObjList = new <IAnimatable>[];
			
			drawScreen();
		}
		
		protected function drawScreen():void
		{
			
		}
		
		
		protected function addToJuggler(animateObj:IAnimatable):void
		{
			if (_animateObjList.indexOf(animateObj) == -1)
				_animateObjList[_animateObjList.length] = animateObj;
			
			AnimationHelper.addToJuggler(animateObj);
		}
		
		protected function removeFromJuggler(animateObj:IAnimatable):void
		{
			AnimationHelper.removeFromJuggler(animateObj);
			
			if (animateObj is MovieClip) MovieClip(animateObj).stop();
			
			var index:int = _animateObjList.indexOf(animateObj);
			if (index != -1)
				_animateObjList.splice(index, 1);
		}
		
		protected function removeAllAnimateObjsFromJuggler():void
		{
			if (_animateObjList.length > 0)
			{
				for each (var aniObj:IAnimatable in _animateObjList)
				{
					AnimationHelper.removeFromJuggler(aniObj);
				}
				
				_animateObjList.length = 0;
			}
		}
		
		
	}

}