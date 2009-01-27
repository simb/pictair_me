package com.pnwrain.pictair_me.vo
{
	[Bindable]
	public class FilterProperty
	{
		public var name:String;
		public var value:String;
		
		public function FilterProperty(n:String, v:String)
		{
			this.name = n;
			this.value = v;
		}

	}
}