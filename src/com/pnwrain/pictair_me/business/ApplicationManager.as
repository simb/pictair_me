package com.pnwrain.pictair_me.business
{
	import flash.desktop.NativeApplication;
	
	public class ApplicationManager
	{
		[Bindable]
		public var appVersion:String;
		public function ApplicationManager()
		{
			getVersion();
		}
		
		private function getVersion():void {
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var air:Namespace = appXML.namespaceDeclarations()[0];
			appVersion = appXML.air::version;
		}
	}
}