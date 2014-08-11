package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.events.NavigationEvent;
	import com.mason.crushcockroach.events.Operation;
	import com.mason.crushcockroach.GameConstants;
	import com.mason.crushcockroach.elements.Cockroach;
	import com.mason.crushcockroach.elements.GameBackground;
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.screens.GameOver;
	import com.mason.crushcockroach.ui.GameWindow;
	import com.mason.crushcockroach.ui.HUD;
	import flash.geom.Point;
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
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
		private var _pauseButton:Button;
		private var _startButton:Button;
		
		private var _hud:HUD;
		
		private var _gamePaused:Boolean;
		private var _gameState:int;
		
		private var _timePrevious:Number = 0;
		private var _timeCurrent:Number = 0;
		private var _elapsed:Number = 0;
		
		private var _cockroaches:Vector.<Cockroach>;
		private var _cockroachInScreen:int;
		private var _generateKeyPoint:Number = 0;
		
		private var _touch:Touch;
		private var _pos:Point = new Point();
		
		public function InGame() 
		{
			super();
			
		}
		
		// public ////
		
		override public function show($parent:DisplayObjectContainer=null, childIndex:int = -1):void
		{
			super.show($parent, childIndex);
			
		}
		
		override public function timeElapsed():void
		{
			if (_gameState == GameConstants.GAME_STATE_PLAYING) enterFrameHandler();
		}
		
		override public function hide():void
		{
			super.hide();
			
			_hud.reset();
			
			_timePrevious = _timeCurrent = _elapsed = _generateKeyPoint = 0;
			
			for each (var cockroach:Cockroach in _cockroaches)
			{
				cockroach.dead();
				cockroach = null;
			}
			
			_cockroaches.length = 0;
			
			_cockroachInScreen = 0;

		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_background = new GameBackground();
			
			_pauseButton = new Button(Assets.getAtlas().getTexture("pauseButton"));
			_pauseButton.x = _pauseButton.width * 2;
			_pauseButton.y = _pauseButton.height * .5;
			
			_startButton = new Button(Assets.getAtlas().getTexture("startButton"));
			_startButton.x = (stage.stageWidth - _startButton.width) * .5;
			_startButton.y = (stage.stageHeight - _startButton.height) * .5;
			
			_hud = new HUD();
			
			addChild(_background);
			addChild(_pauseButton);
			addChild(_startButton);
			addChild(_hud);
			
			_cockroaches = new <Cockroach>[];
			
			screenState = GameConstants.GAME_STATE_IDLE;
		}
		
		override protected function addEvt():void
		{
			_startButton.addEventListener(Event.TRIGGERED, triggerEvtHandler);
			_pauseButton.addEventListener(Event.TRIGGERED, triggerEvtHandler);
		}
		
		override protected function removeEvt():void
		{
			_startButton.removeEventListener(Event.TRIGGERED, triggerEvtHandler);
			_pauseButton.removeEventListener(Event.TRIGGERED, triggerEvtHandler);
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
		
		private function enterFrameHandler(event:Event=null):void
		{
			calculateElapsed();
			
			onGameTick();
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			_touch = event.getTouch(stage);
			
			if (_touch)
			{
				_touch.getLocation(stage, _pos);
				
				if (_touch.phase == TouchPhase.ENDED)
				{
					for each (var cockroach:Cockroach in _cockroaches)
					{
						if ((_pos.x >= cockroach.x && _pos.x <= cockroach.x + cockroach.width) && (_pos.y >= cockroach.y && _pos.y <= cockroach.y + cockroach.height))
						{
							cockroachKilled(cockroach);
						}
					}
				}
			}
		}
		
		// private ////
		
		private function startGame():void 
		{
			stage.addEventListener(TouchEvent.TOUCH, touchHandler);
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
						recordTime();
						addCockroach();
						moveCockroach();
						removeDeadCockroach();
						break;
				}
			}
		}
		
		private function recordTime():void
		{
			_hud.duration += _elapsed * 100;
		}
		
		private function addCockroach():void
		{
			if (_generateKeyPoint >= GameConstants.GENERATE_FREQUENCY)
			{
				_generateKeyPoint = 0;
				
				if (_cockroachInScreen < GameConstants.MAX_COCKROACH_IN_SCREEN)
				{
					var countNeedToGenerate:int = GameConstants.AVERAGE_GENERATION_COUNT;
					
					if (_cockroachInScreen < GameConstants.MIN_COCKROACH_IN_SCREEN)
					{
						countNeedToGenerate = GameConstants.MIN_COCKROACH_IN_SCREEN - _cockroachInScreen;
					}
					
					var cockroach:Cockroach;
					
					for (var i:int = 0; i < countNeedToGenerate; ++i)
					{
						cockroach = new Cockroach();
						//cockroach.pivotX = -cockroach.width * .5;
						//cockroach.pivotY = -cockroach.height * .5;
						cockroach.speed = GameConstants.COCKROACH_BASE_SPEED * Math.random();
						
						addChild(cockroach);
						
						_cockroaches[_cockroaches.length] = cockroach;
						
						_cockroachInScreen++;
					}
				}
			}
			else
			{
				_generateKeyPoint += _elapsed;
			}
			
		}
		
		private function moveCockroach():void
		{
			for each (var cockroach:Cockroach in _cockroaches)
			{
				if (cockroach.state == GameConstants.COCKROACH_ALIVE)
				{
					cockroach.x += cockroach.speed * _elapsed;
					cockroach.speed -= (cockroach.speed - GameConstants.COCKROACH_BASE_SPEED) * .01;
					
					if (cockroach.x - cockroach.width > stage.stageWidth)
					{
						_hud.lives--;
						
						cockroachDie(cockroach);
						
						if (_hud.lives <= 0)
						{
							gameOver();
						}
					}
				}
			}
		}
		
		private function cockroachKilled(cockroach:Cockroach):void
		{
			_hud.killCount++;
			
			cockroachDie(cockroach);
		}
		
		private function cockroachDie(cockroach:Cockroach):void 
		{
			cockroach.state = GameConstants.COCKROACH_DEAD;
			cockroach.dead();
			cockroach = null;
						
			_cockroachInScreen--;
		}
		
		private function removeDeadCockroach():void 
		{
			var i:int = 0;
			var numCockroach:int = _cockroaches.length;
			var currentIndex:int = 0;
			var cockroach:Cockroach;
			
			for (; i < numCockroach; ++i)
			{
				cockroach = _cockroaches[i];
				
				if (cockroach)
				{
					if (currentIndex != i)
					{
						_cockroaches[currentIndex] = cockroach;
						_cockroaches[i] = null;
					}
					
					++currentIndex;
				}
			}
			
			if (currentIndex != i)
			{
				numCockroach = _cockroaches.length;
				while (i < numCockroach)
					_cockroaches[int(currentIndex++)] = _cockroaches[int(i++)];
					
				_cockroaches.length = currentIndex;
			}
		}
		
		private function gameOver():void
		{
			stage.removeEventListener(TouchEvent.TOUCH, touchHandler);
			
			_gamePaused = true;
			
			dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { 
				operation: Operation.GAME_OVER, 
				score: _hud.killCount,
				duration: _hud.durationStr
			} ));
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