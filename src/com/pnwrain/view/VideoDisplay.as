package com.pnwrain.view
{
	import flash.events.Event;
	import flash.media.Camera;
	
	import mx.controls.VideoDisplay;

	public class VideoDisplay extends mx.controls.VideoDisplay
	{
		public function VideoDisplay()
		{
			super();
			
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void {
			var cam:Camera = Camera.getCamera();
			cam.setMode(640,480,24,true);
			this.attachCamera(cam);
			
			this.rotationY = 180;
			this.x = this.width;
		}
		
	}
}