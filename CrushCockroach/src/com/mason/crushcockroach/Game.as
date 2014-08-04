package com.mason.crushcockroach 
{
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.screens.InGame;
	import com.mason.crushcockroach.ui.GameSprite;
	import com.mason.crushcockroach.screens.Welcome;
	import com.mason.crushcockroach.ui.SoundButton;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Game extends GameSprite 
	{
		/** Screen - Welcome or Main Menu. */
		private var _screenWelcome:Welcome;
		
		/** Screen - InGame. */
		private var _screenInGame:InGame;
		
		/** Sound / Mute button. */
		private var _soundButton:SoundButton;
		
		public function Game() 
		{
			super();
			
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_screenWelcome = new Welcome();
			
			_screenInGame = new InGame();
			
			_soundButton = new SoundButton();
			_soundButton.x = int(_soundButton.width * 0.5);
			_soundButton.y = int(_soundButton.height * 0.5);
		}
		
		override protected function addEvt():void
		{
			_soundButton.addEventListener(Event.TRIGGERED, soundButtonClickHandler);
		}
		
		// event handler ////
		private function soundButtonClickHandler(e:Event=null):void 
		{
			if (Sounds.muted)
			{
				Sounds.muted = false;
				
				if (_screenWelcome.active) 	   Sounds.play("sndBgMain");
				else if (_screenInGame.active) Sounds.play("sndBgGame");
				
				_soundButton.soundButtonState = SoundButton.UMUTE;
			}
			else 
			{
				Sounds.muted = true;
				
				_soundButton.soundButtonState = SoundButton.MUTE;
			}
		}
		
	}

}