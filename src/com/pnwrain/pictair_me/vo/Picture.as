package com.pnwrain.pictair_me.vo
{
	import flash.filesystem.File;
	
	[Bindable]
	public class Picture
	{
		public var url:String;
		public var name:String;
		public var nativePath:String;
		
		public function Picture(file:File)
		{
			url = file.url;
			name = file.name;
			nativePath = file.nativePath;
		}

	}
}