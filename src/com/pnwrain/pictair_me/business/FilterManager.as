package com.pnwrain.pictair_me.business
{
	import flash.display.Shader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayCollection;
	
	public class FilterManager
	{
		[Bindable]
		public var filters:ArrayCollection;
		private const NO_FILTER:String = "No Filter Selected";
		private var filterFiles:Dictionary;
		public function FilterManager()
		{
			loadFilters();
		}
		
		public function loadFilters():void{
			var filterDirectory:File = File.applicationDirectory.resolvePath("com/pnwrain/pictair_me/filter/");
			var files:Array = filterDirectory.getDirectoryListing();
			filterFiles = new Dictionary();
			filters = new ArrayCollection();
			filters.addItem(NO_FILTER); //add a blank item to the front of the list
			for ( var i:int=0;i<files.length;i++) {
				filterFiles[files[i].name] = files[i];
				filters.addItem( files[i].name );
			}
		}
		//returns array of ShaderFilter objects
		public function getFilter(filterName:String):Array {
			if ( filterName != NO_FILTER) {
				
				var fileStream:FileStream = new FileStream();
				var byteData:ByteArray = new ByteArray();
				fileStream.open(filterFiles[filterName], FileMode.READ);
				fileStream.readBytes(byteData, 0, filterFiles[filterName].size);
	     		fileStream.close();
				var shader:Shader = new Shader(byteData);
				
				//for now just return the shadefilter. Later implement loading settings.
				return [new ShaderFilter(shader)];
			} else {
				return []
			}
		}
	}
}