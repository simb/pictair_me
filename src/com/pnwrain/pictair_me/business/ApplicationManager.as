package com.pnwrain.pictair_me.business
{
	import air.update.ApplicationUpdaterUI;
	import air.update.events.UpdateEvent;
	
	import flash.desktop.NativeApplication;
	import flash.events.ErrorEvent;
	
	import mx.controls.Alert;
	
	public class ApplicationManager
	{
		[Bindable]
		public var appVersion:String;
		private var appUpdater:ApplicationUpdaterUI = new ApplicationUpdaterUI();
			
		public function ApplicationManager()
		{
			getVersion();
			//checkUpdate();
		}
		
		private function getVersion():void {
			var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
			var air:Namespace = appXML.namespaceDeclarations()[0];
			appVersion = appXML.air::version;
		}
		private function checkUpdate():void {
			// we set the URL for the update.xml file
            appUpdater.updateURL = "http://picture_me.pnwrain.com/update/update.xml";
            //we set the event handlers for INITIALIZED nad ERROR
            appUpdater.addEventListener(UpdateEvent.INITIALIZED, onUpdate);
            appUpdater.addEventListener(ErrorEvent.ERROR, onError);
            //we can hide the dialog asking for permission for checking for a new update;
            
            //by default all the dialogs are hidden
			appUpdater.isCheckForUpdateVisible = false;
			appUpdater.isDownloadUpdateVisible = true;
			appUpdater.isDownloadProgressVisible = true;
			appUpdater.isInstallUpdateVisible = true;
			
            //we initialize the updater
            appUpdater.initialize();
	            
		}
		private function onUpdate(event:UpdateEvent):void
		{
			 appUpdater.checkNow();
		}
		private function onError(event:ErrorEvent):void {
            Alert.show(event.toString());
        }
	}
}