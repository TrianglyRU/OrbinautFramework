/// @description Startup
// You can call your scripts in this editor
	
	PosX		   = x;
	PosY		   = y;
	Xsp			   = 0;
	Ysp			   = 0;
	Timer		   = 256;
	PickupTimeout  = 64;
	
	// Set object properties
	object_set_unload(FlagDelete);
	object_set_depth(Player, 0);
	object_set_hitbox(6, 6);