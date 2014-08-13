package com.mason.crushcockroach.elements
{
	import com.mason.crushcockroach.objPool.IPoolable;
	
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	
	/**
	 * @author Mason
	 * @version 1.0.0
	 * create-time Aug 13, 2014 10:04:43 AM
	 * description 
	 **/
	public class Particle extends PDParticleSystem implements IPoolable
	{
		public function Particle(config:XML, texture:Texture)
		{
			super(config, texture);
		}
	}
}