package com.mason.crushcockroach 
{
	import com.mason.crushcockroach.events.NavigationEvent;
	import com.mason.crushcockroach.events.Operation;
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.screens.GameOver;
	import com.mason.crushcockroach.screens.InGame;
	import com.mason.crushcockroach.screens.Welcome;
	import com.mason.crushcockroach.ui.GameWindow;
	import com.mason.crushcockroach.ui.SoundButton;
	
	import starling.animation.Tween;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Game extends GameWindow 
	{
		/** Screen - Welcome or Main Menu. */
		private var _screenWelcome:Welcome;
		
		/** Screen - InGame. */
		private var _screenInGame:InGame;
		
		/** Sound / Mute button. */
		private var _soundButton:SoundButton;
		
		private var _screenGameOver:GameOver;
		private var _gameOverTween:Tween;
		
		public function Game() 
		{
			super();
			
		}
		
		// public ////
		override public function show(parent:DisplayObjectContainer=null, childIndex:int=-1):void
		{
			super.show(null, childIndex);
			
			_screenWelcome.show(this);
			
			addChild(_soundButton);
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_screenWelcome = new Welcome();
			_screenInGame = new InGame();
			_screenGameOver = new GameOver();
			
			_soundButton = new SoundButton();
			_soundButton.x = int(_soundButton.width * 0.5);
			_soundButton.y = int(_soundButton.height * 0.5);
			
			show();
		}
		
		override protected function addEvt():void
		{
			_soundButton.addEventListener(Event.TRIGGERED, soundButtonClickHandler);
			
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			addEventListener(NavigationEvent.CHANGE_SCREEN, onScreenChange);
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
		
		private function onScreenChange(e:Event):void 
		{
			switch(e.data.operation)
			{
				case Operation.PLAY:
					_screenWelcome.hide();
					_screenInGame.show(this, this.numChildren);
//					addGameOverScreen(0, "00:00:00");
					break;
				case Operation.GAME_OVER:
					addGameOverScreen(e.data.score, e.data.duration);
					break;
				case Operation.PLAY_AGAIN:
					removeGameOverScreen(showInGameScreen);
					break;
				case Operation.BACK_TO_WELCOME:
					removeGameOverScreen(backToWelcome);
					break;
				case Operation.JUMP_TO_ABOUT:
					removeGameOverScreen(jumpToAbout);
					break;
					
			}
			
			// make sure this soundButton is on top of all other displayObjects
			addChild(_soundButton);
		}
		
		private function createTween():void
		{
			_gameOverTween = new Tween(_screenGameOver, 1);
		}
		
		private function addGameOverScreen(score:int, duration:String):void
		{
			createTween();
			_screenGameOver.alpha = 0;
			_screenGameOver.show(this);
			_screenGameOver.setResult(score, duration);
			_gameOverTween.fadeTo(1);
			_gameOverTween.onComplete = function():void {
				if (_screenInGame.active)_screenInGame.hide();
				removeFromJuggler(_gameOverTween);
				addChild(_soundButton);
			};
			addToJuggler(_gameOverTween);
		}
		
		private function removeGameOverScreen(completeHandler:Function):void
		{
			createTween();
			_gameOverTween.fadeTo(0);
			_gameOverTween.onComplete = completeHandler;
			addToJuggler(_gameOverTween);
		}
		
		private function removeGameOver():void
		{
			_screenGameOver.hide();
			removeFromJuggler(_gameOverTween);
			_gameOverTween.reset(_screenGameOver, 1);
			
			addChild(_soundButton);
		}
		
		private function showInGameScreen():void
		{
			_screenInGame.show(this, this.numChildren);
			
			removeGameOver();
		}
		
		private function backToWelcome():void
		{
			_screenWelcome.show(this, this.numChildren);
			
			removeGameOver();
		}
		
		private function jumpToAbout():void
		{
			backToWelcome();
			
			_screenWelcome.jumpToAbout();
		}
		
		private function enterFrameHandler(event:Event):void
		{
			if (_screenInGame.active) _screenInGame.timeElapsed();
			if (_screenWelcome.active)_screenWelcome.timeElapsed();
		}
		
	}

}