package com.pnwrain.pictair_me.view
{
	import flash.events.Event;
	import flash.media.Camera;

	import mx.controls.Alert;
	import mx.controls.VideoDisplay;

	public class VideoDisplay extends mx.controls.VideoDisplay
	{

		public function VideoDisplay()
		{
			super();


			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			var cam:Camera=Camera.getCamera();

			//BUG: We always get a camera here. Even if its in use.
			if (cam)
			{
				cam.setMode(640, 480, 24, true);
				this.attachCamera(cam);
			}
			else
			{
				Alert.show("Web Cam Not Available");
			}


			this.rotationY=180;
			this.x=this.width;
		}

	}
}

