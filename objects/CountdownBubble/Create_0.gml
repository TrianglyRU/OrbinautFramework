/// @description Startup
// You can write your code in this editor
	
	PosX		   =  x;
	PosY		   =  y;
	Ysp			   = -0.53125;
	WobbleOffset   =  0;
	FinalX		   =  0;
	Direction      =  0;
	ScreenPosition =  [];
	
	// Set object properties
	object_set_unload(FlagDelete);
	object_set_depth(Player, 1);
	
	animation_play(sprite_index, [7, 7, 7, 7, 6, 6, 8, 8, 8, 8, 8, 8, 8], 12);