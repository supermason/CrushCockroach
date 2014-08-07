package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.elements.GameBackground;
	import com.mason.crushcockroach.ui.GameSprite;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class InGame extends GameSprite 
	{
		private var _background:GameBackground;
		
		public function InGame() 
		{
			super();
			
		}
		
		// public ////
		
		override public function show($parent:DisplayObjectContainer=null, childIndex:int = -1):void
		{
			super.show($parent, childIndex);
			
			
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_background = new GameBackground();
			
			addChild(_background);
		}
		
	}

}