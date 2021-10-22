function ObjAirBubblerStartup()
{
	/* Variable Definitions	
	1. GenerationSpeed, default = 1
	*/
	
	// Set blank values
	BubbleAmount = 0;
	BubbleID	 = 0;
	LargeID		 = 0;
	ChosenSet    = 0;
	State        = 0;
	
	// Set other variables
	Cycle = 1;
	Delay = irandom_range(128, 255);
	
	// Define bubble sets
	BubbleSet[0] = [0,0,0,0,1,0];
	BubbleSet[1] = [0,0,0,1,0,0];
	BubbleSet[2] = [1,0,1,0,0,0];
	BubbleSet[3] = [0,1,0,0,1,0];
	
	// Set object unload type
	object_set_unload(TypeReset);
	
	// Set animation
	animation_play(sprite_index, 16, 0, 0);
}