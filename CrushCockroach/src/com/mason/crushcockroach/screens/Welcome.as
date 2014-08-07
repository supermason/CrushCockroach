package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.events.NavigationEvent;
	import com.mason.crushcockroach.events.Operation;
	import com.mason.crushcockroach.font.Font;
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.res.Fonts;
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.ui.GameWindow;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Welcome extends GameWindow
	{
		public static const IN_MAIN:int = 0;
		public static const IN_ABOUT:int = 1;
		
		private var _bg:Image;
		private var _title:Image;
		private var _subTitle:Image;
		private var _playBtn:Button;
		private var _aboutBtn:Button;
		private var _backBtn:Button;
		private var _aboutFont:Font;
		private var _txtAbout:TextField;
		
		private var _cockroach:MovieClip;
		
		private var _currentDate:Date;
		
		private var _screenMode:int = Welcome.IN_MAIN;
		
		private var _startGameEvent:NavigationEvent;
		
		public function Welcome() 
		{
			super();
		}
		
		// public ////
		override public function show(parent:DisplayObjectContainer=null, childIndex:int=-1):void
		{
			super.show(parent, childIndex);
			
			screenState = Welcome.IN_MAIN;
			
			// play the backgournd music
			Sounds.play("sndBgMain", 0, 999);
			
			// animate cockroack
			addToJuggler(_cockroach);
		}
		
		override public function timeElapsed():void
		{
			_currentDate = new Date();
			
			_playBtn.rotation = Math.cos(_currentDate.getTime() * .002) * Math.PI / 360 * 10;
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_bg = new Image(Assets.getTexture("BgWelcome"));
			_bg.blendMode = BlendMode.NONE;
			
			_title = new Image(Assets.getAtlas().getTexture("title"));
			_title.x = 0;
			_title.y = 0;
			
			_subTitle = new Image(Assets.getAtlas().getTexture("subtitle"));
			_subTitle.x = 30;
			_subTitle.y = 0;
			
			_playBtn = new Button(Assets.getAtlas().getTexture("playButton"));
			_playBtn.pivotX = _playBtn.width / 2;
//			_playBtn.pivotY = _playBtn.height / 2;
			_playBtn.x = 830 + _playBtn.width * .5;
			_playBtn.y = 523;
			_aboutBtn = new Button(Assets.getAtlas().getTexture("aboutButton"));
			_aboutBtn.x = 8;
			_aboutBtn.y = 557;
			_backBtn = new Button(Assets.getAtlas().getTexture("backButton"));
			_backBtn.x = 8;
			_backBtn.y = 557;
			
			_aboutFont = Fonts.getFont("About");
			
			_txtAbout = new TextField(690, 175, "", _aboutFont.fontName, _aboutFont.fontSize, 0xffffff);
			_txtAbout.text = "My first game based on Straling-Framework, hope everyone enjoys it~";
			_txtAbout.x = 170;
			_txtAbout.y = 270;
			_txtAbout.hAlign = HAlign.CENTER;
			_txtAbout.vAlign = VAlign.TOP;
			_txtAbout.height = _txtAbout.textBounds.height + 20;
			
			_cockroach = new MovieClip(Assets.getAtlas().getTextures("cockroachInWelcome_"), 2);
			_cockroach.x = 190;
			_cockroach.y = 340;
			
			addChild(_bg);
			addChild(_title);
			addChild(_subTitle);
			addChild(_txtAbout);
			addChild(_playBtn);
			addChild(_aboutBtn);
			addChild(_backBtn);
			addChild(_cockroach);
		}
		
		override protected function addEvt():void
		{
			_playBtn.addEventListener(Event.TRIGGERED, triggerHandler);
			_aboutBtn.addEventListener(Event.TRIGGERED, triggerHandler);
			_backBtn.addEventListener(Event.TRIGGERED, triggerHandler);
		}
		
		override protected function removeEvt():void
		{
			_playBtn.removeEventListener(Event.TRIGGERED, triggerHandler);
			_aboutBtn.removeEventListener(Event.TRIGGERED, triggerHandler);
			_backBtn.removeEventListener(Event.TRIGGERED, triggerHandler);
		}
		
		// event handler ////
		protected function triggerHandler(event:Event):void
		{
			if (event.target == _playBtn)
			{
				Sounds.play("sndCoffee");
				
				if (!_startGameEvent) _startGameEvent = new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {"operation": Operation.PLAY});
				
				dispatchEvent(_startGameEvent);
			}
			else if (event.target == _aboutBtn)
			{
				Sounds.play("sndMushroom");
				
				screenState = Welcome.IN_ABOUT;
			}
			else if (event.target == _backBtn)
			{
				Sounds.play("sndCoffee");
				
				screenState = Welcome.IN_MAIN;
			}
		}
		
		// getter && setter ////
		private function set screenState(value:int):void
		{
			_screenMode = value;
			
			var inMain:Boolean = _screenMode == Welcome.IN_MAIN;
			
			_playBtn.visible = inMain;
			_aboutBtn.visible = inMain;
			_backBtn.visible = !inMain;
			
			_title.visible = inMain;
			_subTitle.visible = inMain;
			
			_txtAbout.visible = !inMain;
		}
		
	}

}