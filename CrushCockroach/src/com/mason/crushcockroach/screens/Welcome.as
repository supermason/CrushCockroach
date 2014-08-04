package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.ui.GameSprite;
	import com.mason.crushcockroach.font.Font;
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.res.Fonts;
	import com.mason.crushcockroach.res.Sounds;
	import starling.display.DisplayObjectContainer;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class Welcome extends GameSprite
	{
		public static const IN_MAIN:int = 0;
		public static const IN_ABOUT:int = 1;
		
		private var _bg:Image;
		private var _title:Image;
		private var _subTitle:Image;
		private var _startBtn:Button;
		private var _aboutBtn:Button;
		private var _backBtn:Button;
		private var _cockroach:Image;
		private var _aboutFont:Font;
		private var _txtAbout:TextField;
		
		private var _screenMode:int = Welcome.IN_MAIN;
		
		public function Welcome() 
		{
			super();
		}
		
		// public ////
		override public function show(parent:DisplayObjectContainer):void
		{
			super.show(parent);
			
			screenState = Welcome.IN_MAIN;
			
			// play the backgournd music
			Sounds.play("sndBgMain", 0, 999);
		}
		
		// protected ////
		override protected function drawScreen():void
		{
			_bg = new Image(Assets.getTexture("BgWelcome"));
			_bg.blendMode = BlendMode.NONE;
			
			_title = new Image(Assets.getAtlas().getTexture("title"));
			_title.x = 205;
			_title.y = 255;
			
			_subTitle = new Image(Assets.getAtlas().getTexture("subtitle"));
			_subTitle.x = 425;
			_subTitle.y = 444;
			
			_startBtn = new Button(Assets.getAtlas().getTexture("startButton"));
			_startBtn.x = 830;
			_startBtn.y = 523;
			_aboutBtn = new Button(Assets.getAtlas().getTexture("aboutButton"));
			_aboutBtn.x = 8;
			_aboutBtn.y = 557;
			_backBtn = new Button(Assets.getAtlas().getTexture("backButton"));
			_backBtn.x = 8;
			_backBtn.y = 557;
			
			_aboutFont = Fonts.getFont("About");
			
			_txtAbout = new TextField(690, 175, "", _aboutFont.fontName, _aboutFont.fontSize);
			_txtAbout.text = "My first game based on Straling-Framework, hope everyone enjoys it~";
			_txtAbout.x = 200;
			_txtAbout.y = 270;
			_txtAbout.hAlign = HAlign.CENTER;
			_txtAbout.vAlign = VAlign.TOP;
			_txtAbout.height = _txtAbout.textBounds.height + 20;
			
			addChild(_bg);
			addChild(_title);
			addChild(_subTitle);
			addChild(_txtAbout);
			addChild(_startBtn);
			addChild(_aboutBtn);
			addChild(_backBtn);
		}
		
		override protected function addEvt():void
		{
			_startBtn.addEventListener(Event.TRIGGERED, triggerHandler);
			_aboutBtn.addEventListener(Event.TRIGGERED, triggerHandler);
			_backBtn.addEventListener(Event.TRIGGERED, triggerHandler);
		}
		
		// event handler ////
		protected function triggerHandler(event:Event):void
		{
			if (event.target == _startBtn)
			{
				Sounds.play("sndCoffee");
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
			
			_startBtn.visible = inMain;
			_aboutBtn.visible = inMain;
			_backBtn.visible = !inMain;
			
			_title.visible = inMain;
			_subTitle.visible = inMain;
			
			_txtAbout.visible = !inMain;
		}
		
	}

}