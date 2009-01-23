package com.pnwrain.pictair_me.view
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.components.baseClasses.FxComponent;
	
	[SkinStates("Base", "Three", "Two", "One")]
	[Event(name="countDownStart")]
	[Event(name="countDownCancel")]
	[Event(name="countDownEnd")]
	public class CountDownTimer extends FxComponent
	{
		private var counter:Number;
		private var timer:Timer = new Timer(1000, 4);
		
		public function CountDownTimer()
		{
			super();
			timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
		}
		
		public function countDown():void {
			timer.start()
			var event:Event = new Event("countDownStart");
			dispatchEvent(event);
		}
		public function cancel():void {
			timer.stop();
			timer.reset();
			var event:Event = new Event("countDownCancel");
			dispatchEvent(event);
		}
		
		private function onTimerTick(event:TimerEvent):void {
			if ( isNaN(counter) ) {
				counter = 3;
			} else {
				counter--;
			}
			invalidateSkinState();
			
		}
		private function onTimerComplete(event:TimerEvent):void {
			counter = NaN;
			timer.reset();
			invalidateSkinState();
			var e:Event = new Event("countDownEnd");
			dispatchEvent(e);
		}
		
		
		
		override protected function getCurrentSkinState():String
	    {
	        switch (counter) {
	        	case 3:
	        		return "Three";
	        		break;
	        	case 2:
	        		return "Two";
	        		break;
	        	case 1:
	        		return "One";
	        		break;
	        	default:
	        		return "Base";
	        		break;
	        	
	        }
	    }
	}
}