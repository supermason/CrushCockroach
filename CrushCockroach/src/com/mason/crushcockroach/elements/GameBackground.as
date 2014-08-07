package com.mason.crushcockroach.elements 
{
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.ui.GameSprite;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class GameBackground extends GameSprite 
	{
		private var _bgImage:Image;
		
		public function GameBackground() 
		{
			super();
		}
		
		override protected function drawScreen():void
		{
			super.drawScreen();
			
			_bgImage = new Image(Assets.getAtlas().getTexture("bgInGame"));
			
			addChild(_bgImage);
		}
		
	}

}