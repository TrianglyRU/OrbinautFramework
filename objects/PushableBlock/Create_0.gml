/// @description Startup
// You can write your code in this editor
	
	PosX      = x;
	PosY	  = y;
	Ysp		  = 0;
	Direction = 0;
	ClipTimer = 0;
	State	  = 0;
	
	// Set object properties
	object_set_unload(FlagReset);
	object_set_depth(Player, 0);
	object_set_solidbox(16, 16, false);