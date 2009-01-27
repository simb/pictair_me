package com.pnwrain.pictair_me.business
{
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	 
	public class MultipartRequest
	{
		public function MultipartRequest()
		{
			super();
			
			data = new URLVariables();
		}
		
		public var data:URLVariables;
		public var filename:String = "untitled";
		public var file:ByteArray;
		public var contentType:String = "image/jpeg";
		public var formname:String = "image";
		
		private var newline:String = "\r\n";
		private var prefix:String = "--";
		private var boundary:String = "----------Ij5ae0ae0KM7GI3KM7ei4cH2ei4gL6";
		
		public function getBoundary():String
		{
			return boundary;
		}
		
		private function p(arr:ByteArray, line:String=""):void
		{
			arr.writeUTFBytes(line);
			arr.writeUTFBytes(newline);
		}
		
		private function writeField(ed:ByteArray, name:String, value:String):void {
			p(ed, prefix+boundary);
			p(ed, 'Content-Disposition: form-data; name="' + name + '"');
			p(ed);
			p(ed, value);
		}
		
		private function writeFile(ed:ByteArray):void {
			p(ed, prefix+boundary);
			p(ed, 'Content-Disposition: form-data; name="' + formname + '"; filename="' + filename + '"');
			p(ed, "Content-Type: " + contentType);
			p(ed);
			writeFileData(ed);
			p(ed);
		}
		
		private function finalize(ed:ByteArray):void {
			p(ed, prefix+boundary+prefix);
		}
		
		public function getPostData():ByteArray
		{
			var ed:ByteArray = new ByteArray();
			
			if ( data != null )
			{
				for ( var prop:String in data )
				{
					var name:String = prop;
					var value:String = data[prop];
					
					writeField(ed, name, value);
				}
			}
			
			writeFile(ed);
			
			finalize(ed);
			
			ed.position = 0;
			
			return ed;
		}
		
		private function writeFileData(arr:ByteArray):void
		{
			if ( file != null )
			{
				file.position = 0;
				
				while ( file.bytesAvailable > 0 ) { 
					arr.writeByte( file.readByte() );
				}
			}
		}
	}
}