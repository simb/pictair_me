package com.pnwrain.pictair_me.vo
{
	import flash.filesystem.File;
	
	[Bindable]
	public class Picture extends com.pnwrain.pictair_me.vo.File
	{	
		public function Picture(file:flash.filesystem.File)
		{
			super(file);
		}

	}
}