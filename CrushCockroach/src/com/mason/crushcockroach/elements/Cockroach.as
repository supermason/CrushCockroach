package com.mason.crushcockroach.elements 
{
	import com.mason.crushcockroach.GameConstants;
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
		private var _state:int;
		
		public function Cockroach() 
		{
			super();
			
		}
		
		// public ////
		public function dead():void
		{
			if (parent) parent.removeChild(this);
			
			removeFromJuggler(_cockroachArt);
			
			_cockroachArt.dispose();
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_cockroachArt = new MovieClip(Assets.getAtlas().getTextures("naruto_run_"), 6);
//			_cockroachArt.x = Math.ceil(-_cockroachArt.width * .5);
//			_cockroachArt.y = Math.ceil(-_cockroachArt.height * .5);
			
			addToJuggler(_cockroachArt);
			
			addChild(_cockroachArt);
			
			x = -_cockroachArt.width;
			y = (stage.stageHeight - _cockroachArt.texture.height - 50) * Math.random();
			
			if (y <= 80) y = 80;
			
			_state = GameConstants.COCKROACH_ALIVE;
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
		
		public function get state():int 
		{
			return _state;
		}
		
		public function set state(value:int):void 
		{
			_state = value;
		}
	}

}