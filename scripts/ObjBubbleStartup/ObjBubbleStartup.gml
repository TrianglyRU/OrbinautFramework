function ObjBubbleStartup()
{
	// Set blank values
	BubbleType   = 0;
	WobbleOffset = 0;
	Collected	 = 0;
	FinalX		 = 0;
	Direction    = 0;
	
	// Set other variables
	PosX = x;
	PosY = y;
	Ysp  = -0.53125;
	
	// Set object depth
	object_set_depth(Player, true);
	
	// Set object unload type
	object_set_unload(TypeDelete);
}