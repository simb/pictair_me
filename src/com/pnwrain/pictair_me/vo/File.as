package com.pnwrain.pictair_me.vo
{
	import flash.filesystem.File;
	
	[Bindable]
	public class File
	{
		public var url:String;
		public var name:String;
		public var nativePath:String;
		
		public function File(file:flash.filesystem.File)
		{
			if (file) {
				url = file.url;
				name = file.name;
				nativePath = file.nativePath;
			}
		}
		public function get fileName():String {
			var a:Array = name.split(".");
			return a[0];
		}
	}
}