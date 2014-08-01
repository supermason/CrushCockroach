package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import starling.core.Starling;
	
	/**
	 * SWF meta data defined for iPad 1 & 2 in landscape mode. 
	 */	
	[SWF(frameRate = "60", width = "1024", height = "768", backgroundColor = "0x000000")]
	
	/** 
	 * @author: mason
	 * @E-mail: jijiiscoming@hotmail.com
	 * @version 1.0.0 
	 * 创建时间：Jul 31, 2014 3:32:00 PM 
	 * 描述：
	 * */
	public class CrushCockroach extends Sprite
	{
		/** Starling object. */
		private var myStarling:Starling;
		
		public function CrushCockroach()
		{
			super();
			
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
			
			
		}
	}
}