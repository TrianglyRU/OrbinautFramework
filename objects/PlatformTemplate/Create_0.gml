/// @description Startup
// You can write your code in this editor
	
	/* Variable Definitions	
	1. MovementType, default = "Stationary"
	*/
	
	OriginX   = x;
	OriginY	  = y;
	Weight    = 0;
	State     = 0;
	Timer     = 0;
	FallSpeed = 0;
	FallFlag  = false;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);