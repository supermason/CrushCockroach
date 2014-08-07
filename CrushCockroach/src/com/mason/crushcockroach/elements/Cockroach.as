package com.mason.crushcockroach.elements 
{
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.ui.GameSprite;
	import starling.display.MovieClip;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Cockroach extends GameSprite 
	{
		private var _cockroachArt:MovieClip
		private var _speed:Number;
		
		public function Cockroach() 
		{
			super();
			
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_cockroachArt = new MovieClip(Assets.getAtlas().getTextures("naruto_run_0"), 6);
			_cockroachArt.x = Math.ceil(-_cockroachArt.width * .5);
			_cockroachArt.y = Math.ceil(-_cockroachArt.height * .5);
			
			addToJuggler(_cockroachArt);
			
			addChild(_cockroachArt);
		}
		
		// private ////
		
		// getter && setter ////
		
		public function cockroachAnimationSpeed(value:int):void
		{
			if (value == 0) _cockroachArt.fps = 6;
			else            _cockroachArt.fps = 18;
		}
		
		override public function get width():Number
		{
			if (_cockroachArt) return _cockroachArt.texture.width;
			else 			   return NaN;
		}
		
		override public function get height():Number
		{
			if (_cockroachArt) return _cockroachArt.texture.height;
			else 			   return NaN;
		}
		
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function set speed(value:Number):void 
		{
			_speed = value;
		}
	}

}