/// @description
// You can write your code in this editor
	
	Ysp            = -0.53125;
	BubbleType     = 0;	// 0 being small, 1 being medium, 2 being large
	WobbleOffset   = 0;
	Collected	   = 0;
	FinalX		   = 0;
	Direction      = 0;
	ScreenPosition = false;
	
	PosX   = x;
	PosY   = y;
	
	object_set_depth(Player, true);
	object_set_range(RangeClose, TypeDelete);