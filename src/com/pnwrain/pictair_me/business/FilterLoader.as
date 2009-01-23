package com.pnwrain.pictair_me.business
{
	import flash.display.Shader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;

	public class FilterLoader
	{
		[Bindable]
		public var filters:ArrayCollection;
		
		private var filterFiles:Dictionary;
		public function FilterLoader()
		{
		}
		
		public function loadFilters():void{
			var filterDirectory:File = File.applicationDirectory.resolvePath("com/pnwrain/pictair_me/filter/");
			var files:Array = filterDirectory.getDirectoryListing();
			filterFiles = new Dictionary();
			filters = new ArrayCollection();
			for ( var i:int=0;i<files.length;i++) {
				filterFiles[files[i].name] = files[i];
				filters.addItem( files[i].name );
			}
		}
		public function getFilter(filterName:String):Shader {
			var fileStream:FileStream = new FileStream();
			var byteData:ByteArray = new ByteArray();
			fileStream.open(filterFiles[filterName], FileMode.READ);
			fileStream.readBytes(byteData, 0, filterFiles[filterName].size);
     		fileStream.close();
			var shader:Shader = new Shader(byteData);
			return shader;
		}
	}
}