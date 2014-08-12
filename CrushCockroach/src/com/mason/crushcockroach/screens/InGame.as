package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.GameConstants;
	import com.mason.crushcockroach.elements.Cockroach;
	import com.mason.crushcockroach.elements.GameBackground;
	import com.mason.crushcockroach.events.NavigationEvent;
	import com.mason.crushcockroach.events.Operation;
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.ui.GameWindow;
	import com.mason.crushcockroach.ui.HUD;
	import starling.core.Starling;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class InGame extends GameWindow 
	{
		private var _isHardwareRendering:Boolean;
		
		private var _background:GameBackground;
		private var _pauseButton:Button;
		private var _startButton:Button;
		
		private var _hud:HUD;
		
		private var _gamePaused:Boolean;
		private var _gameState:int;
		
		private var _timePrevious:Number = 0;
		private var _timeCurrent:Number = 0;
		private var _elapsed:Number = 0;
		
		private var _cockroachContainer:Sprite;
		private var _cockroaches:Vector.<Cockroach>;
		private var _cockroachInScreen:int;
		private var _generateKeyPoint:Number = 0;
		
		private var _offsetX:int = 5;
		private var _offsetY:int = 5;
		
		public function InGame() 
		{
			super();
			
		}
		
		// public ////
		
		override public function show($parent:DisplayObjectContainer=null, childIndex:int = -1):void
		{
			super.show($parent, childIndex);
			
		}
		
		public function touchHandler(touch:Touch, pos:Point):void
		{
			if (touch.phase == TouchPhase.ENDED)
			{
				for each (var cockroach:Cockroach in _cockroaches)
				{
					if (hit(cockroach, pos))
					{
						cockroachKilled(cockroach);
					}
				}
			}
		}
		
		private function hit(cockroach:Cockroach, pos:Point):Boolean
		{
			if (((pos.x + _offsetX) >= cockroach.x && (pos.x - _offsetX) <= cockroach.x + cockroach.width) 
				&& ((pos.y + _offsetY) >= cockroach.y && (pos.y - _offsetY) <= cockroach.y + cockroach.height))
			{
				return true;
			}
			else
			{
				return false;
			}
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
			_isHardwareRendering = Starling.context.driverInfo.toLocaleLowerCase().indexOf("software") == -1;
			
			_background = new GameBackground();
			_background.touchable = false;
			
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
		
		// private ////
		
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
						cockroach.speed = GameConstants.COCKROACH_BASE_SPEED * Math.random();
						//
						if (_cockroachInScreen > 0 && _cockroachInScreen % 10 == 0)
						{
							cockroach.speed *= 4;
							cockroach.damage *= 4;
							cockroach.showDust();
						}
						
						_background.addChild(cockroach);
						
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
//					cockroach.speed -= (cockroach.speed - GameConstants.COCKROACH_BASE_SPEED) * .01;
					
					if (cockroach.x - cockroach.width > stage.stageWidth)
					{
						trace(cockroach.damage);
						_hud.lives -= cockroach.damage;
						
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
			_gamePaused = true;
			
			dispatchEventWith(NavigationEvent.CHANGE_SCREEN, true, { 
				operation: Operation.GAME_OVER, 
				score: _hud.killCount,
				duration: _hud.durationStr
			});
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