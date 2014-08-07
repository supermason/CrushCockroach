package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.GameConstants;
	import com.mason.crushcockroach.elements.Cockroach;
	import com.mason.crushcockroach.elements.GameBackground;
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.ui.GameWindow;
	
	import flash.utils.getTimer;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class InGame extends GameWindow 
	{
		private var _background:GameBackground;
		private var _cockroach:Cockroach;
		private var _pauseButton:Button;
		private var _startButton:Button;
		
		private var _gamePaused:Boolean;
		private var _gameState:int;
		
		private var _timePrevious:Number = 0;
		private var _timeCurrent:Number = 0;
		private var _elapsed:Number = 0;
		private var _speedControl:Number = 0;
		
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
			
			_cockroach = new Cockroach();
			_cockroach.x = (stage.stageWidth - _cockroach.width) * .5;
			_cockroach.y = (stage.stageHeight - _cockroach.height) * .5;
			_cockroach.speed = GameConstants.COCKROACH_BASE_SPEED * Math.random();
			
			_pauseButton = new Button(Assets.getAtlas().getTexture("pauseButton"));
			_pauseButton.x = _pauseButton.width * 2;
			_pauseButton.y = _pauseButton.height * .5;
			
			_startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			_startButton.x = (stage.stageWidth - _startButton.width) * .5;
			_startButton.y = (stage.stageHeight - _startButton.height) * .5;
			
			addChild(_background);
			addChild(_cockroach);
			addChild(_pauseButton);
			addChild(_startButton);
			
			screenState = GameConstants.GAME_STATE_IDLE;
		}
		
		override protected function addEvt():void
		{
			_startButton.addEventListener(Event.TRIGGERED, triggerEvtHandler);
			_pauseButton.addEventListener(Event.TRIGGERED, triggerEvtHandler);
		}
		
		// event handler ////
		private function triggerEvtHandler(event:Event):void 
		{
			event.stopImmediatePropagation();
			
			if (event.target == _startButton)
			{
				Sounds.play("sndCoffee");
				
				screenState = GameConstants.GAME_STATE_PLAYING;
				
				startGame();
				
			}
			else if (event.target == _pauseButton)
			{
				_gamePaused = !_gamePaused;
			}
		}
		
		private function enterFrameHandler(event:Event):void
		{
			calculateElapsed();
			
			onGameTick();
		}
		
		// private ////
		
		private function startGame():void 
		{
//			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function onGameTick():void
		{
			if (!_gamePaused)
			{
				switch (_gameState)
				{
					case GameConstants.GAME_STATE_IDLE:
						
						break;
					case GameConstants.GAME_STATE_PLAYING:
						_cockroach.x += _cockroach.speed * _elapsed;
						if (_cockroach.x + _cockroach.width > stage.stageWidth)
							_cockroach.x = -_cockroach.width;
						break;
				}
			}
		}
		
		private function calculateElapsed():void
		{
			_timePrevious = _timeCurrent;
			_timeCurrent = getTimer();
			
			if (_timePrevious == 0) _timePrevious = _timeCurrent;
			
			_elapsed = (_timeCurrent - _timePrevious) * .001;
		}
		
		// getter && setter ////
		private function set screenState(value:int):void
		{
			_gameState = value;
			
			_startButton.visible = value == GameConstants.GAME_STATE_IDLE;
			_pauseButton.visible = value == GameConstants.GAME_STATE_PLAYING;
		}
		
	}

}