package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.displayobject.GameSprite;
	import com.mason.crushcockroach.res.Assets;
	import starling.display.DisplayObjectContainer;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Welcome extends GameSprite
	{
		private var _bg:Image;
		private var _startBtn:Button;
		private var _aboutBtn:Button;
		private var _backBtn:Button;
		
		public function Welcome() 
		{
			super();
		}
		
		// public ////
		override public function show(parent:DisplayObjectContainer):void
		{
			
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_bg = new Image(Assets.getTexture("BgWelcome"));
			_bg.blendMode = BlendMode.NONE;
			
			
			_startBtn = new Button(Assets.getAtlas().getTexture("startButton"));
			
			_aboutBtn = new Button(Assets.getAtlas().getTexture("aboutButton"));
			
			_backBtn = new Button(Assets.getAtlas().getTexture("backButton"));
			
			addChild(_bg);
			addChild(_startBtn);
			addChild(_aboutBtn);
			addChild(_backBtn);
		}
		
		// getter && setter ////
		private function set btnState(value:int):void
		{
			
		}
		
	}

}