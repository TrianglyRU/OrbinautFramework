function ObjCountdownBubbleStartup()
{
	// Set blank values
	WobbleOffset   = 0;
	FinalX		   = 0;
	Direction      = 0;
	ScreenPosition = [];
	
	// Set other variables
	PosX = x;
	PosY = y;
	Ysp  = -0.53125;
	
	// Set object depth
	object_set_depth(Player, 1);
	
	// Set object unload type
	object_set_unload(TypeDelete);
	
	// Set animation
	animation_play(sprite_index, [7, 7, 7, 7, 6, 6, 8, 8, 8, 8, 8, 8, 8], 0, 12);
}