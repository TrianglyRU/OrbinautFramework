/// @description Startup
// You can call your scripts in this editor
	
	/* Variable Definitions	
	1. ID, default = 0		
	*/
	
	image_index = 1;
	State		= 0;
	Angle		= 180;
	
	// Set object properties
	object_set_unload(FlagPause);
	object_set_depth(Player, 0);
	object_set_triggerbox(-8, 8, -52, 52);