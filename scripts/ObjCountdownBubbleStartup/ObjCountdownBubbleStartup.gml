function ObjCountdownBubbleStartup()
{
	// Create variables
	Ysp            = 0;
	WobbleOffset   = 0;
	PosX		   = 0;
	PosY		   = 0;
	FinalX		   = 0;
	FinalY		   = 0;
	Direction      = 0;
	ScreenPosition = [];
	
	// Set default position and speed
	PosX = x;
	PosY = y;
	Ysp  = -0.53125;
	
	// Set object depth
	object_set_depth(Player, true);
	
	// Set object active range
	object_set_range(RangeFar, TypeDelete);
}