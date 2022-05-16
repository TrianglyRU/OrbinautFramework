/// @description Startup
// You can write your code in this editor
	
	/* Variable Definitions	
	1. AirFrequency, default = 1
	*/
	
	// Subfunction
	function AirBubbler_SetDelayTime()
	{
		return irandom_range(128, 255);
	}
	
	Delay		 = AirBubbler_SetDelayTime();
	Cycle		 = 1;
	BubbleAmount = 0;
	BubbleID	 = 0;
	LargeID		 = 0;
	ChosenSet    = 0;
	State        = 0;
	
	// 0 - small bubble, 1 - medium bubble
	BubbleSet[0] = [0,0,0,0,1,0];
	BubbleSet[1] = [0,0,0,1,0,0];
	BubbleSet[2] = [1,0,1,0,0,0];
	BubbleSet[3] = [0,1,0,0,1,0];
	
	// Set object properties
	object_set_unload(FlagReset);
	animation_play(sprite_index, 16, 0);