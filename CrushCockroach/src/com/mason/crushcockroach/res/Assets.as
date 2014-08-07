package com.mason.crushcockroach.res 
{
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * ...
	 * @author Mason
	 */
	public class Assets 
	{
		[Embed(source="/assets/graphics/gameSpritesheet.png")]
		public static const GameAtlasTexture:Class;
		
		[Embed(source="/assets/graphics/gameSpritesheet.xml", mimeType="application/octet-stream")]
		public static const GameAtlasXML:Class;
		
		[Embed(source="/assets/graphics/bgWelcome.jpg")]
		public static const BgWelcome:Class;
		
		private static var _gameTextures:Dictionary = new Dictionary();
		private static var _gameAtlasTexture:TextureAtlas;
		
		/**
		 * Returns the Texture atlas instance.
		 * @return the TextureAtlas instance (there is only oneinstance per app)
		 */
		public static function getAtlas():TextureAtlas
		{
			if (!_gameAtlasTexture)
			{
				_gameAtlasTexture = new TextureAtlas(getTexture("GameAtlasTexture"), XML(new GameAtlasXML()));
			}
			
			return _gameAtlasTexture;
		}
		
		/**
		 * Returns a texture from this class based on a string key.
		 * 
		 * @param name A key that matches a static constant of Bitmap type.
		 * @return a starling texture.
		 */
		public static function getTexture(name:String):Texture
		{
			if (!_gameTextures[name])
			{
				_gameTextures[name] = Texture.fromBitmap(new Assets[name]());
			}
			
			return _gameTextures[name];
		}
		
	}

}