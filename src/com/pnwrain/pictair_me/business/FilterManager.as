package com.pnwrain.pictair_me.business
{
	import com.pnwrain.pictair_me.vo.Filter;
	import com.pnwrain.pictair_me.vo.FilterProperty;
	
	import flash.display.Shader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filters.ShaderFilter;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	
	public class FilterManager
	{
		private const filterDirectory:File = File.applicationDirectory.resolvePath("com/pnwrain/pictair_me/filter/");
		[Bindable]
		public var filters:ArrayCollection;
		private const NO_FILTER:String = "No Filter Selected";
		//private var filterFiles:Dictionary;
		public function FilterManager()
		{
			loadFilters();
		}
		
		public function loadFilters():void{
			
			var files:Array = filterDirectory.getDirectoryListing();
			filters = new ArrayCollection();
			//add a blank item to the front of the list
			var f:Filter = new Filter();
			f.name = NO_FILTER;
			filters.addItem(f); 
			//Add the rest of the filters
			for ( var i:int=0;i<files.length;i++) {
				if ( File(files[i]).extension == "pbj" ) {
					var filter:Filter = new Filter(files[i] as File);
					filters.addItem( filter );
					var filterConfig:File = filterDirectory.resolvePath(filter.fileName + '-config.xml');
					if ( filterConfig.exists ) {
						var fs:FileStream = new FileStream();
						fs.open(filterConfig,FileMode.READ);
						filter.loadProperties( new XML(fs.readUTFBytes(fs.bytesAvailable)) );
					}
				}
			}
		}
		//returns array of ShaderFilter objects
		public function getFilter(filter:Filter):Array {
			if ( filter.name != NO_FILTER) {
				
				var fileStream:FileStream = new FileStream();
				var byteData:ByteArray = new ByteArray();
				var file:File = new File(filter.nativePath);
				fileStream.open(file, FileMode.READ);
				fileStream.readBytes(byteData, 0, file.size);
	     		fileStream.close();
				var shader:Shader = new Shader(byteData);
				//filter.properties is initialized as [] so we can loop over nothing safely
				for ( var i:int=0; i<filter.properties.length; i++) {
					var fc:FilterProperty = filter.properties[i]
					shader.data[fc.name].value[0] = parseFloat(fc.value);
				}
				//for now just return the shadefilter. Later implement loading settings.
				return [new ShaderFilter(shader)];
			} else {
				return []
			}
		}
	}
}