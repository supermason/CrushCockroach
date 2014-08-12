package com.mason.crushcockroach.ui 
{
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.utils.AnimationHelper;
	
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Mouse extends Sprite
	{
		private var _hammerReadyImage:Image;
		private var _hammerArt:MovieClip;
		private var _pivotX:int;
		private var _pivotY:int;
		private var _realPoint:Quad;
		
		public function Mouse() 
		{
			super();
			
			crreat();
		}
		
		// public ////
		public function onClick():void
		{
			_hammerReadyImage.visible = false;
			_hammerArt.visible = true;
			_hammerArt.play();
		}
		
		public function followMouse(pos:Point):void
		{
			x = pos.x - _pivotX;
			y = pos.y - _pivotY;
		}
		
		// private ////
		private function crreat():void 
		{
			flash.ui.Mouse.hide();
			
			touchable = false;
			
			_hammerArt = new MovieClip(Assets.getAtlas().getTextures("hammer_"), 24);
			_hammerArt.stop();
			_hammerArt.visible = false;
			_hammerArt.addEventListener(Event.COMPLETE, resetHammer);
			AnimationHelper.addToJuggler(_hammerArt);
			
			_hammerReadyImage = new Image(_hammerArt.getFrameTexture(0));
			
			_realPoint = new Quad(5, 5, 0xff0000);
			
			_pivotX = _hammerArt.getFrameTexture(4).width * .5;
			_pivotY = _hammerArt.getFrameTexture(4).height + 5;
			
			_realPoint.x = _pivotX;
			_realPoint.y = _pivotY;
			
			addChild(_hammerReadyImage);
			addChild(_realPoint);
			addChild(_hammerArt);
		}
		
		// event handler ////
		private function resetHammer(e:Event):void 
		{
			_hammerArt.stop();
			_hammerReadyImage.visible = true;
			_hammerArt.visible = false;
		}
		
	}

}