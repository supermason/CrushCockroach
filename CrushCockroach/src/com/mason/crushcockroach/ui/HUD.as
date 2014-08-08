package com.mason.crushcockroach.ui 
{
	import com.mason.crushcockroach.font.Font;
	import com.mason.crushcockroach.res.Fonts;
	import com.mason.crushcockroach.utils.StringUtil;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	/**
	 * ...
	 * @author Mason
	 */
	public class HUD extends GameSprite 
	{
		private var _lives:int;
		private var _killCount:int;
		private var _duration:int;
		
		private var _txtLivesLbl:TextField;
		private var _txtLives:TextField;
		
		private var _txtKillCountLbl:TextField;
		private var _txtKillCount:TextField;
		
		private var _txtDurationLbl:TextField;
		private var _txtDuration:TextField;
		
		private var _font:Font;
		
		public function HUD() 
		{
			super();
			
		}
		
		override protected function drawScreen():void 
		{
			// Get font for 
			_font = Fonts.getFont("Game");
			
			_txtLivesLbl = new TextField(150, 40, "lives", _font.fontName, _font.fontSize, 0xffffff);
			_txtLivesLbl.hAlign = HAlign.LEFT;
			_txtLivesLbl.vAlign = VAlign.TOP;
			_txtLivesLbl.x = 150;
			_txtLivesLbl.y = 5;
			
			_txtLives = new TextField(150, 75, "5", _font.fontName, _font.fontSize, 0xffffff);
			_txtLives.hAlign = HAlign.LEFT;
			_txtLives.vAlign = VAlign.TOP;
			_txtLives.width = _txtLivesLbl.width;
			_txtLives.x = int(_txtLivesLbl.x + _txtLivesLbl.width - _txtLives.width);
			_txtLives.y = _txtLivesLbl.y + _txtLivesLbl.height;
			
			_txtKillCountLbl = new TextField(150, 40, "kill", _font.fontName, _font.fontSize, 0xffffff);
			_txtKillCountLbl.hAlign = HAlign.LEFT;
			_txtKillCountLbl.vAlign = VAlign.TOP;
			_txtKillCountLbl.x = (stage.stageWidth - _txtKillCountLbl.width) * .5;
			_txtKillCountLbl.y = 5;
			
			_txtKillCount = new TextField(150, 75, "0", _font.fontName, _font.fontSize, 0xffffff);
			_txtKillCount.hAlign = HAlign.LEFT;
			_txtKillCount.vAlign = VAlign.TOP;
			_txtKillCount.width = _txtKillCountLbl.width;
			_txtKillCount.x = int(_txtKillCountLbl.x + _txtKillCountLbl.width - _txtKillCount.width);
			_txtKillCount.y = _txtKillCountLbl.y + _txtKillCountLbl.height;
			
			_txtDurationLbl = new TextField(150, 40, "duration", _font.fontName, _font.fontSize, 0xffffff);
			_txtDurationLbl.hAlign = HAlign.LEFT;
			_txtDurationLbl.vAlign = VAlign.TOP;
			_txtDurationLbl.x = int(stage.stageWidth - _txtDurationLbl.width - 100);
			_txtDurationLbl.y = 5;
			
			_txtDuration = new TextField(150, 75, "00:00", _font.fontName, _font.fontSize, 0xffffff);
			_txtDuration.hAlign = HAlign.LEFT;
			_txtDuration.vAlign = VAlign.TOP;
			_txtDuration.width = _txtDurationLbl.width;
			_txtDuration.x = int(_txtDurationLbl.x + _txtDurationLbl.width - _txtDuration.width);
			_txtDuration.y = _txtDurationLbl.y + _txtDurationLbl.height;
			
			addChild(_txtLivesLbl);
			addChild(_txtLives);
			addChild(_txtKillCountLbl);
			addChild(_txtKillCount);
			addChild(_txtDurationLbl);
			addChild(_txtDuration);
		}
		
		// getter && setter ////
		public function get lives():int 
		{
			return _lives;
		}
		
		public function set lives(value:int):void 
		{
			_lives = value;
			
			_txtLives.text = _lives.toString();
		}
		
		public function get killCount():int 
		{
			return _killCount;
		}
		
		public function set killCount(value:int):void 
		{
			_killCount = value;
			
			_txtKillCount.text = _killCount.toString();
		}
		
		public function get duration():int 
		{
			return _duration;
		}
		
		public function set duration(value:int):void 
		{
			_duration = value;
			
			_txtDuration.text = StringUtil.getSecondStr(value);
		}
		
	}

}