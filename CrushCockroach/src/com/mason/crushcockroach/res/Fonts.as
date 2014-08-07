package com.mason.crushcockroach.res 
{
	import com.mason.crushcockroach.font.Font;
	import flash.utils.Dictionary;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author Mason
	 */
	public class Fonts 
	{
		/**
		 *  Regular font used for About.
		 */	
		[Embed(source="/assets/fonts/fontInAbout.png")]
		public static const Font_In_About:Class;
		
		[Embed(source="/assets/fonts/fontInAbout.fnt", mimeType="application/octet-stream")]
		public static const XML_In_About:Class;
		
		/**
		 * Font for score label and score value. 
		 */	
		[Embed(source="/assets/fonts/fontInGame.png")]
		public static const Font_In_Game:Class;
		
		[Embed(source="/assets/fonts/fontInGame.fnt", mimeType="application/octet-stream")]
		public static const XML_In_Game:Class;
		
		/**
		 * Font objects.
		 */
		private static var _fonts:Dictionary = new Dictionary();
		
		/**
		 * Returns the BitmapFont (texture + xml) instance's fontName property (there is only oneinstance per app).
		 * @return String 
		 */
		public static function getFont(style:String):Font
		{
			if (!Fonts[style])
			{
				var texture:Texture = Texture.fromBitmap(new Fonts["Font_In_" + style]());
				var xml:XML = XML(new Fonts["XML_In_" + style]());
				Fonts[style] = new BitmapFont(texture, xml);
				
				TextField.registerBitmapFont(Fonts[style]);
			}
			
			if (!_fonts[style])
			{
				_fonts[style] = new Font(Fonts[style].name, Fonts[style].size);
			}
			
			return _fonts[style];
		}
		
	}

}