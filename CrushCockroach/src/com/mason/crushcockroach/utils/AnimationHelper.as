package com.mason.crushcockroach.utils 
{
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class AnimationHelper 
	{
		private static var _juggler:Juggler = Starling.juggler;
		
		public function AnimationHelper() 
		{
			
		}
		
		public static function addToJuggler(animateObj:IAnimatable):void
		{
			if (!_juggler.contains(animateObj))
			{
				_juggler.add(animateObj);
			}
		}
		
		public static function removeFromJuggler(animateObj:IAnimatable):void
		{
			if (_juggler.contains(animateObj))
			{
				_juggler.remove(animateObj);
			}
		}
	}

}