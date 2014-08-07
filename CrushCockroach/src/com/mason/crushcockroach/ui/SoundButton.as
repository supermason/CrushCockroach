package com.mason.crushcockroach.ui {
	import com.mason.crushcockroach.res.Assets;
	import com.mason.crushcockroach.utils.AnimationHelper;
	
	import flash.display.BitmapData;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author Mason
	 */
	public class SoundButton extends Button 
	{
		public static const MUTE:int = 0;
		public static const UMUTE:int = 1;
		
		/** Animation shown when sound is playing.  */
		private var _umuteState:MovieClip;
		
		/** Image shown when the sound is muted. */
		private var _muteState:Image;
		
		public function SoundButton() 
		{
			super(Texture.fromBitmapData(new BitmapData(Assets.getAtlas().getTexture("sounds_off").width, Assets.getAtlas().getTexture("sounds_off").height, true, 0x0)));
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		/**
		 * On added to stage. 
		 * @param event
		 * 
		 */
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			setButtonTextures();
			soundButtonState = UMUTE;
		}
		
		/**
		 * Set textures for button states. 
		 * 
		 */
		private function setButtonTextures():void
		{
			// Normal state - image
			_umuteState = new MovieClip(Assets.getAtlas().getTextures("sounds_on_"), 3);
			this.addChild(_umuteState);
			
			// Selected state - animation
			_muteState = new Image(Assets.getAtlas().getTexture("sounds_off"));
			this.addChild(_muteState);
		}
		
		// getter && setter ////
		    
		/**
		 * Show Off/On State
		 */
		public function set soundButtonState(value:int):void
		{
			var mute:Boolean = value == MUTE;
			
			_umuteState.visible = !mute;
			_muteState.visible = mute;
			
			if (mute)
			{
				AnimationHelper.removeFromJuggler(_umuteState);
			}
			else
			{
				AnimationHelper.addToJuggler(_umuteState);
			}
		}
	}

}