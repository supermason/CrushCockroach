package com.mason.crushcockroach 
{
	/**
	 * ...
	 * @author Mason
	 */
	public class GameConstants 
	{
		
		// Player's states - what is the player doing? -------------
		
		public static const GAME_STATE_IDLE:int = 0;
		public static const GAME_STATE_PLAYING:int = 1;
		public static const GAME_STATE_OVER:int = 2;
		
		
		// Cockroack properties ------------------------------------
		
		public static const MIN_COCKROACH_IN_SCREEN:int = 30;
		public static const MAX_COCKROACH_IN_SCREEN:int = 200;
		public static const AVERAGE_GENERATION_COUNT:int = 10;
		public static const GENERATE_FREQUENCY:int = 2;
		public static const COCKROACH_BASE_SPEED:Number = 100;
		
		// cockroachs' state ---------------------------------------
		
		public static const COCKROACH_ALIVE:int = 1;
		public static const COCKROACH_DEAD:int = 2;
		public static const COCKROACH_REFREEZING:int = 3;
	}

}