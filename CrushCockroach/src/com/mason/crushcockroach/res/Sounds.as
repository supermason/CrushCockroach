
package com.mason.crushcockroach.res 
{
	import flash.media.Sound;
	import flash.media.SoundMixer;

	/**
	 * This class holds all the sound embeds and objects that are used in the game. 
	 * 
	 * @author hsharma
	 * 
	 */
	public class Sounds
	{
		/**
		 * Embedded sound files. 
		 */		
		[Embed(source="/assets/sounds/bgGame.mp3")]
		public static const SND_BG_GAME:Class;
		
		[Embed(source="/assets/sounds/bgWelcome.mp3")]
		public static const SND_BG_MAIN:Class;
		
		[Embed(source="/assets/sounds/eat.mp3")]
		public static const SND_EAT:Class;
		
		[Embed(source="/assets/sounds/coffee.mp3")]
		public static const SND_COFFEE:Class;
		
		[Embed(source="/assets/sounds/mushroom.mp3")]
		public static const SND_MUSHROOM:Class;
		
		[Embed(source="/assets/sounds/hit.mp3")]
		public static const SND_HIT:Class;
		
		[Embed(source="/assets/sounds/hurt.mp3")]
		public static const SND_HURT:Class;
		
		[Embed(source="/assets/sounds/lose.mp3")]
		public static const SND_LOSE:Class;
		
		/**
		 * Initialized Sound objects. 
		 */		
		public static var sndBgMain:Sound = new Sounds.SND_BG_MAIN() as Sound;
		public static var sndBgGame:Sound = new Sounds.SND_BG_GAME() as Sound;
		public static var sndEat:Sound = new Sounds.SND_EAT() as Sound;
		public static var sndCoffee:Sound = new Sounds.SND_COFFEE() as Sound;
		public static var sndMushroom:Sound = new Sounds.SND_MUSHROOM() as Sound;
		public static var sndHit:Sound = new Sounds.SND_HIT() as Sound;
		public static var sndHurt:Sound = new Sounds.SND_HURT() as Sound;
		public static var sndLose:Sound = new Sounds.SND_LOSE() as Sound;
		
		/**
		 * Sound mute status. 
		 */
		private static var _muted:Boolean = false;
		
		/**
		 * Play a sound by name. 
		 * <p>If the sound does not exsit, an error will occur!
		 * <p>If it's in mute status, no sound will be played.
		 * @param	soundName
		 * @param	startTime
		 * @param	loop
		 */
		public static function play(soundName:String, startTime:Number=0, loop:int=0):void
		{
			if (!_muted)
			{
				Sounds[soundName].play(startTime, loop);
			}
		}
		
		
		// getter && setter ////
		/**
		 * Sound mute status. 
		 */
		static public function get muted():Boolean 
		{
			return _muted;
		}
		
		static public function set muted(value:Boolean):void 
		{
			_muted = value;
			
			if (_muted) SoundMixer.stopAll();
		}
	}
}