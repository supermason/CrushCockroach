package com.mason.crushcockroach.objPool 
{
	import com.mason.crushcockroach.GameConstants;
	import com.mason.crushcockroach.elements.Cockroach;
	/**
	 * ...
	 * @author Mason
	 */
	public class CockroachPool 
	{
		private var _cockroachCache:ObjPool;
		
		public function CockroachPool() 
		{
			_cockroachCache = new ObjPool(create, clean);
		}
		
		// private ////
		private function create():Cockroach
		{
			var cockroach:Cockroach = new Cockroach();
			cockroach.activate();
			return cockroach;
		}
		
		private function clean(cockroach:Cockroach):void
		{
			cockroach.state = GameConstants.COCKROACH_DEAD;
			cockroach.dead();
		}
		
		// getter && setter ////
		public function get cache():ObjPool
		{
			return _cockroachCache;
		}
	}

}