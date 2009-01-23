package com.pnwrain.pictair_me.view
{
	import mx.components.baseClasses.FxComponent;
	
	[SkinStates("Base", "Three", "Two", "One")]
	
	public class CountDownTimer extends FxComponent
	{
		private var skinState:String = "Base";
		
		public function CountDownTimer()
		{
			super();
			
			//currentState = "Three";
		}
		override public function set currentState(stateName:String):void {
			setCurrentState(stateName);
		}
		override public function setCurrentState(stateName:String, playTransition:Boolean=true):void {
			super.setCurrentState(stateName, playTransition);
			skinState = stateName;
		}
		override protected function getCurrentSkinState():String
	    {
	        return skinState;
	    }
	}
}