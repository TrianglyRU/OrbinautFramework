function ObjBubbleStartup()
{
	// Create variables
	Ysp			 = 0;
	BubbleType   = 0;
	WobbleOffset = 0;
	Collected	 = 0;
	FinalX		 = 0;
	PosX		 = 0;
	PosY		 = 0;
	Direction    = 0;
	
	// Set default position and speed
	PosX = x;
	PosY = y;
	Ysp  = -0.53125;
	
	// Set object depth
	object_set_depth(Player, true);
	
	// Set object active range
	object_set_range(RangeClose, TypeDelete);
}