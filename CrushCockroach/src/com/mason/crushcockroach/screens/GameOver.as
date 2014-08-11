package com.mason.crushcockroach.screens 
{
	import com.mason.crushcockroach.events.NavigationEvent;
	import com.mason.crushcockroach.events.Operation;
	import com.mason.crushcockroach.font.Font;
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.res.Fonts;
	import com.mason.crushcockroach.res.Sounds;
	import com.mason.crushcockroach.ui.GameWindow;
	
	import starling.display.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.VAlign;

	/**
	 * ...
	 * @author Mason
	 */
	public class GameOver extends GameWindow 
	{
		private var _bg:Quad;
		private var _bgImage:Image;
		private var _txtMessage:TextField;
		private var _scoreContainer:Sprite;
		private var _txtDuration:TextField;
		private var _txtScore:TextField;
		
		private var _btnPlayAgain:Button;
		private var _btnBackToMain:Button;
		private var _btnAbout:Button;
		
		private var _font:Font;
		
		public function GameOver() 
		{
			super();
			
		}
		
		// public ////
		override public function show($parent:DisplayObjectContainer = null, childIndex:int = -1):void
		{
			super.show($parent, childIndex);
			
			this.alpha = 0;
		}
		
		public function setResult(score:int, duration:String):void
		{
			_txtScore.text = "your score: " + score;
			_txtDuration.text = "your duration: " + duration;
		}
		
		// protected ////
		
		override protected function drawScreen():void
		{
			_font = Fonts.getFont("Game");
			
			_bg = new Quad(stage.stageWidth, stage.stageHeight, 0x000000);
			_bg.alpha = .75;
			addChild(_bg);
			
			_bgImage = new Image(Assets.getTexture("BgGameOver"));
			_bgImage.x = (stage.stageWidth - _bgImage.width) * .5;
//			_bgImage.y = (stage.stageHeight - _bgImage.height) * .5;
			addChild(_bgImage);
			
			_txtMessage = new TextField(stage.stageWidth, stage.stageHeight * .5, "You thrown up!", _font.fontName, _font.fontSize * 2, 0xff0000);
//			_txtMessage.vAlign = VAlign.TOP;
//			_txtMessage.height = _txtMessage.textBounds.height;
//			_txtMessage.y = (stage.stageHeight * 20) / 100;
			addChild(_txtMessage);
			
			_scoreContainer = new Sprite();
			_scoreContainer.y = (stage.stageHeight * 40) / 100;
			addChild(_scoreContainer);
			
			_txtDuration = new TextField(stage.stageWidth, 100, "your duration: 00:00:00", _font.fontName, _font.fontSize, 0xffffff);
			_txtDuration.vAlign = VAlign.TOP;
//			_txtDuration.height = _txtDuration.textBounds.height;
			_scoreContainer.addChild(_txtDuration);
			
			_txtScore = new TextField(stage.stageWidth, 100, "your score: 000000", _font.fontName, _font.fontSize, 0xffffff);
			_txtScore.vAlign = VAlign.TOP;
//			_txtScore.height = _txtScore.textBounds.height;
			_txtScore.y = _txtDuration.bounds.bottom - _txtScore.textBounds.height;
			_scoreContainer.addChild(_txtScore);
			
			_btnBackToMain = new Button(Assets.getAtlas().getTexture("mainButton"));
			_btnBackToMain.y = (stage.stageHeight * 70) / 100;
			addChild(_btnBackToMain);
			
			_btnPlayAgain = new Button(Assets.getAtlas().getTexture("playAgainButton"));
			_btnPlayAgain.y = _btnBackToMain.y + _btnBackToMain.height * .5 - _btnPlayAgain.height * .5;
			addChild(_btnPlayAgain);
			
			_btnAbout =  new Button(Assets.getAtlas().getTexture("aboutButton"));
			_btnAbout.y = _btnPlayAgain.y + _btnPlayAgain.height * .5 - _btnAbout.height * .5;
			addChild(_btnAbout);
			
			_btnBackToMain.x = stage.stageWidth * .5 - (_btnBackToMain.width + _btnPlayAgain.width + _btnAbout.width + 30) * .5;
			_btnPlayAgain.x = _btnBackToMain.bounds.right + 10;
			_btnAbout.x = _btnPlayAgain.bounds.right + 10;
			
		}
		
		override protected function addEvt():void
		{
			super.addEvt();
			
			_btnBackToMain.addEventListener(Event.TRIGGERED, triggeredHandler);
			_btnPlayAgain.addEventListener(Event.TRIGGERED, triggeredHandler);
			_btnAbout.addEventListener(Event.TRIGGERED, triggeredHandler);
		}
		
		override protected function removeEvt():void
		{
			super.removeEvt();
			
			_btnBackToMain.removeEventListener(Event.TRIGGERED, triggeredHandler);
			_btnPlayAgain.removeEventListener(Event.TRIGGERED, triggeredHandler);
			_btnAbout.removeEventListener(Event.TRIGGERED, triggeredHandler);
		}
		
		// event handler ////
		private function triggeredHandler(event:Event):void 
		{
			Sounds.play("sndMushroom");
			
			if (event.target == _btnBackToMain)
			{
				dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { "operation": Operation.BACK_TO_WELCOME } ));
			}
			else if (event.target == _btnPlayAgain)
			{
				dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { "operation": Operation.PLAY_AGAIN } ));
			}
			else if (event.target == _btnAbout)
			{
				dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { "operation": Operation.JUMP_TO_ABOUT }));
			}
		}
		
	}

}