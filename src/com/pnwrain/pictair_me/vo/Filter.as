package com.pnwrain.pictair_me.vo
{
	import flash.filesystem.File;
	
	[Bindable]
	public class Filter extends com.pnwrain.pictair_me.vo.File
	{	
		public var filterName:String;
		public var properties:Array = [];
		
		public function Filter(file:flash.filesystem.File=null)
		{
			super(file);
		}
		
		public function loadProperties(xml:XML):void {
			filterName = xml..name;
			var tp:XMLList = xml.properties.children();
			for each (var prop:XML in tp)
			{
				properties.push(new FilterProperty(prop.name(), prop) );
			}
		}
		
		public function get displayName():String {
			//if a property file set our filtername property display that. Otherwise just use the filter file name
			if ( filterName != null ) {
				return filterName;
			} else {
				return fileName;
			}
			
		}
	}
}